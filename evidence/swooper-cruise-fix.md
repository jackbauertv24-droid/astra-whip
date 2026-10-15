# Swooper cruise animation

Scope: eight 384×256 RGBA cruise frames at canonical 90 ms timing (720 ms loop), plus passive runtime integration. The swooper uses its authored body-center pivot; the prior actor-pivot repair is separately committed. The renderer displays painted artwork only for a fully delivered state and retains the preview silhouette for pending states. Physics and AI rules are unchanged.

## Sources and derivation

The built-in image generator produced the source artwork. Prompt records and input references are preserved in `art/prompts/swooper-cruise.json`. The original oversize draft is retained and rejected: its required correction falls below G03's 0.85 bound. The next draft uses a single recorded 0.854271 uniform normalization and center registration; alpha ≤4 is cleaned, with no visible scenery removed. Its 169 px measured envelope is centered at y128. Static source review: `art/review-swooper-key-r01/`.

The painted opposite wing pose moved the central hood/body; it remains archived in `art/production-candidates/swooper-downstroke-r01/`. D23 fallback frames use the accepted static paint with independently moving wing meshes, fixed shoulder roots, elbow-centered flexion and phase-lagged membrane camber. The torso and trailing shroud retain their paint and physical size. See `tools/prepare-swooper-cruise.mjs`, `art/production-candidates/swooper-cruise-rig-r01/rig.json` and the manifest derivation. This is disclosed scripted quality debt, rather than eight independently painted poses.

## Validation

- `swooper-cruise-source-check.json`: source/runtime/review snapshot PNGs are byte-identical; unrelated clip metadata unchanged; oversize draft rejected by the normalization helper.
- `swooper-cruise-art-check.log`: scoped contract audit, including the actor's cruise reference.
- `swooper-cruise-contract-check.log` and `swooper-cruise-selftest.log`: inventory contract and 25 negative art fixtures.
- `swooper-cruise-gameplay.log`: T01–T09 gameplay regression. `swooper-cruise-pivot.log`: world registration for all five actors in both facings.
- `swooper-cruise-native/` and `swooper-cruise-phone/`: actual AI perch-to-cruise entry, every frame and the next loop's first frame in both facings. Captures verify the 65 u/s travel rate and centered flight pivot. The phone-sized viewport is emulation, not a physical device.
- `swooper-cruise-export.log` and `swooper-cruise-build.sha256`: exported web build and its exact pack hash.

Other swooper clips, other enemy families, remaining asset/atlas/device gates and physical iPhone/player studies remain tracked in `docs/FIX_QUEUE.md`.

Independent motion review: `art/review-swooper-cruise-r01/review_verdict.md`, REVIEW: PASS. No art audit flags. The reviewer accepted the articulated shallow cruise stroke and phone readability, while identifying the nearly held shroud as mechanical scripted-fallback quality debt. This approves only cruise, not the complete swooper state set.

The scoped Chromium156 browser smoke test booted the export, started gameplay, allowed AI to run and paused, with no page/console errors. See `swooper-cruise-browser-smoke.json` and its screenshot. The committed web artifact is the tested export; the workflow publishes it directly.
