# Final build gates 4–7

Specification: `cf717cab22b39344820c11ef9aaf3a827336ce14`. Runtime build: `812dce5`. Prior tool/greybox/style gates remain in `gate-1.md` through `gate-3.md`. Physical acceptance is separate.

| Gate | Method | Result and evidence |
|---|---|---|
| 4 Hero/whip | Canonical art audit; fresh independent `/root/complete_review_r02`, blind descriptions before metadata, strips/onions/composites and timed source playback | PASS for every hero/whip clip; `../art/review-complete-r02/review_verdict.md` |
| 5 Other assets | `node tools/check-production-inventory.mjs`; extended audit plus separate static scopes; fresh independent review | All 409 runtime frames delivered, 0 inventory errors; all clips/static assets PASS; 35 individual accepted flags in `accepted_flags.json` |
| 6 Art/automated integration | Full baseline regression suite and nine deliberate mutations; final 1,241 assertion rerun; continuous production-input completion; 64 damage-priority checks and 12 affected regressions; exported 2,433 GPU atlas checks; 12 actual native/phone state captures, 30 stage/context captures, 18 sampling, 8 browser, 2 exit fixtures | PASS within those automated/visual scopes. `complete-regressions.json` discloses its long runner's 143 exit and separate final baseline exit 0. Latest code runs: `damage-priority-results.json`; exported checks and browser records share that prefix. Fresh independent review inspected all 70 supplied images |
| 7 Public web build | `GODOT_BIN=godot bash tools/export-web.sh`; GitHub Pages workflow; downloaded public PCK checksum versus local export | PASS; `deployment-current.json`, `cold-load-final.json`; packSHA `e56b41ddc43086856604d5fb7c7206a881ced995454780ea5fd15d6481e397bc` |

Reproduce the extended numeric audit without overwriting the frozen review pack:

```sh
node tools/contract-check.mjs
node tools/selftest.mjs
node tools/check-production-inventory.mjs
node tools/audit-art.mjs --frames art/frames --contract art/review-complete-r02/review_contract.json --out /tmp/astra-full-audit
node tools/review-pack.mjs --frames art/frames --contract art/review-complete-r02/review_contract.json --out /tmp/astra-full-review
GODOT_BIN=godot bash tools/test-game.sh --mutations
```

The reviewer retained 68 playback records with every frame index observed, 68 inspected temporal contact sheets and its actual Playwright harness. Source-reel playback is not an engine playthrough; automated production-input traversal is recorded separately. Every derived asset's source/method/reason is in `release-derivations.json` (100 records). All failed review packs remain intact.

Overall specification acceptance remains incomplete: V5 physical iPhone 17/Safari touch, V6 three unfamiliar players and V8 physical cold/warm performance/frame samples were not performed. The public desktop proxy transfers 28.324 MiB in 17.474 seconds at 20 Mbps/50 ms: proposed 30 MiB payload target passes, proposed 12 second readiness target fails. APK and production audio remain deferred by the specification. No missing device/player result is inferred from build-gate completion.
