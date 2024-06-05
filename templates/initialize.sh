#!/usr/bin/env bash
#
# Prepare AWS EKS Cluster and deploy service mesh

# Safe scripting
set -euo pipefail

CLUSTER_NAME=
CILIUM_API_SERVER_IP=

initialize() {
  # Wait for the cluster
  echo "Waiting for the cluster to become ready..."
  kubectl -n "$CLUSTER_NAME" wait cluster "$CLUSTER_NAME" --for=jsonpath='{.status.conditions[2].status}=True' --timeout="900s"

  # Add user and fetch kubeconfig
  echo "Fetching kubeconfig..."
  kubectl --namespace="$CLUSTER_NAME" get secret "$CLUSTER_NAME-kubeconfig" -o jsonpath='{.data.value}' | base64 --decode >managed-test.kubeconfig
  kubectl --kubeconfig managed-test.kubeconfig patch configmap -n kube-system aws-auth -p '{"data":{"mapUsers":"[{\"userarn\": \"arn:aws:iam::000000000000:user/lw-oleksandr\", \"username\": \"lw-oleksandr\", \"groups\": [\"system:masters\"]}, {\"userarn\": \"arn:aws:iam::000000000000:user/lw-walter\", \"username\": \"lw-walter\", \"groups\": [\"system:masters\"]}]"}}'
  
  aws eks update-kubeconfig --name "$CLUSTER_NAME"_"$CLUSTER_NAME"-control-plane

  # Patch AWS Node DS
  # echo "Patching aws-node daemonset..."
  # kubectl -n kube-system patch daemonset aws-node --type='strategic' -p='{"spec":{"template":{"spec":{"nodeSelector":{"io.cilium/aws-node-enabled":"true"}}}}}'
}

taints() {
  # Taint nodes
  echo "Adding taints to nodes..."
  taints=("type=test-applications:NoSchedule" "type=load-testing:NoSchedule" "type=preinstalled-apps:NoSchedule" "type=service-mesh:NoSchedule")
  nodes=()
  for node in $(kubectl get nodes -o name); do
    nodes+=("${node##*/}")
  done
  for index in ${!nodes[*]}; do
    kubectl taint nodes ${nodes[$index]} ${taints[$index]}
  done
}

restart-pods() {
  # Restart all pods
  echo "Restarting pods..."
  kubectl delete pods --all -A

  # Wait for pods
  echo "Waiting for pods..."
  kubectl wait --for=condition=Ready pods --all --all-namespaces --timeout 600s
}

prerequisites() {
  initialize
  taints
  restart-pods
}

# Deploy service mesh
istio_ambient() {
  # Istio
  echo "Starting Istio deployment..."
  helm repo add istio https://istio-release.storage.googleapis.com/charts
  helm repo update

  echo "Installing Istio CRDs..."
  helm upgrade --install istio-base istio/base -n istio-system --create-namespace --set defaultRevision=default --version 1.22.0 

  echo "Installing Istio CNI..."
  helm upgrade --install istio-cni istio/cni -n istio-system --set profile=ambient --wait --version 1.22.0

  echo "Installing Istio Discovery Service..."
  helm upgrade --install istiod istio/istiod -n istio-system --set profile=ambient --wait --version 1.22.0 \
    --set defaults.pilot.tolerations[0].key=type \
    --set-string defaults.pilot.tolerations[0].value=service-mesh \
    --set defaults.pilot.tolerations[0].operator=Equal \
    --set defaults.pilot.tolerations[0].effect=NoSchedule \
    --set defaults.pilot.resources.requests.memory=1024Mi

  echo "Installing Istio ztunnel..."
  helm upgrade --install ztunnel istio/ztunnel -n istio-system --wait --version 1.22.0 \
    --set defaults.resources.requests.memory=1024Mi

  kubectl wait --for=condition=Ready pods --all -n istio-system

  # Can be disabled for some cases
  echo "Installing Istio Gateway..."
  helm install istio-ingress istio/gateway -n istio-ingress --create-namespace --wait --version 1.22.0 \
    --set defaults.tolerations[0].key=type \
    --set-string defaults.tolerations[0].value=service-mesh \
    --set defaults.tolerations[0].operator=Equal \
    --set defaults.tolerations[0].effect=NoSchedule

  kubectl wait --for=condition=Ready pods --all -n istio-ingress
}

istio_sidecar() {
  # Istio
  echo "Starting Istio deployment..."
  helm repo add istio https://istio-release.storage.googleapis.com/charts
  helm repo update

  echo "Installing Istio CRDs..."
  helm upgrade --install istio-base istio/base -n istio-system --create-namespace --set defaultRevision=default --version 1.22.0 

  echo "Installing Istio Discovery Service..."
  helm upgrade --install istiod istio/istiod -n istio-system --wait --version 1.22.0 \
    --set defaults.pilot.tolerations[0].key=type \
    --set-string defaults.pilot.tolerations[0].value=service-mesh \
    --set defaults.pilot.tolerations[0].operator=Equal \
    --set defaults.pilot.tolerations[0].effect=NoSchedule
  kubectl wait --for=condition=Ready pods --all -n istio-system

  # Can be disabled for some cases
  echo "Installing Istio Gateway..."
  helm install istio-ingress istio/gateway -n istio-ingress --create-namespace --wait --version 1.22.0 \
    --set defaults.tolerations[0].key=type \
    --set-string defaults.tolerations[0].value=service-mesh \
    --set defaults.tolerations[0].operator=Equal \
    --set defaults.tolerations[0].effect=NoSchedule

  kubectl wait --for=condition=Ready pods --all -n istio-ingress
}

