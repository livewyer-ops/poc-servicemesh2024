# Network Test

oha Configuration: Concurrent connections=16, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 0.0017 secs | 499.9957 | 50.00% in 0.0015 secs | 90.00% in 0.0018 secs    |
| Cilium    | 0.0019 secs | 499.9965 | 50.00% in 0.0017 secs | 90.00% in 0.0020 secs    |
| Istio     | 0.0018 secs | 499.9966 | 50.00% in 0.0014 secs | 90.00% in 0.0016 secs    |
| :heavy_check_mark: Linkerd   | 0.0007 secs | 499.9976 | 50.00% in 0.0006 secs | 90.00% in 0.0007 secs    |

oha Configuration: Concurrent connections=16, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 0.0039 secs | 999.9974 | 50.00% in 0.0017 secs | 90.00% in 0.0036 secs    |
| Cilium    | 0.0378 secs | 999.6560 | 50.00% in 0.0023 secs | 90.00% in 0.1536 secs    |
| Istio     | 26.2153 secs | 708.6844 | 50.00% in 26.2457 secs | 90.00% in 47.2412 secs    |
| :heavy_check_mark: Linkerd   | 0.0007 secs | 999.9940 | 50.00% in 0.0007 secs | 90.00% in 0.0008 secs    |

oha Configuration: Concurrent connections=64, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 0.0017 secs | 499.9966 | 50.00% in 0.0016 secs | 90.00% in 0.0019 secs    |
| Cilium    | 0.0019 secs | 499.9977 | 50.00% in 0.0017 secs | 90.00% in 0.0021 secs    |
| Istio     | 0.0015 secs | 499.9977 | 50.00% in 0.0014 secs | 90.00% in 0.0016 secs    |
| :heavy_check_mark: Linkerd   | 0.0007 secs | 499.9965 | 50.00% in 0.0006 secs | 90.00% in 0.0007 secs    |

oha Configuration: Concurrent connections=64, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 0.0049 secs | 999.9947 | 50.00% in 0.0017 secs | 90.00% in 0.0028 secs    |
| Cilium    | 0.0470 secs | 999.8635 | 50.00% in 0.0023 secs | 90.00% in 0.2029 secs    |
| Istio     | 19.3507 secs | 787.4265 | 50.00% in 19.3777 secs | 90.00% in 34.5497 secs    |
| :heavy_check_mark: Linkerd   | 0.0007 secs | 999.9916 | 50.00% in 0.0007 secs | 90.00% in 0.0008 secs    |

oha Configuration: Concurrent connections=128, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 0.0017 secs | 499.9948 | 50.00% in 0.0016 secs | 90.00% in 0.0018 secs    |
| Cilium    | 0.0019 secs | 499.9966 | 50.00% in 0.0017 secs | 90.00% in 0.0021 secs    |
| Istio     | 0.0015 secs | 499.9948 | 50.00% in 0.0014 secs | 90.00% in 0.0016 secs    |
| :heavy_check_mark: Linkerd   | 0.0007 secs | 499.9965 | 50.00% in 0.0006 secs | 90.00% in 0.0007 secs    |

oha Configuration: Concurrent connections=128, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 0.0039 secs | 999.9908 | 50.00% in 0.0017 secs | 90.00% in 0.0025 secs    |
| Cilium    | 0.0591 secs | 999.9934 | 50.00% in 0.0022 secs | 90.00% in 0.2495 secs    |
| Istio     | 18.6208 secs | 796.2945 | 50.00% in 18.3669 secs | 90.00% in 33.5134 secs    |
| :heavy_check_mark: Linkerd   | 0.0008 secs | 999.9757 | 50.00% in 0.0007 secs | 90.00% in 0.0008 secs    |