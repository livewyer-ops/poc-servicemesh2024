# Network Test

oha Configuration: Concurrent connections=16, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 71.4691 secs | 140.0599 | 50.00% in 72.9803 secs | 90.00% in 118.1853 secs    |
| Cilium    | 66.1275 secs | 134.2880 | 50.00% in 66.3721 secs | 90.00% in 118.5090 secs    |
| Istio     | 78.5356 secs | 118.1592 | 50.00% in 81.3244 secs | 90.00% in 126.0237 secs    |
| Linkerd   | :heavy_check_mark: 61.1630 secs | 160.0101 | 50.00% in 61.1222 secs | 90.00% in 109.9050 secs    |

oha Configuration: Concurrent connections=16, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 75.7200 secs | 142.5656 | 50.00% in 75.3918 secs | 90.00% in 139.1964 secs    |
| Cilium    | 78.3888 secs | 133.7599 | 50.00% in 78.6864 secs | 90.00% in 140.5058 secs    |
| Istio     | 77.9258 secs | 138.6095 | 50.00% in 78.1380 secs | 90.00% in 139.9532 secs    |
| :heavy_check_mark: Linkerd   | 75.9053 secs | 158.9213 | 50.00% in 76.2433 secs | 90.00% in 136.2581 secs    |

oha Configuration: Concurrent connections=64, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 63.1154 secs | 149.9270 | 50.00% in 62.6866 secs | 90.00% in 113.5364 secs    |
| Cilium    | 66.0860 secs | 133.7040 | 50.00% in 66.0836 secs | 90.00% in 118.9785 secs    |
| Istio     | 64.6817 secs | 138.0602 | 50.00% in 64.3629 secs | 90.00% in 116.7433 secs    |
| :heavy_check_mark: Linkerd   | 61.0134 secs | 160.7429 | 50.00% in 61.0875 secs | 90.00% in 109.5730 secs    |

oha Configuration: Concurrent connections=64, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 76.3099 secs | 148.2704 | 50.00% in 76.1060 secs | 90.00% in 137.6464 secs    |
| Cilium    | 78.2901 secs | 134.8923 | 50.00% in 78.4278 secs | 90.00% in 140.2579 secs    |
| Istio     | 79.7851 secs | 131.6339 | 50.00% in 80.5268 secs | 90.00% in 141.7539 secs    |
| :heavy_check_mark: Linkerd   | 75.6158 secs | 159.7045 | 50.00% in 75.8415 secs | 90.00% in 136.0896 secs    |

oha Configuration: Concurrent connections=128, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 64.7383 secs | 145.0648 | 50.00% in 64.9688 secs | 90.00% in 115.6732 secs    |
| Cilium    | 66.5190 secs | 134.1257 | 50.00% in 66.5254 secs | 90.00% in 118.9029 secs    |
| Istio     | 66.1177 secs | 135.7878 | 50.00% in 66.3029 secs | 90.00% in 117.6354 secs    |
| :heavy_check_mark: Linkerd   | 61.2848 secs | 160.5151 | 50.00% in 61.3329 secs | 90.00% in 110.0606 secs    |

oha Configuration: Concurrent connections=128, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 77.4255 secs | 145.0586 | 50.00% in 77.6082 secs | 90.00% in 138.8555 secs    |
| Cilium    | 78.4971 secs | 133.8987 | 50.00% in 78.6773 secs | 90.00% in 140.6159 secs    |
| Istio     | 79.2179 secs | 135.8763 | 50.00% in 80.2688 secs | 90.00% in 140.7737 secs    |
| :heavy_check_mark: Linkerd   | 75.9318 secs | 160.0213 | 50.00% in 76.0292 secs | 90.00% in 135.9120 secs    |