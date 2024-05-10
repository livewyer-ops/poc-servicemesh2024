# Network Test

oha Configuration: Concurrent connections=16, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 98.7173 secs | 53.6108 | 50.00% in 108.6167 secs | 90.00% in 148.5974 secs    |
| Cilium    | 96.2635 secs | 56.3106 | 50.00% in 104.8619 secs | 90.00% in 149.0847 secs    |
| Istio     | 100.2580 secs | 53.8773 | 50.00% in 110.5355 secs | 90.00% in 149.3358 secs    |
| Linkerd   | 94.1852 secs | 60.1385 | 50.00% in 102.9784 secs | 90.00% in 145.0310 secs    |

oha Configuration: Concurrent connections=16, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 88.3119 secs | 87.1272 | 50.00% in 88.0097 secs | 90.00% in 154.1097 secs    |
| Cilium    | 84.4491 secs | 75.5882 | 50.00% in 77.1871 secs | 90.00% in 155.8485 secs    |
| Istio     | 82.9199 secs | 83.4383 | 50.00% in 76.9651 secs | 90.00% in 154.5927 secs    |
| Linkerd   | 81.4287 secs | 107.8655 | 50.00% in 77.6263 secs | 90.00% in 147.7140 secs    |

oha Configuration: Concurrent connections=64, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 65.4352 secs | 140.6659 | 50.00% in 65.4963 secs | 90.00% in 116.3571 secs    |
| Cilium    | 69.2664 secs | 120.2711 | 50.00% in 69.5757 secs | 90.00% in 123.2816 secs    |
| Istio     | 66.9974 secs | 131.4266 | 50.00% in 66.4638 secs | 90.00% in 119.4371 secs    |
| Linkerd   | 66.1352 secs | 146.8156 | 50.00% in 68.5365 secs | 90.00% in 115.6910 secs    |

oha Configuration: Concurrent connections=64, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 76.3039 secs | 144.1154 | 50.00% in 75.7345 secs | 90.00% in 138.4262 secs    |
| Cilium    | 79.7941 secs | 122.1043 | 50.00% in 80.2509 secs | 90.00% in 142.5100 secs    |
| Istio     | 78.7774 secs | 132.8098 | 50.00% in 78.9687 secs | 90.00% in 141.1098 secs    |
| Linkerd   | 76.2781 secs | 155.6717 | 50.00% in 76.2610 secs | 90.00% in 137.0995 secs    |

oha Configuration: Concurrent connections=128, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 64.1606 secs | 143.8431 | 50.00% in 63.9514 secs | 90.00% in 115.2643 secs    |
| Cilium    | 68.1088 secs | 122.4315 | 50.00% in 68.2727 secs | 90.00% in 122.3520 secs    |
| Istio     | 65.9608 secs | 134.4761 | 50.00% in 65.4474 secs | 90.00% in 118.7346 secs    |
| Linkerd   | 62.5082 secs | 154.3315 | 50.00% in 62.1046 secs | 90.00% in 112.4982 secs    |

oha Configuration: Concurrent connections=128, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 77.2996 secs | 144.4539 | 50.00% in 77.5030 secs | 90.00% in 138.7481 secs    |
| Cilium    | 80.0453 secs | 122.8204 | 50.00% in 80.7278 secs | 90.00% in 142.3894 secs    |
| Istio     | 78.6884 secs | 133.5702 | 50.00% in 78.5285 secs | 90.00% in 141.1540 secs    |
| Linkerd   | 76.5463 secs | 154.9090 | 50.00% in 76.5729 secs | 90.00% in 137.2801 secs    |