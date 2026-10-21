# Lossless web payload compression

The cold-cache desktop network proxy measured 30.18 MiB transferred before this fix, exceeding the proposed 30 MiB starting target. Godot's default lossless WebP compression effort was 25. Set it to 100 and rebuild all nine shipped texture imports before export, even with an existing editor cache. This changes encoder effort, not image quality.

The PCK shrank from 21,507,696 to 19,524,992 bytes (9.22%). All nine decoded RGBA texture hashes, dimensions and byte counts match exactly before/after. Source PNGs and atlas placements are unchanged. See `lossless-payload.json`, `lossless-payload-before.json`, `lossless-payload-after.json` and the capture script.

Contract checks and all 25 negative art-tool selftests pass. The exported PCK passes 2,433 GPU atlas checks and 124 painted-sampling checks. Measured desktop software-renderer art allocation remains 133,227,856 bytes (127.06 MiB). Local browser checks cover compact safe-area gameplay/menu/held controls and portrait-to-landscape explicit resume. Browser images and error records are retained separately.

The baseline trace is `cold-load-before-compression.json`: Chromium/SwiftShader, fresh cache, 20 Mbps/50 ms latency, 19,383 ms to loading-status removal plus two animation frames. This is a desktop proxy, not physical iPhone/Safari acceptance. The baseline misses the proposed 12-second load target. Public post-deployment measurement is recorded separately; no physical-device result is inferred.
