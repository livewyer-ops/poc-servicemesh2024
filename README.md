![LiveWyer Banner](./.github/img/github-banner.png?raw=true)

<p align="center">
    <a href="https://livewyer.io" ><img src="https://badgen.net/badge/Website/livewyer.io" alt="LiveWyer Website badge" /></a>
    <a href="https://twitter.com/LiveWyerUK"><img src="https://badgen.net/badge/twitter/@LiveWyerUK" alt="Twitter badge" /></a>
    <a href="https://www.linkedin.com/company/livewyer"><img src="https://badgen.net/badge/LinkedIn/LiveWyer" alt="LinkedIn badge" /></a>
</p>

<h1 align="center">A full comparison of three service mesh solutions</h1>

This repository serves as the central storage for all the codebase and documentation related to Service Mesh / eBPF Product Comparison.

The purpose of this study was to provide a reliable comparison of three available service mesh options to determine the best. We aimed to compare and share our experience on three popular open-source service meshes: Cilium, Linkerd and Istio (Sidecar and Ambient).
This comparison covers the following areas:

- Deployment
- Configuration
- Maintenance
- Performance and Connectivity
- Operational Impact
- Compliance and Standards

This exercise was performed using our internal development platform, LWDE (Livewyer Development Environment), to expedite and simplify the environment setup process.

## :pencil: Deliverables

- [Design Document](docs/design-document.md)
- [Operational Manual](docs/operational-manual.md)
- Test Reports:
  - [Test Report - Istio vs Linkerd vs Cilium](docs/test-report.md)
  - [Test Report - Istio Ambient vs Istio Sidecar](docs/test-report-istio.md)
- Blog Posts:
  - [Service Meshes Decoded: a performance comparison of Istio vs Linkerd vs Cilium](https://livewyer.io/blog/2024/05/08/comparison-of-service-meshes)
  - [Service Meshes Decoded Part Two: Is Istio Ambient worth it?](https://livewyer.io/blog/2024/06/06/comparison-of-service-meshes-part-two)

## :warning: Disclaimer

The results of this technical proof of concept (PoC) are provided "as is" for informational purposes only. LiveWyer disclaim all liability for any errors, omissions, or damages which may arise from using the results of this PoC. Users are advised to independently verify the PoC’s relevance and applicability to their needs, and are not responsible for any third-party content linked within this repo.

Using the data, results or contributing to this repo signifies acceptance of these terms.

## :jigsaw: Contributing

We value your feedback and suggestions!
If you have any ideas or want to report issues, please create an [issue](https://github.com/livewyer-ops/poc-servicemesh2024/issues/new/choose).
Additionally, you can submit your contributions by opening a [pull request](https://github.com/livewyer-ops/poc-servicemesh2024/pulls).

---

Copyright © 2024 LiveWyer, Licensed under the `MIT` License; you may not use this file except in compliance with the [License](LICENSE).

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations under the [License](LICENSE).
