# Fix 4 — alternating walk and travel cadence

The walk now has distinct alternating support/swing poses, coherent near/far coat overlap and a unique loop seam. Corrected early support positions and the loaded contact handoff remove the large foot-registration jumps from the preview. Fresh independent review approved both scoped clips in art/review-gait-r19/review_verdict.md after inspecting all native frames, onions and twenty actual moving engine samples. It accepts both audit flags as isolated hair silhouette and leg/coat self-occlusion; the scoped audit has zero defects. The review notes small residual late-phase contact drift, without a blocking sliding-portrait appearance.

Seven source/runtime frames changed (F1/F2/F3/F4/F5/F6/F9); F0/F7/F8 remain byte-identical. All ten runtime textures match the reviewed frames and their decoded pixels are distinct. The final contact-foot correction preserves 1,197 lower-boot pixels exactly under translation; no foot resizing is used. Painted sources, scripted derivations, normalization factors, prompts, failed candidates and independent verdicts are retained.

Only hero walk playback is tuned to 2×, as ANIMATION_SPEC permits for travel speed. Canonical ten 80 ms source frames remain intact; the rendered loop takes 400 ms at 240 u/s and covers 96 units. Enemy clocks and authoritative gameplay constants are unchanged. A real-right-input harness verifies all ten frames, cycle and travel at desktop and phone-sized resolutions. These desktop engine captures are not physical iPhone performance tests.

Gameplay T01–T09 passed 1,213 assertions, including frame clocks for every actor. The contract checker and 25-case art-tool negative self-test passed. The web export has no script errors; Chromium smoke evidence and package hash are recorded alongside this report. Approximate flat-sole contact landmarks for the two stance windows are in walk-contact-landmarks.json.

This closes the scoped walk-art gap. Full attack/whip/enemy inventory, atlas/memory work and external device/player validation remain in docs/FIX_QUEUE.md.
