# Art review pack

Frames: `/config/codex-workspace/astra-whip/art/review-checkpoint-r01/frames` · contract 0.2.0 · 2 clips present.

Follow `prompts/ART_REVIEW.md`. Do the steps in this order and do not read `audit.md` or the clip intents until step 3.

1. **Blind description.** For each lineup, then each strip, write what you see in plain words before anything else.
2. **Motion.** Read every `onion_*.png`: does each pair read as one continuous movement of the same body?
3. **Intent and checks.** Now read the contract and `audit.md`, compare, and adjudicate every FLAG.
4. **Attacks.** `composite_*.png`: whip held in the fist (cyan cross), reach covers the yellow hitbox on active frames.

Audit: **0 DEFECT, 0 FLAG** (see `audit.md`).

## Derived clips (ART_CONTRACT §11)

- `prop_checkpoint`: generated_sheet of `art/production-candidates/checkpoint-marker-sheet-r01/raw.png,art/production-candidates/checkpoint-marker-sheet-r01/canvas.png,art/production-candidates/checkpoint-marker-sheet-r01/prompt.txt,tools/prepare-checkpoint.mjs` (Two directly painted static states, equal192x320 cells, full-canvas resolution conversion then base registration.); reason: undefined. Confirm it reads as the intended action.
- `vfx_checkpoint_activate`: generated_sheet of `art/production-candidates/checkpoint-effect-sheet-r01/raw.png,art/production-candidates/checkpoint-effect-sheet-r01/canvas.png,art/production-candidates/checkpoint-effect-sheet-r01/prompt.txt,tools/prepare-checkpoint.mjs` (Eight directly painted phases; actual generated sheet row split y438 retained in raw cells. One uniform bounded0.85 correction for ALL phases, preserving relative sizes, then base registration. No per-frame size normalization. Remove only alpha<=8 extraction remnants, premultiplied bilinear resampling.); reason: undefined. Confirm it reads as the intended action.

## Files

- `strip_vfx_checkpoint_activate.png`
- `onion_vfx_checkpoint_activate.png`
- `strip_prop_checkpoint.png`
- `onion_prop_checkpoint.png`

prop_checkpoint is a STATIC two-state prop from ASSET_BRIEFS §9, not a timed particle animation. Its scoped vfx classification only enables non-character canvas/base/border measurements. Both ms=0 states are selected by checkpoint state; no timed prop playback. Original animation contract is unchanged.
