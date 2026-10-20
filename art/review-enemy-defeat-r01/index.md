# Art review pack

Frames: `/config/codex-workspace/astra-whip/art/review-enemy-defeat-r01/frames` · contract 0.2.0 · 1 clips present.

Follow `prompts/ART_REVIEW.md`. Do the steps in this order and do not read `audit.md` or the clip intents until step 3.

1. **Blind description.** For each lineup, then each strip, write what you see in plain words before anything else.
2. **Motion.** Read every `onion_*.png`: does each pair read as one continuous movement of the same body?
3. **Intent and checks.** Now read the contract and `audit.md`, compare, and adjudicate every FLAG.
4. **Attacks.** `composite_*.png`: whip held in the fist (cyan cross), reach covers the yellow hitbox on active frames.

Audit: **0 DEFECT, 0 FLAG** (see `audit.md`).

## Derived clips (ART_CONTRACT §11)

- `vfx_enemy_defeat`: generated_sheet of `art/production-candidates/enemy-defeat-sheet-r01/raw.png,art/production-candidates/enemy-defeat-sheet-r01/canvas.png,art/production-candidates/enemy-defeat-sheet-r01/prompt.txt,tools/prepare-enemy-defeat.mjs` (Eight directly painted equal256px cells, uniform sheet conversion and integer ink-centre registration to(128,128). Remove only alpha<=8 near-invisible extraction remnants. No scaling, deformation or opacity adjustment. Raw cells and all counts retained.); reason: undefined. Confirm it reads as the intended action.

## Files

- `strip_vfx_enemy_defeat.png`
- `onion_vfx_enemy_defeat.png`

Effect-only lineup: native first frame with centre cross; actor height guides do not apply. Actual captures: evidence/enemy-defeat-r01-native/capture.json and evidence/enemy-defeat-r01-phone/capture.json.
