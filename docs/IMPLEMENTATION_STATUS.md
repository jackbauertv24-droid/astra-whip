# Implementation status

Implementation: `game/`. Specification: Gothic Whip Framework at `cf717cab22b39344820c11ef9aaf3a827336ce14`. Public build: https://jackbauertv24-droid.github.io/astra-whip/ . This record supersedes the early partial-art status; rejected candidates and earlier verdicts remain in Git and `art/`.

| Build gate | Current result | Evidence |
|---|---|---|
| 1 Tools | PASS | `node tools/contract-check.mjs`; `node tools/selftest.mjs`; latest `evidence/damage-priority-{contract,selftest}.log`, 25 deliberately broken art cases |
| 2 Greybox/gameplay | PASS | `GODOT_BIN=godot bash tools/test-game.sh --mutations`; T-01–T-09, all nine deliberate gameplay mutations; `evidence/complete-regressions.json` and full runner log |
| 3 Style calibration | PASS | Five-piece independent review, `evidence/gate-3.md`, `art/style-lock.json` |
| 4 Hero and whip | PASS | All 137 runtime body/whip frames; fresh complete independent `art/review-complete-r02/review_verdict.md` |
| 5 Remaining production art | PASS | 409 runtime frames, zero inventory errors; extended audit 68 entries, 0 DEFECT/34 FLAG; separate static audits and fresh complete review adjudicate all 35 flags |
| 6 Art/automated integration | PASS | Fresh complete review of all clips/static assets and 70 integration images; 1,241 main assertions, 35 existing runtime regressions plus import; added continuous completion and damage-priority tests; native/phone captures |
| 7 Web publication | PASS for public desktop build | `GODOT_BIN=godot bash tools/export-web.sh`; GitHub Pages deployment; `evidence/cold-load-final.json` verifies deployed/local PCK SHA-256 |

The long full regression shell reported exit 143 after every expected result had been written. `complete-regressions.json` records that limitation, validates every individual result and all nine expected mutation failures, and records a separate final baseline rerun with exit 0. The added continuous stage test has its own successful run and is now in the shared runner.

After that baseline, the same-step damage-priority fix passed a new 64-check regression (eight retained pre-fix failures), the main 1,241 assertions, continuous completion and 12 affected actor/boss/effect regressions. These 15 source runs are indexed in `evidence/damage-priority-results.json`; the exported pack also passes the 64 checks and 2,433 GPU atlas checks. Current browser smoke has zero errors. These follow-up results are separate from the earlier full-suite record.

All 405 atlas frames plus four standalone backgrounds have canonical delivery files. The 67 runtime timed clips contain 367 frames; static assets add 42. The source viewer has 68 entries because it also includes the neutral calibration still. Supplemental boss reactions retain their original 12 frames and declared timing. No mandatory animation contract was weakened. Complete review r01 remains FAIL for omitted canonical supplemental frames. Fresh r02 independently passes the restored complete delivery, with all 68 reel entries played and every frame index observed. Its 35 individual flag reasons are in `art/review-complete-r02/accepted_flags.json`.

Five lossless 2048² atlas pages preserve source canvas, pivots and trim offsets. Exported GPU checks: 2,433 checks, zero failures; art allocation 127.06 MiB on desktop llvmpipe. All nine decoded texture hashes are identical across compression. Linear source/packed sampling passes the unchanged strict tolerance. These are desktop measurements, not iPhone residency/performance acceptance.

The public cold-cache Chromium/SwiftShader proxy at 20 Mbps/50 ms transfers 28.324 MiB and reaches the loading-status removal criterion in 17.474 seconds. The proposed 30 MiB payload target passes; the proposed 12-second load target fails. Physical iPhone 17/Safari touch and performance gates V5/V8, and the three-unfamiliar-player study V6, remain NOT-TESTED. Full specification acceptance requires those results. APK V9 and production audio remain explicitly deferred by the spec.

Every scripted/reused/reversed/derived asset retains its source, method and reason in `art/frames/derivations.json`; the handoff copy is `evidence/release-derivations.json` (100 records). Scripted fallbacks and background repetition remain disclosed visual quality debt. Accepted audit flags must be read with the complete independent review rather than treated as numeric approval.

Historical details remain in `docs/FIX_QUEUE.md`, `docs/REVIEW_RECORD.md`, individual `evidence/*-fix.md` records and retained failed review packs.
