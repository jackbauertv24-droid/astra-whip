# Swooper perch idle

Six 150 ms frames provide a quiet 900 ms hover before cruise. Exact frame reuse from independently accepted cruise is declared in the manifest: [0,1,2,3,6,7], omitting the deepest cruise downstroke. This makes the idle beat slower and slightly shallower while keeping anatomy, source facing, palette and scale identical. Reused/scripted source artwork remains disclosed D23 quality debt.

No gameplay, collision, timing, renderer or tool code changed. Actual AI captures in `swooper-idle-native/` and `swooper-idle-phone/` show all six frames in both facings, fixed root and body-center pivot, and natural cruise entry at 900 ms. Idle exits at the end of its first cycle, so the loop seam is an asset/onion check rather than a claimed repeated in-game idle cycle. The phone capture is emulation, not physical handset evidence.

`swooper-idle-source-check.json` confirms exact source-frame reuse, byte-identical runtime/review copies, unrelated clip metadata unchanged, and capture inventory. `swooper-idle-art-check.log` records zero defects/flags for idle plus unchanged cruise reference. `swooper-idle-contract-check.log` confirms 64 clips / 356 frames / 64 brief rows; art tools are unchanged from the passing 25-fixture self-test recorded in `swooper-cruise-selftest.log`. `swooper-idle-gameplay.log` records 1,213 passing assertions. Export and pack hash are recorded in `swooper-idle-export.log` and `swooper-idle-build.sha256`.

Other swooper clips and all remaining release gaps stay tracked in `docs/FIX_QUEUE.md`. Physical device and unfamiliar-player tests are unperformed.

Fresh independent review `art/review-swooper-idle-r01/review_verdict.md`: REVIEW: PASS for idle and unchanged cruise reference, no flags. The scoped Chromium156 browser probe boots, starts gameplay, runs AI and pauses without page/console errors (`swooper-idle-browser-smoke.json`, screenshot alongside). The committed export matches the recorded pack hash.
