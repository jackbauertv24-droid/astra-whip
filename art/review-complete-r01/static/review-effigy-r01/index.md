# Art review pack

Frames: `/config/codex-workspace/astra-whip/art/review-effigy-r01/frames` · contract 0.2.0 · 1 clips present.

Follow `prompts/ART_REVIEW.md`. Do the steps in this order and do not read `audit.md` or the clip intents until step 3.

1. **Blind description.** For each lineup, then each strip, write what you see in plain words before anything else.
2. **Motion.** Read every `onion_*.png`: does each pair read as one continuous movement of the same body?
3. **Intent and checks.** Now read the contract and `audit.md`, compare, and adjudicate every FLAG.
4. **Attacks.** `composite_*.png`: whip held in the fist (cyan cross), reach covers the yellow hitbox on active frames.

Audit: **0 DEFECT, 0 FLAG** (see `audit.md`).

## Derived clips (ART_CONTRACT §11)

- `prop_effigy`: generated_key of `art/production-candidates/effigy-key-r01/raw.png,art/production-candidates/effigy-key-r01/canvas.png,art/production-candidates/effigy-key-r01/prompt.txt,tools/prepare-effigy.mjs` (Uniform full-canvas resolution conversion followed by integer ink-centre/base registration. No scaling or deformation. Remove only alpha<=8 extraction remnants.); reason: undefined. Confirm it reads as the intended action.

## Files

- `strip_prop_effigy.png`

Static prop, not timed effect; scoped vfx classification only enables non-character canvas/base/border checks. ASSET_BRIEFS §9:128×256, floor pivot64,224, one intact state. No onion pairs for a single static frame. Original animation contract unchanged.
