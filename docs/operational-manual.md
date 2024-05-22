# Operational Manual

- [Operational Manual](#operational-manual)
  - [Overview](#overview)
  - [Shared cluster configuration](#shared-cluster-configuration)
  - [Istio Ambient](#istio-ambient)
    - [Installation](#installation)
    - [Day 2 Operations](#day-2-operations)
      - [Istio Ambient versions](#istio-ambient-versions)
      - [Monitoring](#monitoring)
      - [Uninstall](#uninstall)
  - [Istio Sidecar](#istio-sidecar)
    - [Installation](#installation-1)
    - [Day 2 Operations](#day-2-operations-1)
      - [Istio Sidecar versions](#istio-sidecar-versions)
      - [Monitoring](#monitoring-1)
      - [Uninstall](#uninstall-1)
  - [Cilium](#cilium)
    - [Cluster configuration](#cluster-configuration)
    - [Installation](#installation-2)
    - [Day 2 Operations](#day-2-operations-2)
      - [Cilium versions](#cilium-versions)
      - [Monitoring](#monitoring-2)
      - [Uninstall](#uninstall-2)
  - [Linkerd](#linkerd)
    - [Installation](#installation-3)
    - [Day 2 Operations](#day-2-operations-3)
      - [Linkerd versions](#linkerd-versions)
      - [Monitoring](#monitoring-3)
      - [Uninstall](#uninstall-3)
      - [Control plane TLS certificates](#control-plane-tls-certificates)
      - [Webhook TLS certificates](#webhook-tls-certificates)

## Overview

This document shows how to install different service meshes on AWS EKS cluster created using LWDE (to use other provider/creation methods make sure that the configuration meets product requirements).

- Contributor(s): Oleksandr
- Date Created: 18/03/2024
- Status: Approved
- Version: 1.0

## Shared cluster configuration

The following Flux `HelmRelease` template will be used to create clusters in LWDE. Depending on service mesh requirements, some values can be changed. Any changes will be highlighted in the `Cluster Configuration` subsection of the Product section.

<details><summary>HelmRelease manifest</summary>

```yaml
apiVersion: helm.toolkit.fluxcd.io/v2beta2
kind: HelmRelease
metadata:
  name: <cluster-name>
  namespace: flux-system
spec:
  chart:
    spec:
      chart: capi-aws-eks-cluster
      version: 0.1.6
      sourceRef:
        kind: HelmRepository
        name: lw-helm-charts-registry
  interval: 5m0s
  timeout: 15m0s
  targetNamespace: <cluster-name>
  releaseName: <cluster-name>
  install:
    createNamespace: true
  dependsOn:
    - name: capi-providers
  values:
    global:
      variables:
        targetEnv: lwde-production
        baseURL:
          sys: "<cluster-name>.sys.wyer.live"
          mgmt: "mgmt.wyer.live"
    apps:
      enabled: false
    machinePool:
      replicas: 2
    cluster:
      region: us-east-1
      addons:
        - conflictResolution: overwrite
          name: aws-ebs-csi-driver
          version: v1.28.0-eksbuild.1
        - conflictResolution: overwrite
          name: vpc-cni
          version: v1.16.3-eksbuild.2
        - conflictResolution: overwrite
          name: coredns
          version: v1.10.1-eksbuild.7
```

</details>

## Istio Ambient

This section provides instructions on how to install and operate Istio service mesh in Ambient mode.

### Installation

This subsection provides installation instructions for Istio Ambient. Following these instructions you will install Istio service mesh in Ambient mode and Istio Gateway.

1. Add Helm repo

   ```bash
   helm repo add istio https://istio-release.storage.googleapis.com/charts
   helm repo update
   ```

2. Install Istio CRDs

   ```bash
   helm install istio-base istio/base -n istio-system --create-namespace --wait
   ```

3. Install Istio CNI

   ```bash
   helm install istio-cni istio/cni -n istio-system --set profile=ambient --wait
   ```

4. Install Istio Discovery service

   ```bash
   helm install istiod istio/istiod -n istio-system --set profile=ambient --wait
   ```

5. Install Istio ztunnel

   ```bash
   helm install ztunnel istio/ztunnel -n istio-system --wait
   ```

6. Install Istio Ingress Gateway

   ```bash
    helm install istio-ingress istio/gateway -n istio-ingress --create-namespace --wait
   ```

7. Verify installation

   ```bash
   # Ensure pods are up and running
   kubectl get pods -n istio-system
   kubectl get pods -n istio-ingress
   # Ensure LoadBalancer service is created
   kubectl get svc -n istio-ingress istio-ingress
   ```

Refer to the [official documentation](https://istio.io/latest/docs/ambient/getting-started/#bookinfo) to test Istio Ambient features.

### Day 2 Operations

List of day 2 operations:

- [Istio Ambient versions](#istio-ambient-versions)
- [Monitoring](#monitoring)
- [Uninstall](#uninstall)

#### Istio Ambient versions

Refer to the official [Upgrade Guide](https://istio.io/latest/docs/ambient/upgrade/helm-upgrade/) for detailed instructions on upgrading.

#### Monitoring

Istio supports a wide variety of observability tools, you can find more details in [the official documentation](https://istio.io/latest/docs/tasks/observability).

#### Uninstall

Follow the below instructions to uninstall Istio:

1. Uninstall Istio Gateway

   ```bash
   helm delete istio-ingress -n istio-ingress
   ```

2. Uninstall Istio CNI

   ```bash
   helm delete istio-cni -n istio-system
   ```

3. Uninstall Istio ztunnel

   ```bash
   helm delete ztunnel -n istio-system
   ```

4. Uninstall Istio Discovery service

   ```bash
   helm delete istiod -n istio-system
   ```

5. Uninstall Istio CRDs

   ```bash
   helm delete istio-base -n istio-system
   ```

6. Delete remaining CRDs

   ```bash
   kubectl get crd -oname | grep --color=never 'istio.io' | xargs kubectl delete
   ```

7. Delete namespaces

   ```bash
   kubectl delete namespace istio-ingress
   kubectl delete namespace istio-system
   ```

## Istio Sidecar

This section provides instructions on how to install and operate Istio service mesh in Sidecar mode.

### Installation

This subsection provides installation instructions for Istio Sidecar. Following these instructions you will install Istio service mesh in Sidecar mode and Istio Gateway.

1. Add Helm repo

   ```bash
   helm repo add istio https://istio-release.storage.googleapis.com/charts
   helm repo update
   ```

2. Install Istio CRDs

   ```bash
   helm install istio-base istio/base -n istio-system --create-namespace --set defaultRevision=default
   ```

3. Install Istio Discovery service

   ```bash
   helm install istiod istio/istiod -n istio-system --wait
   ```

4. Install Istio Ingress Gateway

   ```bash
   helm install istio-ingress istio/gateway -n istio-ingress --create-namespace --wait
   ```

5. Verify installation

   ```bash
   # Ensure pods are up and running
   kubectl get pods -n istio-system
   kubectl get pods -n istio-ingress
   # Ensure LoadBalancer service is created
   kubectl get svc -n istio-ingress istio-ingress
   ```

Refer to the [official documentation](https://istio.io/latest/docs/setup/getting-started/#bookinfo) to test Istio features.

### Day 2 Operations

List of day 2 operations:

- [Istio Sidecar versions](#istio-sidecar-versions)
- [Monitoring](#monitoring-1)
- [Uninstall](#uninstall-1)

#### Istio Sidecar versions

Refer to the official [Upgrade Guide](https://istio.io/latest/docs/setup/upgrade) for detailed instructions on upgrading.

#### Monitoring

Istio supports a wide variety of observability tools, you can find more details in [the official documentation](https://istio.io/latest/docs/tasks/observability).

#### Uninstall

Follow the below instructions to uninstall Istio:

1. Uninstall Istio Gateway

   ```bash
   helm delete istio-ingress -n istio-ingress
   ```

2. Uninstall Istio Discovery service

   ```bash
   helm delete istiod -n istio-system
   ```

3. Uninstall Istio CRDs

   ```bash
   helm delete istio-base -n istio-system
   ```

4. Delete remaining CRDs

   ```bash
   kubectl get crd -oname | grep --color=never 'istio.io' | xargs kubectl delete
   ```

5. Delete namespaces

   ```bash
   kubectl delete namespace istio-ingress
   kubectl delete namespace istio-system
   ```

## Cilium

This section provides instructions on how to install and operate Cilium service mesh.

### Cluster configuration

To install Cilium and enable Cilium service mesh on AWS EKS Cluster, the cluster should meet the following requirements:

- Disabled default AWS VPC CNI and respective addon
- Disabled kube proxy
- Cluster supports Persistent Storage (local/cloud)

The below changes were made to the Helm release template to create AWS EKS cluster using LWDE:

<details><summary>YAML</summary>

```yaml
spec:
  values:
    cluster:
      vpcCni:
        disable: true
      kubeProxy:
        disable: true
      addons:
        - conflictResolution: overwrite
          name: aws-ebs-csi-driver
          version: v1.28.0-eksbuild.1
        - conflictResolution: overwrite
          name: coredns
          version: v1.10.1-eksbuild.7
```

</details>

### Installation

This section shows how to install Cilium service mesh, as part of this installation we will also enable Cilium Gateway API controller and mTLS features.

_Note: Cilium recommends us [to taint Managed Nodes Group](https://docs.cilium.io/en/stable/installation/k8s-install-helm/#:~:text=The%20EKS%20Managed%20Nodegroups%20must%20be%20properly%20tainted%20to%20ensure%20applications%20pods%20are%20properly%20managed%20by%20Cilium%3A), so Cilium works properly, but it is not necessary, as the below setup was tested and works properly too._

Below you can find step-by-step instructions for deploying Cilium Service Mesh on a brand new AWS EKS cluster.

1. Deploy Gateway API CRDs:

   ```bash
   kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_gatewayclasses.yaml
   kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_gateways.yaml
   kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_httproutes.yaml
   kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_referencegrants.yaml
   kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/experimental/gateway.networking.k8s.io_grpcroutes.yaml
   kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/experimental/gateway.networking.k8s.io_tlsroutes.yaml
   ```

2. Install local-path-provisioner:

   ```bash
   git clone https://github.com/rancher/local-path-provisioner.git
   cd local-path-provisioner
   helm install local-path-storage --namespace local-path-storage ./deploy/chart/local-path-provisioner --create-namespace --set storageClass.defaultClass=true

   # Verify installation
   kubectl get pods -n local-path-storage
   kubectl get storageClass local-path
   ```

3. Patch `aws-node` DaemonSet to prevent conflict behavior:

   ```bash
   kubectl -n kube-system patch daemonset aws-node --type='strategic' -p='{"spec":{"template":{"spec":{"nodeSelector":{"io.cilium/aws-node-enabled":"true"}}}}}'
   ```

4. Add Helm repo

   ```bash
   helm repo add cilium https://helm.cilium.io/
   helm repo update
   ```

5. Deploy Cilium with the needed configuration:

   ```bash
   # Value of API_SERVER_IP variable is public IP or hostname of your API Server
   API_SERVER_IP=<api server endpoint>
   API_SERVER_PORT=443
   helm upgrade --install cilium cilium/cilium --version 1.15.1 \
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
   ```

   _Note: Cilium suggests us [to enable Wireguard encryption](https://docs.cilium.io/en/latest/network/servicemesh/mutual-authentication/mutual-authentication/#mutual-authentication-in-cilium) to meet most of the common requirements_

6. Verify Cilium installation:

   ```bash
   cilium status
   ```

7. Once all pods are up and running, run connectivity test to ensure everything works properly:

   ```bash
   cilium connectivity test
   ```

8. Ensure Wireguard is enabled:

   ```bash
   kubectl -n kube-system exec -ti ds/cilium -- bash
   cilium-dbg status | grep Encryption
   ```

9. Ensure `SPIRE` server is healthy:

   ```bash
   kubectl exec -n cilium-spire spire-server-0 -c spire-server -- /opt/spire/bin/spire-server healthcheck
   ```

Troubleshooting: if you faced problems during installation, please refer to the Troubleshooting commands in the official documentation for the respective topic. A wide list of troubleshooting commands is also provided on this [troubleshooting page](https://docs.cilium.io/en/latest/operations/troubleshooting/#service-mesh-troubleshooting)

Additionally, you can follow these official examples to test the functionality of enabled features:

- [Gateway API](https://docs.cilium.io/en/latest/network/servicemesh/gateway-api/gateway-api/#examples)
- [mTLS](https://docs.cilium.io/en/latest/network/servicemesh/mutual-authentication/mutual-authentication-example)
- [Wireguard](https://docs.cilium.io/en/latest/security/network/encryption-wireguard/#validate-the-setup)

### Day 2 Operations

List of day 2 operations:

- [Cilium versions](#cilium-versions)
- [Monitoring](#monitoring-1)
- [Uninstall](#uninstall-1)

#### Cilium versions

Refer to the official [Upgrade Guide](https://docs.cilium.io/en/latest/operations/upgrade) for detailed instructions on upgrading.

#### Monitoring

By default Cilium supports metrics collection using Prometheus and Hubble, refer to the [Observability page](https://docs.cilium.io/en/stable/observability/metrics) to get more details.

#### Uninstall

We can't fully uninstall Cilium as it's cluster CNI and replaces kube proxy, so the below instructions show how to disable Cilium service mesh and uninstall Cilium prerequisites

1. Upgrade Cilium:

   ```bash
   # Value of API_SERVER_IP variable is public IP or hostname of your API Server
   API_SERVER_IP=<api server endpoint>
   API_SERVER_PORT=443
   helm upgrade --install cilium cilium/cilium --version 1.15.1 \
     --namespace kube-system \
     --set eni.enabled=true \
     --set ipam.mode=eni \
     --set egressMasqueradeInterfaces=eth0 \
     --set routingMode=native \
     --set kubeProxyReplacement=true \
     --set k8sServiceHost=${API_SERVER_IP} \
     --set k8sServicePort=${API_SERVER_PORT} \
     --set gatewayAPI.enabled=false \
     --set authentication.mutual.spire.enabled=false \
     --set authentication.mutual.spire.install.enabled=false \
     --set encryption.enabled=false \
     --set encryption.nodeEncryption=false

   # Restart pods
   kubectl -n kube-system rollout restart deployment/cilium-operator
   kubectl -n kube-system rollout restart ds/cilium
   ```

2. Delete Gateway CRDs

   ```bash
   kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_gatewayclasses.yaml
   kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_gateways.yaml
   kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_httproutes.yaml
   kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/standard/gateway.networking.k8s.io_referencegrants.yaml
   kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/experimental/gateway.networking.k8s.io_grpcroutes.yaml
   kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/gateway-api/v1.0.0/config/crd/experimental/gateway.networking.k8s.io_tlsroutes.yaml
   ```

3. Uninstall local-path-provisioner

   ```bash
   helm uninstall local-path-storage --namespace local-path-storage
   ```

4. Run connectivity test to ensure Cilium works properly

   ```bash
   cilium connectivity test
   ```

## Linkerd

This section provides instructions on how to install and operate Linkerd service mesh.

### Installation

This subsection provides installation instructions for Linkerd. Following these instructions you will install prerequisites for Linkerd and Linkerd Control Plane.

1. Prepare local environment

   Add Helm repos

   ```bash
   helm repo add linkerd https://helm.linkerd.io/stable
   helm repo add jetstack https://charts.jetstack.io --force-update
   helm repo update
   ```

   Clone `poc-servicemesh2024` GitHub repo

   ```bash
   git clone https://github.com/livewyer-ops/poc-servicemesh2024.git
   ```

2. Install `cert-manager`

   ```bash
   helm upgrade -i \
     cert-manager jetstack/cert-manager \
     --namespace cert-manager \
     --create-namespace \
     --version v1.14.3 \
     --set installCRDs=true

   # Ensure pods are up and running
   kubectl get pods -n cert-manager
   ```

3. Install trust-manager

   ```bash
   helm upgrade -i -n cert-manager trust-manager jetstack/trust-manager --wait

   # Ensure pods are up and running
   kubectl get pods -n cert-manager
   ```

4. Install Linkerd CRDs

   ```bash
   helm upgrade -i linkerd-crds linkerd/linkerd-crds \
     -n linkerd --create-namespace --version 1.8.0
   ```

5. Install Bootstrap CA Helm chart

   ```bash
   cd poc-servicemesh2024
   helm upgrade -i -n cert-manager bootstrap-ca ./charts/bootstrap-ca --wait

   # Ensure trust anchor configmap is created
   kubectl get cm -n linkerd linkerd-identity-trust-roots
   ```

6. Install Linkerd Control plane

   ```bash
   helm upgrade -i linkerd-control-plane \
     -n linkerd \
     --set identity.externalCA=true \
     --set identity.issuer.scheme=kubernetes.io/tls \
     linkerd/linkerd-control-plane --version 1.16.11
   ```

7. Verify Linkerd installation and mTLS on Linkerd pods

   ```bash
   linkerd check
   linkerd viz -n linkerd edges deployment
   ```

Refer to the [official documentation](https://linkerd.io/2.15/getting-started/#step-4-install-the-demo-app) to test Linkerd features

### Day 2 Operations

List of day 2 operations:

- [Linkerd versions](#linkerd-versions)
- [Monitoring](#monitoring-2)
- [Uninstall](#uninstall-2)
- [Control plane TLS certificates](#control-plane-tls-certificates)
- [Webhook TLS certificates](#webhook-tls-certificates)

Additionally, [here are some tips to keep in mind before introducing Linkerd in production](https://docs.buoyant.io/runbook/getting-started).

#### Linkerd versions

Refer to the official [Upgrade Guide](https://linkerd.io/2.15/tasks/upgrade) for detailed instructions on upgrading.

#### Monitoring

Linkerd has a `viz` extension, that uses Prometheus as a scraping tool and allows us to deploy a [Linkerd Dashboard](https://linkerd.io/2.15/features/dashboard) and watch service mesh metrics.

Additionally, Linkerd supports different observability configurations such as:

- [Export metrics to Grafana](https://linkerd.io/2.15/tasks/grafana)
- [Collect Linkerd metrics](https://linkerd.io/2.15/tasks/exporting-metrics)
- [External Prometheus](https://linkerd.io/2.15/tasks/external-prometheus)

#### Uninstall

Follow the below instructions to uninstall Linkerd and prerequisites:

1. Uninstall Linkerd Control Plane

   ```bash
   helm uninstall linkerd-control-plane -n linkerd
   ```

2. Uninstall Linkerd CRDs

   ```bash
   helm uninstall linkerd-crds -n linkerd
   ```

3. Delete Issuers and Certificates

   ```bash
   helm uninstall bootstrap-ca -n cert-manager
   ```

4. Uninstall Trust Manager

   ```bash
   helm uninstall trust-manager -n cert-manager
   ```

5. Uninstall Cert Manager

   ```bash
   # Delete CRs
   kubectl get Issuers,ClusterIssuers,Certificates,CertificateRequests,Orders,Challenges --all-namespaces
   # Uninstall helm release
   helm --namespace cert-manager delete cert-manager
   ```

6. Delete namespaces

   ```bash
   kubectl delete namespace cert-manager
   kubectl delete namespace linkerd
   kubectl delete crd bundles.trust.cert-manager.io
   ```

#### Control plane TLS certificates

Using the above installation method we automated a part of the Control plane TLS certificates management, but we still need to renew Trust Anchor once it is about to expire. [You can refer to this doc](https://linkerd.io/2.15/tasks/manually-rotating-control-plane-tls-credentials) to get an understanding of Trust Anchor rotation process. Regarding the complexity of this process, [Linkerd recommends using a trust anchor with a 10-year expiration period](https://docs.buoyant.io/runbook/going-to-production/#set-up-your-mtls-certificate-rotation-and-alerting).

#### Webhook TLS certificates

Linkerd automatically renews Webhook TLS certificates after each update, but you can [delegate this task](https://linkerd.io/2.15/tasks/automatically-rotating-webhook-tls-credentials) or [rotate them manually](https://linkerd.io/2.15/tasks/rotating_webhooks_certificates) as explained in the official documentation.
