# Public cold-load measurements

All valid traces use a fresh Chromium cache, desktop ANGLE SwiftShader, 852×393 CSS pixels at density 2, 20 Mbps throughput and 50 ms latency. The endpoint is loading-status removal plus two animation frames. A separate download after timing verifies the deployed PCK against the local build; it is excluded from browser transfer totals.

| Trace | Transferred | Ready | Errors |
|---|---:|---:|---:|
| `cold-load-before-compression.json` | 30.179 MiB | 19.383 s | 0 |
| `cold-load-after-compression.json` | 28.316 MiB | 18.024 s | 0 |
| `cold-load-final.json` (damage-priority build) | 28.324 MiB | 17.474 s | 0 |

The final proposed 30 MiB payload hypothesis passes. The proposed 12-second readiness hypothesis fails. The WASM and PCK downloads already run concurrently; compression does not change boot scheduling. These traces do not establish physical iPhone/Safari performance, warm-run frame rate or V8 acceptance.

Earlier `cold-load-trace.json` and `cold-load-before-buffer.json` are failed measurement attempts: retrieving the large response body through the DevTools inspector hit cache eviction. Their logs are retained, but their measurements are not used for acceptance. The final harness verifies checksums through a separate fetch instead.
