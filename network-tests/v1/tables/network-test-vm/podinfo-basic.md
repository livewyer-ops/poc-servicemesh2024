# Network Test

oha Configuration: Concurrent connections=16, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 13.2780 secs | 426.8841 | 50.00% in 13.3135 secs | 90.00% in 23.6995 secs    |
| **Success rate:	99.99%** Cilium    | 0.0080 secs | 499.9949 | 50.00% in 0.0066 secs | 90.00% in 0.0093 secs    |
| **Success rate:	99.99%** Istio     | 0.0089 secs | 499.9973 | 50.00% in 0.0082 secs | 90.00% in 0.0103 secs    |
| Linkerd   | 21.8149 secs | 378.8533 | 50.00% in 21.6509 secs | 90.00% in 39.1680 secs    |

oha Configuration: Concurrent connections=16, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 51.3296 secs | 428.9031 | 50.00% in 51.3155 secs | 90.00% in 92.5282 secs    |
| Cilium    | 0.0202 secs | 999.9936 | 50.00% in 0.0081 secs | 90.00% in 0.0493 secs    |
| Istio     | 16.0132 secs | 820.4251 | 50.00% in 16.0892 secs | 90.00% in 28.9114 secs    |
| Linkerd   | 55.9074 secs | 380.8348 | 50.00% in 56.0437 secs | 90.00% in 100.5430 secs    |

oha Configuration: Concurrent connections=64, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 10.4670 secs | 442.8132 | 50.00% in 10.5740 secs | 90.00% in 18.7580 secs    |
| Cilium    | 0.0064 secs | 499.9957 | 50.00% in 0.0058 secs | 90.00% in 0.0074 secs    |
| Istio     | 0.0072 secs | 499.9947 | 50.00% in 0.0073 secs | 90.00% in 0.0089 secs    |
| Linkerd   | 16.4018 secs | 409.6169 | 50.00% in 16.2922 secs | 90.00% in 29.5615 secs    |

oha Configuration: Concurrent connections=64, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 50.2446 secs | 442.8852 | 50.00% in 50.1421 secs | 90.00% in 90.2594 secs    |
| Cilium    | 0.0166 secs | 999.9933 | 50.00% in 0.0074 secs | 90.00% in 0.0198 secs    |
| Istio     | 10.6779 secs | 881.6355 | 50.00% in 10.3164 secs | 90.00% in 19.3460 secs    |
| Linkerd   | 52.8108 secs | 410.7738 | 50.00% in 52.5041 secs | 90.00% in 95.3999 secs    |

oha Configuration: Concurrent connections=128, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 10.4697 secs | 442.7486 | 50.00% in 10.4174 secs | 90.00% in 18.8958 secs    |
| Cilium    | 0.0062 secs | 499.9988 | 50.00% in 0.0058 secs | 90.00% in 0.0074 secs    |
| Istio     | 0.0072 secs | 499.9965 | 50.00% in 0.0073 secs | 90.00% in 0.0088 secs    |
| Linkerd   | 16.6430 secs | 408.1746 | 50.00% in 16.4789 secs | 90.00% in 29.7771 secs    |

oha Configuration: Concurrent connections=128, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 50.4608 secs | 441.9039 | 50.00% in 50.5387 secs | 90.00% in 90.5021 secs    |
| Cilium    | 0.0203 secs | 999.9890 | 50.00% in 0.0074 secs | 90.00% in 0.0170 secs    |
| Istio     | 9.2760 secs | 899.3331 | 50.00% in 9.2278 secs | 90.00% in 16.6285 secs    |
| Linkerd   | 53.5489 secs | 407.3662 | 50.00% in 53.3923 secs | 90.00% in 96.1980 secs    |