# Network Test

oha Configuration: Concurrent connections=16, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 89.3049 secs | 76.8994 | 50.00% in 87.6661 secs | 90.00% in 144.4102 secs
    |
| Cilium    | 88.8605 secs | 65.2886 | 50.00% in 88.3452 secs | 90.00% in 148.3369 secs    |
| Istio     | 88.1544 secs | 76.4664 | 50.00% in 84.5492 secs | 90.00% in 144.2728 secs    |
| Linkerd   | 82.9822 secs | 94.8717 | 50.00% in 85.6783 secs | 90.00% in 135.8434 secs    |

oha Configuration: Concurrent connections=16, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 78.9773 secs | 130.4711 | 50.00% in 78.9561 secs | 90.00% in 141.2677 secs    |
| Cilium    | 80.5307 secs | 112.5156 | 50.00% in 80.9546 secs | 90.00% in 143.9053 secs    |
| Istio     | 78.8087 secs | 126.3041 | 50.00% in 78.7382 secs | 90.00% in 141.6271 secs    |
| Linkerd   | 79.0531 secs | 139.6443 | 50.00% in 79.3525 secs | 90.00% in 139.8478 secs    |

oha Configuration: Concurrent connections=64, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 66.6605 secs | 128.2656 | 50.00% in 66.3711 secs | 90.00% in 120.6751 secs    |
| Cilium    | 70.4997 secs | 110.3487 | 50.00% in 70.5662 secs | 90.00% in 126.5078 secs    |
| Istio     | 68.4166 secs | 123.6658 | 50.00% in 68.7459 secs | 90.00% in 122.1674 secs    |
| Linkerd   | 65.4675 secs | 138.0653 | 50.00% in 65.2972 secs | 90.00% in 117.5585 secs    |

oha Configuration: Concurrent connections=64, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  |  78.5071 secs | 127.7657 | 50.00% in 78.3313 secs | 90.00% in 141.1991 secs   |
| Cilium    |  80.3770 secs | 109.9656 | 50.00% in 80.3946 secs | 90.00% in 144.3602 secs   |
| Istio     |  79.1528 secs | 122.8599 | 50.00% in 78.9464 secs | 90.00% in 142.0456 secs   |
| Linkerd   |  78.1172 secs | 136.5323 | 50.00% in 78.3255 secs | 90.00% in 140.5340 secs   |

oha Configuration: Concurrent connections=128, QPS=500

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 68.2073 secs | 123.7429 | 50.00% in 68.3672 secs | 90.00% in 122.3131 secs    |
| Cilium    | 71.0292 secs | 108.6874 | 50.00% in 71.0499 secs | 90.00% in 127.1491 secs    |
| Istio     | 69.2620 secs | 121.3373 | 50.00% in 69.3990 secs | 90.00% in 123.0582 secs    |
| Linkerd   | 66.2862 secs | 135.5480 | 50.00% in 66.3384 secs | 90.00% in 118.5156 secs    |

oha Configuration: Concurrent connections=128, QPS=1000

| Service mesh | Average speed | Actual QPS | Response time percentiles (50%) | Response time percentiles (90%) |
| ------------ | ------------- | ---------- | ------------------------------- | ------------------------------- |
| Baseline  | 79.1417 secs | 125.0597 | 50.00% in 79.2446 secs | 90.00% in 141.9449 secs    |
| Cilium    | 80.8794 secs | 108.7711 | 50.00% in 80.9758 secs | 90.00% in 144.7038 secs    |
| Istio     | 79.7249 secs | 122.6543 | 50.00% in 79.5690 secs | 90.00% in 142.4177 secs    |
| Linkerd   | 79.0261 secs | 133.6869 | 50.00% in 79.4403 secs | 90.00% in 140.8498 secs    |