cilium() {
  # Cilium
  echo "Starting Cilium deployment..."
  echo "Applying Gateway API CRDs..."
  kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_gatewayclasses.yaml
  kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_gateways.yaml
  kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_httproutes.yaml
  kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_referencegrants.yaml
  kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/experimental/gateway.networking.k8s.io_grpcroutes.yaml
  kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/experimental/gateway.networking.k8s.io_tlsroutes.yaml

  echo "Installing local-path-provisioner..."
  git clone https://github.com/rancher/local-path-provisioner.git
  helm upgrade --install local-path-storage --namespace local-path-storage ./local-path-provisioner/deploy/chart/local-path-provisioner --create-namespace --set storageClass.defaultClass=true \
    --set tolerations[0].key=type \
    --set-string tolerations[0].value=preinstalled-apps \
    --set tolerations[0].operator=Equal \
    --set tolerations[0].effect=NoSchedule

  helm repo add cilium https://helm.cilium.io/
  helm repo update

  echo "Upgrading Cilium deployment..."
  # Value of API_SERVER_IP variable is public IP or hostname of your API Server
  API_SERVER_IP=$CILIUM_API_SERVER_IP
  API_SERVER_PORT=443
  helm upgrade --install cilium cilium/cilium --version 1.15.1 --values templates/tolerations.yaml \
    --namespace kube-system \
    --set eni.enabled=true \
    --set ipam.mode=eni \
    --set egressMasqueradeInterfaces=eth0 \
    --set routingMode=native \
    --set kubeProxyReplacement=true \
    --set k8sServiceHost=${API_SERVER_IP} \
    --set k8sServicePort=${API_SERVER_PORT} \
    --set gatewayAPI.enabled=true \
    --set authentication.mutual.spire.enabled=true \
    --set authentication.mutual.spire.install.enabled=true \
    --set authentication.mutual.spire.install.server.dataStorage.storageClass=local-path \
    --set encryption.enabled=true \
    --set encryption.type=wireguard \
    --set encryption.nodeEncryption=true

  kubectl -n kube-system rollout restart deployment/cilium-operator
  kubectl -n kube-system rollout restart ds/cilium

}

linkerd() {
  #Linkerd
  echo "Starting Linkerd deployment..."
  helm repo add linkerd https://helm.linkerd.io/stable
  helm repo add jetstack https://charts.jetstack.io
  helm repo update

  #Cert manager is already installed
  #helm upgrade -i \
  #  cert-manager jetstack/cert-manager \
  #  --namespace cert-manager \
  #  --create-namespace \
  #  --version v1.14.3 \
  #  --set installCRDs=true
  #kubectl wait --for=condition=Ready pods --all -n cert-manager

  echo "Installing trust-manager..."
  helm upgrade -i -n cert-manager trust-manager jetstack/trust-manager --wait \
    --set tolerations[0].key=type \
    --set-string tolerations[0].value=preinstalled-apps \
    --set tolerations[0].operator=Equal \
    --set tolerations[0].effect=NoSchedule
  kubectl wait --for=condition=Ready pods --all -n cert-manager

  echo "Installing Linkerd CRDs..."
  helm upgrade -i linkerd-crds linkerd/linkerd-crds \
    -n linkerd --create-namespace --version 1.8.0

  echo "Installing Trust Anchor and Issuers..."
  helm upgrade -i -n cert-manager bootstrap-ca ./charts/bootstrap-ca --wait

  echo "Installing Linkerd Control Plane..."
  helm upgrade -i linkerd-control-plane \
    -n linkerd linkerd/linkerd-control-plane --version 1.16.11 \
    --set identity.externalCA=true \
    --set identity.issuer.scheme=kubernetes.io/tls \
    --set tolerations[0].key=type \
    --set-string tolerations[0].value=service-mesh \
    --set tolerations[0].operator=Equal \
    --set tolerations[0].effect=NoSchedule

}

# Define list of arguments expected in the input
optstring="ascl"

# Get the options (arguments)
while getopts "$optstring" arg; do
  case $arg in
  a)
    prerequisites
    istio_ambient
    exit 0
    ;;
  s)
    prerequisites
    istio_sidecar
    exit 0
    ;;
  c)
    prerequisites
    cilium
    exit 0
    ;;
  l)
    prerequisites
    linkerd
    exit 0
    ;;
  esac
done

exit 2
