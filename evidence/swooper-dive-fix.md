# Swooper active dive

Four 60 ms painted frames replace the active dive placeholder. The body pitches about its flight pivot while folded wing struts tighten independently and cloth streams behind it. The accepted folded source supplies the same hood, body and wing paint. All four output frames differ; no global scaling or per-frame recentering occurs. D23 scripted derivation and its quality debt are explicit in the manifest and `art/production-candidates/swooper-dive-r01/derivation.json`.

The body pitches 20/40/80/80 degrees across the four frames; local wing flex is 2/6/10/7 degrees and cloth deflection changes independently. `tools/prepare-swooper-dive.mjs` samples the composed transformation once. This is not a new set of independently painted in-betweens; source generation/prompts remain in `art/prompts/swooper-telegraph.json`.

`capture_swooper_dive.gd` drives natural AI from perch through cruise and warning, captures the outgoing painted tell, then every active dive frame and recovery entry. Both facings at native and phone-sized viewports pass the 300-unit/s travel check, prescribed dive-altitude path, 64-unit bottom altitude, 240 ms duration and centered visual pivot. Recovery artwork remains pending; its geometric placeholder in the outgoing capture is not approved.

Evidence:

- `swooper-dive-source-check.json`: distinct frames, exact source/runtime/review copies, unrelated metadata unchanged and complete actual capture inventory.
- `swooper-dive-art-check.log`: three scoped clips, zero defects and two A11 height-change flags at frames 1/2. Both require independent adjudication; size changes stay below 2% as the body turns toward horizontal.
- `swooper-dive-contract-check.log`, `swooper-dive-selftest.log`: canonical inventory agreement and 25 negative fixtures.
- `swooper-dive-default-suite.log`: default gameplay suite, pivot regression and exact-circle collision suite. Detailed pivot/collision output is retained separately.
- `swooper-dive-native/`, `swooper-dive-phone/`: actual AI screenshots and manifests. These are desktop viewport captures, not physical-device evidence.
- `swooper-dive-export.log`, `swooper-dive-build.sha256`: exported web build and exact pack hash.

Remaining action clips and release gates are tracked in `docs/FIX_QUEUE.md`.

Fresh independent verdict: `art/review-swooper-dive-r01/review_verdict.md`, REVIEW: PASS for all three scoped clips. Both height flags are accepted as legitimate pitching, not shrinking. The outgoing recovery placeholder remains unapproved. Scoped Chromium156 smoke booted the exported game, started gameplay, ran AI and paused with no page/console errors; see `swooper-dive-browser-smoke.json` and screenshot. Committed web artifact matches the recorded pack hash.
