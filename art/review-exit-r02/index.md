# Art review pack

Frames: `/config/codex-workspace/astra-whip/art/review-exit-r02/frames` · contract 0.2.0 · 1 clips present.

Follow `prompts/ART_REVIEW.md`. Do the steps in this order and do not read `audit.md` or the clip intents until step 3.

1. **Blind description.** For each lineup, then each strip, write what you see in plain words before anything else.
2. **Motion.** Read every `onion_*.png`: does each pair read as one continuous movement of the same body?
3. **Intent and checks.** Now read the contract and `audit.md`, compare, and adjudicate every FLAG.
4. **Attacks.** `composite_*.png`: whip held in the fist (cyan cross), reach covers the yellow hitbox on active frames.

Audit: **0 DEFECT, 0 FLAG** (see `audit.md`).

## Derived clips (ART_CONTRACT §11)

- `prop_exit`: generated_key of `art/production-candidates/exit-key-r01/raw.png,art/production-candidates/exit-key-r01/canvas.png,art/production-candidates/exit-key-r01/prompt.txt,tools/prepare-exit.mjs,tools/normalize-frame.mjs` (Uniform full-canvas conversion, remove only alpha<=8 extraction remnants, then one bounded uniform correction to fit the floor anchor with a transparent top margin. No shape deformation or per-state painted changes; active state is the briefed engine Ember tint.); reason: undefined. Confirm it reads as the intended action.

## Files

- `strip_prop_exit.png`

Static oneframe door192×320,base96,288,ASSET_BRIEFS §9. Engine Ember tint distinguishes unlocked state;scoped vfx classification only enables non-character canvas/base/border checks,ms0 is static. No onionpair; original animation contract unchanged.
