# Network Test

oha Configuration: Concurrent connections=16, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  |  64.9166 secs | 137.7044 | 50.00% in 64.7010 secs | 90.00% in 117.2130 secs   |
| Cilium    |  67.7939 secs | 122.7660 | 50.00% in 67.5146 secs | 90.00% in 122.1640 secs   |
| Istio     |  67.1883 secs | 128.2659 | 50.00% in 67.3851 secs | 90.00% in 120.5111 secs   |
| :heavy_check_mark: Linkerd   |  63.5306 secs | 146.0316 | 50.00% in 63.3826 secs | 90.00% in 114.5959 secs   |

oha Configuration: Concurrent connections=16, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  |  77.5363 secs | 137.4767 | 50.00% in 77.6484 secs | 90.00% in 139.6472 secs   |
| Cilium    |  79.3235 secs | 122.5548 | 50.00% in 79.7327 secs | 90.00% in 142.1245 secs   |
| Istio     |  78.4987 secs | 128.7934 | 50.00% in 78.3469 secs | 90.00% in 141.2707 secs   |
| :heavy_check_mark: Linkerd   |  76.7250 secs | 146.7439 | 50.00% in 76.6357 secs | 90.00% in 138.2092 secs   |

oha Configuration: Concurrent connections=64, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  |  66.2586 secs | 132.5926 | 50.00% in 66.3884 secs | 90.00% in 119.0842 secs   |
| Cilium    |  68.9152 secs | 118.2769 | 50.00% in 68.9599 secs | 90.00% in 123.7830 secs   |
| Istio     |  67.6948 secs | 125.7093 | 50.00% in 67.8016 secs | 90.00% in 121.3919 secs   |
| :heavy_check_mark: Linkerd   |  64.6333 secs | 141.1489 | 50.00% in 64.5552 secs | 90.00% in 116.1763 secs   |

oha Configuration: Concurrent connections=64, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  |  78.5041 secs | 132.7375 | 50.00% in 78.8382 secs | 90.00% in 140.8563 secs   |
| Cilium    |  79.7957 secs | 118.4376 | 50.00% in 80.0527 secs | 90.00% in 142.9471 secs   |
| Istio     |  79.0197 secs | 125.8466 | 50.00% in 78.8344 secs | 90.00% in 141.7104 secs   |
| :heavy_check_mark: Linkerd   |  77.5864 secs | 141.0714 | 50.00% in 77.6900 secs | 90.00% in 139.0989 secs   |

oha Configuration: Concurrent connections=128, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 66.8695 secs | 132.0300 | 50.00% in 67.0561 secs | 90.00% in 119.6809 secs    |
| Cilium    | 68.8683 secs | 117.5931 | 50.00% in 68.7134 secs | 90.00% in 123.9449 secs    |
| Istio     | 68.3446 secs | 124.1401 | 50.00% in 68.2380 secs | 90.00% in 121.9729 secs    |
| :heavy_check_mark: Linkerd   | 65.6272 secs | 139.0685 | 50.00% in 65.7620 secs | 90.00% in 117.0189 secs    |

oha Configuration: Concurrent connections=128, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 78.4874 secs | 130.4818 | 50.00% in 77.9946 secs | 90.00% in 141.2844 secs    |
| Cilium    | 80.1320 secs | 116.5919 | 50.00% in 80.2502 secs | 90.00% in 143.4786 secs    |
| Istio     | 79.6302 secs | 123.2767 | 50.00% in 79.7587 secs | 90.00% in 142.4437 secs    |
| :heavy_check_mark: Linkerd   | 77.8664 secs | 138.9043 | 50.00% in 77.8998 secs | 90.00% in 139.3729 secs    |