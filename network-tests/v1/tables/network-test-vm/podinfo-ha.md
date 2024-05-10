# Network Test

oha Configuration: Concurrent connections=16, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 13.2870 secs | 424.0380 | 50.00% in 12.5997 secs | 90.00% in 24.9144 secs    |
| Cilium    | 0.0075 secs | 499.9946 | 50.00% in 0.0063 secs | 90.00% in 0.0101 secs    |
| Istio     | 0.0073 secs | 499.9977 | 50.00% in 0.0073 secs | 90.00% in 0.0089 secs    |
| Linkerd   | 22.0156 secs | 379.6518 | 50.00% in 22.2462 secs | 90.00% in 39.1887 secs    |

oha Configuration: Concurrent connections=16, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 51.3573 secs | 429.8008 | 50.00% in 51.4170 secs | 90.00% in 92.4867 secs    |
| Cilium    | 0.0307 secs | 999.9937 | 50.00% in 0.0110 secs | 90.00% in 0.0699 secs    |
| Istio     | 12.0883 secs | 862.2978 | 50.00% in 11.9006 secs | 90.00% in 22.3658 secs    |
| Linkerd   | 55.6998 secs | 383.0587 | 50.00% in 55.7504 secs | 90.00% in 100.1323 secs    |

oha Configuration: Concurrent connections=64, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 10.6675 secs | 440.9745 | 50.00% in 10.8017 secs | 90.00% in 19.2683 secs    |
| Cilium    | 0.0064 secs | 499.9969 | 50.00% in 0.0057 secs | 90.00% in 0.0075 secs    |
| Istio     | 0.0075 secs | 499.9985 | 50.00% in 0.0073 secs | 90.00% in 0.0089 secs    |
| Linkerd   | 15.6850 secs | 413.0882 | 50.00% in 15.7125 secs | 90.00% in 28.1346 secs    |

oha Configuration: Concurrent connections=64, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 50.5436 secs | 441.6389 | 50.00% in 50.6172 secs | 90.00% in 90.5716 secs    |
| Cilium    | 0.0125 secs | 999.9911 | 50.00% in 0.0072 secs | 90.00% in 0.0148 secs    |
| Istio     | 7.2082 secs | 921.7054 | 50.00% in 7.3336 secs | 90.00% in 12.5777 secs    |
| Linkerd   | 52.8519 secs | 412.9559 | 50.00% in 52.7536 secs | 90.00% in 95.1873 secs    |

oha Configuration: Concurrent connections=128, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 10.5755 secs | 443.0421 | 50.00% in 10.6883 secs | 90.00% in 18.9379 secs    |
| Cilium    | 0.0063 secs | 499.9951 | 50.00% in 0.0057 secs | 90.00% in 0.0075 secs    |
| Istio     | 0.0072 secs | 499.9947 | 50.00% in 0.0073 secs | 90.00% in 0.0089 secs    |
| Linkerd   | 16.1625 secs | 411.2375 | 50.00% in 16.1036 secs | 90.00% in 29.0183 secs    |

oha Configuration: Concurrent connections=128, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 50.5571 secs | 441.1617 | 50.00% in 50.6281 secs | 90.00% in 90.6668 secs    |
| Cilium    | 0.0114 secs | 999.9885 | 50.00% in 0.0072 secs | 90.00% in 0.0137 secs    |
| Istio     | 7.4841 secs | 920.9445 | 50.00% in 7.7541 secs | 90.00% in 12.9447 secs    |
| Linkerd   | 53.7602 secs | 408.4478 | 50.00% in 54.0377 secs | 90.00% in 96.1696 secs    |