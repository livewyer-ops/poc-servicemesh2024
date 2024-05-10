# Network Test

oha Configuration: Concurrent connections=16, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  |  0.0017 secs | 499.9964 | 50.00% in 0.0016 secs | 90.00% in 0.0018 secs   |
| Cilium    |  0.0019 secs | 499.9975 | 50.00% in 0.0017 secs | 90.00% in 0.0019 secs   |
| Istio     |  0.0023 secs | 499.9980 | 50.00% in 0.0014 secs | 90.00% in 0.0016 secs   |
| :heavy_check_mark: Linkerd   |  0.0007 secs | 499.9967 | 50.00% in 0.0006 secs | 90.00% in 0.0007 secs   |

oha Configuration: Concurrent connections=16, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 0.0050 secs | 999.9960 | 50.00% in 0.0017 secs | 90.00% in 0.0114 secs    |
| Cilium    | 0.0026 secs | 999.9962 | 50.00% in 0.0022 secs | 90.00% in 0.0026 secs    |
| Istio     | 26.2045 secs | 710.8623 | 50.00% in 26.1862 secs | 90.00% in 47.0617 secs    |
| :heavy_check_mark: Linkerd   | 0.0008 secs | 999.9968 | 50.00% in 0.0007 secs | 90.00% in 0.0009 secs    |

oha Configuration: Concurrent connections=64, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  |  0.0017 secs | 499.9957 | 50.00% in 0.0016 secs | 90.00% in 0.0018 secs   |
| Cilium    |  0.0018 secs | 499.9968 | 50.00% in 0.0017 secs | 90.00% in 0.0019 secs   |
| Istio     |  0.0015 secs | 499.9976 | 50.00% in 0.0014 secs | 90.00% in 0.0016 secs   |
| :heavy_check_mark: Linkerd   |  0.0007 secs | 499.9965 | 50.00% in 0.0006 secs | 90.00% in 0.0007 secs   |

oha Configuration: Concurrent connections=64, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  |  0.0065 secs | 999.9918 | 50.00% in 0.0017 secs | 90.00% in 0.0122 secs   |
| Cilium    |  0.0026 secs | 999.9952 | 50.00% in 0.0022 secs | 90.00% in 0.0026 secs   |
| Istio     |  19.6506 secs | 783.4441 | 50.00% in 19.5900 secs | 90.00% in 35.4043 secs   |
| :heavy_check_mark: Linkerd   |  0.0008 secs | 999.9959 | 50.00% in 0.0007 secs | 90.00% in 0.0009 secs   |

oha Configuration: Concurrent connections=128, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 0.0017 secs | 499.9951 | 50.00% in 0.0015 secs | 90.00% in 0.0018 secs    |
| Cilium    | 0.0019 secs | 499.9956 | 50.00% in 0.0017 secs | 90.00% in 0.0020 secs    |
| Istio     | 0.0015 secs | 499.9973 | 50.00% in 0.0014 secs | 90.00% in 0.0016 secs    |
| :heavy_check_mark: Linkerd   | 0.0007 secs | 499.9973 | 50.00% in 0.0006 secs | 90.00% in 0.0007 secs    |

oha Configuration: Concurrent connections=128, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  |  0.0084 secs | 999.9940 | 50.00% in 0.0017 secs | 90.00% in 0.0146 secs   |
| Cilium    |  0.0026 secs | 999.9935 | 50.00% in 0.0022 secs | 90.00% in 0.0026 secs   |
| Istio     |  19.7052 secs | 784.1596 | 50.00% in 19.4553 secs | 90.00% in 35.3092 secs   |
| :heavy_check_mark: Linkerd   |  0.0008 secs | 999.9948 | 50.00% in 0.0007 secs | 90.00% in 0.0009 secs   |