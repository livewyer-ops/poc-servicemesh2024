# Design Document

- [Design Document](#design-document)
  - [Overview](#overview)
  - [Introduction](#introduction)
  - [Environment Pre-requisites](#environment-pre-requisites)
    - [Test applications details](#test-applications-details)
    - [Scheduling](#scheduling)
  - [Product Details](#product-details)
    - [Istio](#istio)
    - [Cilium](#cilium)
    - [LinkerD](#linkerd)
  - [Test Approach](#test-approach)
    - [Network tests](#network-tests)
    - [Performance tests](#performance-tests)
    - [Product Deployment Evidence](#product-deployment-evidence)
    - [Operational Impact](#operational-impact)
  - [Technical Decisions Log](#technical-decisions-log)
  - [Technical Risks](#technical-risks)

## Overview

This Design Document will cover our approach for comparing the three chosen service mesh products, across a number of parameters.

- Contributor(s): Oleksandr
- Date Created: 20/02/2024
- Status: Approved
- Version: 1.1

## Introduction

The Proof of Concept (PoC) aims to compare the following service mesh tools:

- [Istio](https://istio.io)
- [LinkerD](https://linkerd.io)
- [Cilium](https://docs.cilium.io/en/latest/network/servicemesh)

It will involve comparison in the following areas:

- Deployment
- Configuration
- Maintenance
- Performance and connectivity
- Operational Impact

To guarantee the accuracy and fairness of our tests, we will adhere to these key principles:

- Uniform environments for all products
- Consistent test tooling
- Identical test parameters and load
- Similar configuration and the same standards for all products
- Versions and configurations are fixed during PoC

The [Technical Decisions Log](#technical-decisions-log) section will document all technical decisions, while [Technical Risks & Issues](#technical-risks--issues) section will document all risks and issues.

## Environment Pre-requisites

LWDE will be used to build Kubernetes clusters and deploy needed services on them.

Clusters will have the following configuration:

- Cloud provider: AWS EKS (refer to Decision-001)
- Region: `eu-west-2`
- Location: Europe (London)
- Nodes: 4 worker nodes type [c5.large](https://aws.amazon.com/ec2/instance-types/c5)
- Nodes communicate with each other via private network and have access to the Internet via NAT Gateway
- Node OS Image: Amazon Linux 2
- Kubernetes version: 1.28.7
- CNI: Cilium [v1.15.1](https://github.com/cilium/cilium/blob/v1.15.1/install/kubernetes/cilium/Chart.yaml) (refer to Decision-002)
- Preinstalled services and apps:
  - [cert-manager v1.14.3](https://artifacthub.io/packages/helm/cert-manager/cert-manager/1.14.3)
  - [external-dns 6.32.1](https://artifacthub.io/packages/helm/bitnami/external-dns/6.32.1)
  - [kube-prometheus-stack 44.2.1](https://artifacthub.io/packages/helm/prometheus-community/kube-prometheus-stack) with Prometheus and Grafana enabled

_Note: Helm chart version specified can be different from the actual app version_

The following applications will be used to test service meshes (refer to Decision-003):

- [Istio bookinfo](https://github.com/istio/istio/blob/master/samples/bookinfo/platform/kube/bookinfo.yaml)
- [podinfo 6.5.4](https://github.com/stefanprodan/podinfo/blob/master/charts/podinfo/Chart.yaml)

_Note: To simplify the deployment of the `Istio bookinfo` application it will be wrapped into a Helm chart._

### Test applications details

To provide additional extensibility of the test and cover load balancing details we will deploy 2 sets of test applications:

- Basic: 1 replica per application/service
- High availability: 2 replicas per application/service

### Scheduling

To ensure consistency across environments, all applications will be scheduled to specific nodes, ensuring that environments are fully identical.

Applications deployment schema:

- Worker node #1: used by supporting applications needed for this PoC. These applications include a list of `Preinstalled services and apps`
- Worker node #2: used by test applications
- Worker node #3: used by service mesh deployments
- Worker node #4: used by pods which will generate load on test applications

## Product Details

The following key principles will be applied to every product:

- installation using Helm charts
- the latest stable version used
- configuration is as similar as possible

Helm chart installation will be performed using Flux. All Helm charts will use the default values files, if custom values or templates are needed, they will be included in the `Operational Manual Update` document.

The following features should be enabled/installed:

- Service exposure (refer to Decision-004)
- Enforced mTLS

### Istio

**Prerequisites**

- Istio version: [1.20.3](https://github.com/istio/istio/releases/tag/1.20.3)
- [Istio prerequisites document](https://istio.io/latest/docs/setup/platform-setup/prerequisites) (refer to Risk-001)
- [Supported Kubernetes Versions](https://istio.io/latest/docs/releases/supported-releases/#support-status-of-istio-releases): `1.25 - 1.29`

**Installation**

Istio installation with Helm requires 2 Helm charts to be installed:

- [Istio base 1.20.3](https://github.com/istio/istio/blob/1.20.3/manifests/charts/base/Chart.yaml)
- [Istio discovery 1.20.3](https://github.com/istio/istio/blob/1.20.3/manifests/charts/istio-control/istio-discovery/Chart.yaml)

The aim of the `base` Helm chart is to deploy CRDs while `istiod` deploys all other resources to run the service mesh.

**Configuration**

Istio supports different types of Ingress resources. We will use Istio Gateway API to expose services from the Istio service mesh, as this is the recommended approach [mentioned in the docs](https://istio.io/latest/docs/tasks/traffic-management/ingress/kubernetes-ingress/#:~:text=Using%20a%20Gateway%2C%20rather%20than%20Ingress%2C%20is%20recommended%20to%20make%20use%20of%20the%20full%20feature%20set%20that%20Istio%20offers%2C%20such%20as%20rich%20traffic%20management%20and%20security%20features.).

Istio automatically enables mTLS in `permissive mode` for all workloads, [to enforce mTLS we should use `strict mode`](https://istio.io/latest/docs/tasks/security/authentication/mtls-migration).

### Cilium

**Prerequisites**

- Cilium version: [v1.15.1](https://github.com/cilium/cilium/tree/v1.15.1)
- [Cilium General Requirements](https://docs.cilium.io/en/stable/operations/system_requirements/#admin-system-reqs)
- [Cilium Service Mesh Prerequisites](https://docs.cilium.io/en/stable/network/servicemesh/ingress/#prerequisites)
- [Supported Kubernetes Versions](https://docs.cilium.io/en/stable/network/kubernetes/compatibility): `1.26 - 1.29`

**Installation**

Cilium is installed on LWDE clusters using Cluster API Helm provider, so the needed configuration will be provided via Flux `HelmChartProxies`.

Cilium installation with Helm requires only 1 Helm chart to be installed:

- [Cilium 1.15.1](https://github.com/cilium/cilium/blob/v1.15.1/install/kubernetes/cilium/Chart.yaml)

**Configuration**

Cilium supports mesh exposure using both Kubernetes Ingress and Gateway API. There is no recommended approach, so we will use the Gateway API as it provides more features and options.

Cilium doesn't provide automatic mTLS. To enable mTLS in Cilium we need [to enable SPIRE server](https://docs.cilium.io/en/latest/network/servicemesh/mutual-authentication/mutual-authentication) and set `authentication.mode = "required"`

### LinkerD

**Prerequisites**

- Linkerd version: [stable-2.14.9](https://github.com/linkerd/linkerd2/tree/stable-2.14.9)
- Linkerd prerequisites can be verified using [linkerd CLI](https://linkerd.io/2.14/reference/cli/check):
  - [The “pre-kubernetes-setup” checks](https://linkerd.io/2.14/tasks/troubleshooting/#pre-k8s)
  - [The “kubernetes-api” checks](https://linkerd.io/2.14/tasks/troubleshooting/#k8s-api)
  - [The “kubernetes-version” checks](https://linkerd.io/2.14/tasks/troubleshooting/#the-kubernetes-version-checks)
- [Supported Kubernetes Versions](https://linkerd.io/2.14/reference/k8s-versions): `1.21 - 1.28`
- [mTLS root certificates for Helm installation](https://linkerd.io/2.15/tasks/install-helm/#prerequisite-generate-identity-certificates)

**Installation**

LinkerD installation with Helm requires 2 Helm charts to be installed:

- [linkerd-crds 1.8.0](https://github.com/linkerd/linkerd2/blob/stable-2.14.9/charts/linkerd-crds/Chart.yaml)
- [linkerd-control-plane 1.16.10](https://github.com/linkerd/linkerd2/blob/stable-2.14.9/charts/linkerd-control-plane/Chart.yaml)

The aim of the `linkerd-crds` Helm chart is to deploy CRDs while `linkerd-control-plane` deploys all other resources to run the service mesh.

**Configuration**

To enable mesh for ingress traffic, Linkerd requires an ingress controller. Nginx ingress controller will be used to expose services from Linkerd service mesh.

Linkerd automatically enables mTLS in `permissive mode` for all workloads, to enforce it we need to use [Authorization Policy](https://linkerd.io/2.15/features/server-policy/#).

## Test Approach

The main purpose of the test is to replicate the most common use cases for service mesh usage and demonstrate a difference in their performance.
This test aims to simulate real-world scenarios to showcase differences before product implementation, rather than optimizing products or creating specific environments to improve performance.

Out tests will cover the following areas:

- Resource overhead under different load
- Response time and latency
- Maximum concurrent connections
- Maximum and medium RPS
- Different load starting points

A list of environments was created to cover all common use cases. Each environment represents the service mesh product and the way of service exposure. See the list below:

- Baseline: no service mesh, nginx ingress controller
- Istio-nginx: Istio service mesh, nginx ingress controller
- Cilium-nginx: Cilium service mesh, nginx ingress controller
- Linkerd-nginx: Linkerd service mesh, nginx ingress controller
- Istio-Gateway: Istio service mesh, Istio Gateway
- Cilium-Gateway: Cilium service mesh, Gateway API with cilium Gateway Class
- Linkerd-nginx-meshed: Linkerd service mesh, nginx ingress controller with mesh enabled

_Note: For cases where the nginx ingress controller is needed, the [ingress-nginx Helm chart version 4.10.0](https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.10.0) will be used to install the nginx ingress controller. Flux in LWDE will be used as a tool for Helm chart installation._

To easily consume the results of tests the below structure template will be used:

<details>
<summary>Template</summary>

```md
Environment:

Starting point -> Endpoint

Test application name:

Command: `<oha command>`

Success rate:

Response time:

- Slowest:
- Fastest:
- Average:

RPS:

CPU utilisation diagram of test application namespace
Memory utilisation diagram of test application namespace

CPU utilisation diagram of service mesh namespace
Memory utilisation diagram of service mesh namespace

CPU utilisation diagram of ingress controller namespace (for nginx cases)
Memory utilisation diagram of ingress controller namespace (for nginx cases)

[Full oha output](link)
```

</details>

### Network tests

The aim of network tests is to provide statistics about connections, delays, errors and latency.

Network tests consist of the following components,

- Benchmarking tool configuration
- Endpoints
- Starting points - Endpoints

Components can have different values or configurations, so there are subsections which include details about each component

**Benchmarking tool**

Network tests will be performed using [oha](https://github.com/hatoo/oha) benchmarking tool.

`oha` can provide the needed load for web applications and output useful results.

<details>
<summary>Example output</summary>

```txt
Summary:
  Success rate:	100.00%
  Total:	10.0029 secs
  Slowest:	0.7459 secs
  Fastest:	0.0376 secs
  Average:	0.4372 secs
  Requests/sec:	233.4321

  Total data:	10.56 MiB
  Size/request:	4.
  Size/sec:	1.06 MiB

Response time histogram:
  0.038 [1]    |
  0.108 [5]    |
  0.179 [2]    |
  0.250 [0]    |
  0.321 [8]    |
  0.392 [18]   |
  0.463 [2033] |■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
  0.533 [106]  |■
  0.604 [24]   |
  0.675 [24]   |
  0.746 [14]   |

Response time distribution:
  10.00% in 0.4176 secs
  25.00% in 0.4241 secs
  50.00% in 0.4321 secs
  75.00% in 0.4418 secs
  90.00% in 0.4562 secs
  95.00% in 0.4712 secs
  99.00% in 0.6471 secs
  99.90% in 0.7144 secs
  99.99% in 0.7459 secs


Details (average, fastest, slowest):
  DNS+dialup:	0.0006 secs, 0.0001 secs, 0.0009 secs
  DNS-lookup:	0.0000 secs, 0.0000 secs, 0.0000 secs

Status code distribution:
  [200] 2235 responses

Error distribution:
  [100] aborted due to deadline
```

</details>

**Configuration**

We will use the below `oha` command as a base:

`oha <test-app-url> -c $CONCURRENT_CONNECTIONS -z $TIME -q $QPS --latency-correction --disable-keepalive`

Environment variables values:

`CONCURRENT_CONNECTIONS`: 16, 64, 128  
`TIME`: 3m  
`QPS`: 500, 1000

The command will be iterated over `CONCURRENT_CONNECTIONS` and `QPS` environment variables, so we can get the combination of different parameters (e.g. `QPS=500, CONCURRENT_CONNECTIONS=16`; `QPS=500, CONCURRENT_CONNECTIONS=16`). Each test will last for 3 minutes, after each test all pods will be recreated to prepare the environment for the next test. Using these parameters we will be able to test different use cases and loads on our products.

Parameters are based on popular service mesh performance tests:

[Testing Service Mesh Performance in Multi-Cluster Scenario: Istio vs Kuma vs NSM](https://dev.to/pragmagic/testing-service-mesh-performance-in-multi-cluster-scenario-istio-vs-kuma-vs-nsm-4agj)

[Best Practices: Benchmarking Service Mesh Performance](https://istio.io/latest/blog/2019/performance-best-practices)

[Service Mesh Performance Evaluation — Istio, Linkerd, Kuma and Consul](https://medium.com/elca-it/service-mesh-performance-evaluation-istio-linkerd-kuma-and-consul-d8a89390d630)

[kinvolk/service-mesh-benchmark](https://github.com/kinvolk/service-mesh-benchmark/tree/master)

_Note: it's hard to identify the needed QPS for our environment, so the values can be changed once the environment is deployed_

**Endpoints**

This section shows the Endpoints of test applications that will be used for tests.

We don't aim to stress test applications, so the most basic paths were chosen to satisfy our needs.

- `/version` path in `podinfo` is a GET request to the application to output the value of the application version
- `/productpage?u=normal` path in `bookinfo` application is a GET request to the application to output a book review, which will be processed by one of the `review` instances

See below the full URLs:

- `https://<podinfo-url>/version`
- `https://<bookinfo-url>/productpage?u=normal`
- `https://<podinfo-ha-url>/version`
- `https://<bookinfo-ha-url>/productpage?u=normal`

\*_ha - high availability_

**Starting points - Endpoints**

_Refer to Decision-005_

To ensure a thorough comparison, tests will be performed using various locations and endpoints. The below list represents starting points and network interfaces of test applications for network tests:

<details>
<summary>Individual hosts:</summary>

- Separate VM in the same location as cluster nodes -> Ingress IP

</details>

<details>
<summary>Pods on the worker node #4:</summary>

- Pod outside the service mesh-> Service IP
- Pod inside the service mesh -> Service IP

</details>

### Performance tests

The aim of the performance tests is to capture the resource usage and pod errors during network tests.

Resource utilisation will be captured using Prometheus and visualised using Grafana dashboard.

All performance test results will be associated with respective network test results.

### Product Deployment Evidence

`Product Deployment Evidence` section of the Test report will contain different references, so it's clear that the environment was created and all products were deployed.

The following resources will be linked in `Product Deployment Evidence` section:

- clusters created using LWDE
- codebase created as part of the PoC
- documentation with the guide about products deployment

### Operational Impact

Service mesh implementation can have a big operational impact, so there are a lot of details that must be considered before implementing each product.
`Operational Impact` section of the Test Report will cover these details in the following areas:

- Difficulty of the product installation and implementation
- Tasks and routines needed to run the product
- Challenges in the procedure of integrating a new application into the mesh

In addition, we will provide a list of the challenges we faced during the PoC.

## Technical Decisions Log

| Ref ID       | Description                                                                                                                                                                                                                                                                                                                             | Impact if accepted                                        | Impact if Rejected                                                                                                  | Status   | Decision made by | Commentary             |
| ------------ | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | -------- | ---------------- | ---------------------- |
| Decision-001 | AWS EKS cluster was selected as the most common option in the organizations that enables us to access the node, configure the network, and reproduce the most common use-case                                                                                                                                                           | No negative impact                                        | Other options can be more expensive (GCP) or not have enough network configuration options (Virtink)                | Accepted | Walter           | Accepted on 06.03.2024 |
| Decision-002 | LWDE default Cilium CNI version is v1.12.2. It is compatible with all service meshes, but the support of Cilium Service mesh is at an early stage in this version, so to make tests fair, all service meshes should use the latest stable version of their product and all environments should use the same Cilium CNI version (latest) | Additional work needed                                    | Comparison will be unfair                                                                                           | Accepted | Walter           | Accepted on 23.02.2024 |
| Decision-003 | `podinfo` and `bookinfo` test apps were chosen to provide the fairest test results. `podinfo` is popular tool for testing and has a wide range of capabilities, while `bookinfo` app is used for service mesh tests and has multiple services inside, that allow us to test communication between them                                  | No negative impact                                        | Additional work needed to find a replacement                                                                        | Accepted | Walter           | Accepted on 23.02.2024 |
| Decision-004 | To perform extensive and fair testing different ways of service exposure should be used. For each service mesh product service exposure should be performed in 2 ways: using bare nginx ingress controller without mesh and using the way suggested by the product itself.                                                              | No negative impact                                        | The comparison can be unfair                                                                                        | Accepted | Walter           | Accepted on 11.03.2024 |
| Decision-005 | To cover the most common use cases short list of starting points and endpoints should be used. The most common use cases include connecting a pod to a service and connecting an external host to an ingress                                                                                                                            | Comparison will cover only the most common use cases      | Additional work needed to perform other tests                                                                       | Accepted | Walter           | Accepted on 11.03.2024 |
| Decision-006 | To properly setup mTLS in Cilium, we need to deploy SPIRE server to enable authentication and enable Wireguard Encryption to encrypt the traffic between pods                                                                                                                                                                           | The same features will be compared in all service meshes. | Comparison will be unfair because Wireguard Transparent Encryption provides different functionality and performance | Accepted | Walter           | Accepted on 11.03.2024 |

## Technical Risks

| Ref ID   | Description                                                                                                                                                                                      | Impact                                     | Priority | Severity | Mitigation                                                                      | Status | Commentary             |
| -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------ | -------- | -------- | ------------------------------------------------------------------------------- | ------ | ---------------------- |
| Risk-001 | Istio has a list of [needed kernel modules](https://istio.io/latest/docs/setup/platform-setup/prerequisites) when using iptables interception mode, but some of them are not loaded on our nodes | Istio won't be deployed on our environment | 2        | 2        | Ensure iptables interception mode is enabled and working once Istio is deployed | Closed | Successfully mitigated |
