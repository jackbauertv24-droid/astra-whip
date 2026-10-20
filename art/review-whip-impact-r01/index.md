# Art review pack

Frames: `/config/codex-workspace/astra-whip/art/review-whip-impact-r01/frames` · contract 0.2.0 · 1 clips present.

Follow `prompts/ART_REVIEW.md`. Do the steps in this order and do not read `audit.md` or the clip intents until step 3.

1. **Blind description.** For each lineup, then each strip, write what you see in plain words before anything else.
2. **Motion.** Read every `onion_*.png`: does each pair read as one continuous movement of the same body?
3. **Intent and checks.** Now read the contract and `audit.md`, compare, and adjudicate every FLAG.
4. **Attacks.** `composite_*.png`: whip held in the fist (cyan cross), reach covers the yellow hitbox on active frames.

Audit: **0 DEFECT, 0 FLAG** (see `audit.md`).

## Derived clips (ART_CONTRACT §11)

- `vfx_whip_impact`: generated_sheet of `art/production-candidates/whip-impact-sheet-r01/raw.png,art/production-candidates/whip-impact-sheet-r01/canvas.png,art/production-candidates/whip-impact-sheet-r01/prompt.txt,art/production-candidates/whip-impact-sheet-r01/guide.png,tools/prepare-whip-impact.mjs` (Six directly painted equal192px cells, uniform sheet resolution conversion, integer registration of each ink-bbox centre to(96,96), no frame scale or painted content deformation. Remove only alpha<=4 resampling remnants; raw cells and all shifts/counts retained.); reason: undefined. Confirm it reads as the intended action.

## Files

- `strip_vfx_whip_impact.png`
- `onion_vfx_whip_impact.png`

## Additional blind lineup and actual contacts

Open lineup_vfx.png before the strip: one native frame0 on neutral matte, anchor cross only; there are no character clips or height guides in this effect-only pack. Save/read per-tile blind observations before interpreting this index.

The two engine manifests in scope.json cover both facings of actual ground/crouch/air whip hits on an8HP boss, circular grazing hits on a1HP low-perch fixture, and destruction of the effigy. Each fixture captures before, every effect frame and expiry; boss fixtures also freeze the effect under production pause with menu surfaces hidden only for isolated paint/clock inspection. Ground boss fixtures capture reduced effects at the same peak phase. Other foes are hidden; these are controller fixtures, not full arena traversal or physical-device evidence. Phone image dimensions are698×393 from an852×393 window.

The six source frames are directly painted cells with integer center registration; all unregistered cells, raw sheet, guide, exact prompt and conversion/cleanup records remain in art/production-candidates/whip-impact-sheet-r01 and whip-impact-r01. Enemy/player/whip/terrain/prop art in actual captures is context, not new acceptance scope.
