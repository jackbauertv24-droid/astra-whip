# Swooper conditional hurt and continuous recovery

Three 60 ms frames show hood recoil, asymmetric wing/body stagger and the banked catch. The last frame exactly reuses the approved recovery start. The initial local hood/cloth rig and reused endpoint are declared D23 quality debt; the middle pose is newly generated painting, normalized once by factor 0.862944. Exact built-in generation prompt and references: `art/prompts/swooper-hurt.json`. The source and derivation record remain in `art/production-candidates/swooper-hurt-stagger-r01/` and `swooper-hurt-r01/`.

Production basic HP remains 1. A normal hit enters death_fall immediately; hurt is the explicit conditional nonlethal branch, exercised through a test-only 2 HP foe. The capture manifest records both outcomes and must not be described as normal 1 HP hurt behavior.

The conditional branch also exposed a real recovery bug: its climb previously reset y to the low-pass altitude even when hurt occurred much higher. Recovery now records current y on entry. The normal dive still starts at 64 u and follows the same 900 ms path; a higher hurt entry climbs continuously from its hit position. `swooper-hurt-entry-before.log` reproduces six failures against the previous code. `swooper-hurt-entry-after.log` passes 17 checks covering cruise/warning/mid-climb entry and unchanged normal recovery. The default runner includes the regression.

`swooper-hurt-native/` and `swooper-hurt-phone/` contain actual cruise, all three hurt frames, recovery entry/first step and return to cruise, both facings. The real nonlethal damage handler is used. Duration, root/body pivot, first recovery step and normal lethal branch are asserted. Phone evidence is desktop viewport emulation, not physical-device testing.

`swooper-hurt-source-check.json` verifies PNG byte identity, recovery endpoint equality, unrelated metadata and capture inventory. Scoped art audit has zero defects and five flags requiring independent review. Contract check and 25 negative art fixtures pass. The default engine suite passes 1,213 gameplay assertions, 32 circle checks, 17 entry checks and all actor pivots; logs are retained individually and as the full suite. Export/hash: `swooper-hurt-export.log`, `swooper-hurt-build.sha256`.

Death artwork and remaining release gates stay tracked in `docs/FIX_QUEUE.md`.

Independent review: `art/review-swooper-hurt-r01/review_verdict.md` PASS, all five flags visually accepted, with procedural deviations disclosed. Approval is limited to the conditional nonlethal branch. Chromium browser smoke passes with no errors (`swooper-hurt-browser-smoke.json`).
