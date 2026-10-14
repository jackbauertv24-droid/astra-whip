# Fix 1 — supported get-up recovery

The preview played knockdown backwards, producing unsupported leg/hand transitions and ending in a backward recoil pose. Get-up now rolls forward through supported leg draw-in, a planted-foot half-kneel and a rising half-kneel, ending in the approved standing pose. Timing remains six 75 ms frames / 450 ms.

Acceptance: `art/review-getup-r04/review_verdict.md` ends `REVIEW: PASS`. Its reviewer inspected native frames and all adjacent onions and accepted both area-change FLAGs as folding/occlusion. The scoped audit reports zero DEFECT. Earlier rejected r01–r03 packs and original frames are retained.

Validation: T-01…T-09 passed with 1,213 assertions and zero failures. Contract checker passed. Art-tools self-test passed all 25 defect fixtures with zero problems. Scope check confirms unrelated clip frames/metadata are unchanged, all six integrated textures match the reviewed assets, and the final pose preserves approved neutral pixels apart from logged alpha <=4 fringe cleanup.

Godot Compatibility-renderer captures are retained in `getup-engine-r04/`. The `getup-engine-phone-r04/` captures use an 852×393 desktop window with a 698×393 rendered 16:9 content area. They are phone-sized desktop captures, not physical iPhone results. `game/tests/capture_action.gd` selects actual runtime frames at their authoritative timing boundaries with simulation frozen.

The updated single-threaded Web export is in `build/web/`; its package hash is in `getup-build.sha256`. Other preview gaps remain open; see `docs/FIX_QUEUE.md`.

The exported preview also passed a Chromium startup/movement/whip smoke test with zero console/runtime errors (`getup-browser-smoke.json`).
