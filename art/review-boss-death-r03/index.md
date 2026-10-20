# Art review pack

Frames: `/config/codex-workspace/astra-whip/art/review-boss-death-r03/frames` · contract 0.2.0 · 4 clips present.

Follow `prompts/ART_REVIEW.md`. Do the steps in this order and do not read `audit.md` or the clip intents until step 3.

1. **Blind description.** For each lineup, then each strip, write what you see in plain words before anything else.
   - `lineup_boss.png`
2. **Motion.** Read every `onion_*.png`: does each pair read as one continuous movement of the same body?
3. **Intent and checks.** Now read the contract and `audit.md`, compare, and adjudicate every FLAG.
4. **Attacks.** `composite_*.png`: whip held in the fist (cyan cross), reach covers the yellow hitbox on active frames.

Audit: **0 DEFECT, 4 FLAG** (see `audit.md`).

## Derived clips (ART_CONTRACT §11)

- `boss_death`: scripted_fallback of `art/frames/boss_idle/f000.png,art/production-candidates/boss-death-kneel-r01/canvas.png,art/production-candidates/boss-death-fold-r01/canvas.png,art/production-candidates/boss-death-settle-r01/canvas.png,art/production-candidates/boss-death-bridge-r01/canvas.png,art/production-candidates/boss-death-ash-r01/canvas.png,tools/prepare-boss-death.mjs,tools/lib/boss-supported-pose.mjs` (Approved neutral and fixed-sole articulated loading; generated kneeling, folding and settled keys with integer root/floor registration; a separately painted supported-hand inbetween; two seeded irregular edge-distance ash-erosion frames and newly painted ash final. Bounded uniform physical-size corrections0.95/0.90 are recorded per generated key; collapsed height is never normalized to standing height. No full-length horizontal fall. Final local ash effect sized0.65 about its floor anchor. Low-alpha resampling cleanup<=4 is explicit.); reason: D23 candidate continuation; independently generated joint-folded keys retain source detail and require fresh motion/runtime approval. Scripted rig and erosion are declared quality debt.. Confirm it reads as the intended action.
- `boss_idle`: scripted_fallback of `art/frames/boss_walk/f000.png,tools/prepare-boss-idle.mjs` (Reuse accepted walk neutral support, local0–2px inhale above hips,0.6px shroud sway,unchanged boots/pivot and no actor scale. Eight125ms samples complete a1s loop.); reason: D23 continuation from approved boss construction after generated sheet failed actor scale/registration; local idle requires fresh motion/runtime review. Scripted animation remains quality debt.. Confirm it reads as the intended action.
- `boss_walk`: scripted_fallback of `art/production-candidates/boss-identity-r01/key.png,tools/prepare-boss-walk.mjs` (Two connected plated-leg bone rigs with fixed-length upper/lower segments, flat translated boots, alternating60% stance,22px swing clearance,89.6px stride, small weight/shroud response; no global scale or per-frame recenter.); reason: Generated eight-frame sheet enlarged actors to485–503px versus352px and changed root registration; retained raw/equal crops/rejection. D23 local rig requires fresh full gait/runtime review and remains scripted animation quality debt.. Confirm it reads as the intended action.
- `boss_strike_recover`: scripted_fallback of `art/frames/boss_idle/f000.png,tools/prepare-boss-strike.mjs,tools/lib/boss-supported-pose.mjs` (Connected three-piece arm articulation around a fixed clavicle joint, original torso/legs, held raised silhouette, forward sweep,arm release and supported bent-knee,gauntlet-on-knee stoop with upright counterrotating head and a progressive rise; exact neutral endpoints, no global actor scale/recenter. Original shoulder-cap paint retained behind raised arm.); reason: Generated apex enlarged standing-body baseline and reached only1.259×bodyheight. D23 fallback from approved neutral requires fresh anatomy/tell/cycle/runtime review; scripted motion quality debt remains.. Confirm it reads as the intended action.

## Files

- `lineup_boss.png`
- `strip_boss_death.png`
- `onion_boss_death.png`
- `strip_boss_idle.png`
- `onion_boss_idle.png`
- `strip_boss_walk.png`
- `onion_boss_walk.png`
- `strip_boss_strike_recover.png`
- `onion_boss_strike_recover.png`

## Engine capture inventory

See scope.json and evidence/boss-death-r03-{native,phone}/capture.json. Four fixtures per resolution: both facings, standing and supported strike-recovery entry. Each starts at production8HP, earns seven actual whip hits, explicitly selects its entry state, then records the eighth actual lethal whip, all twelve90ms samples,1080ms unlock,1140ms cleanup fade and post1200ms removal. First90ms uses the exact source body texture visible at lethal contact, recorded as death_entry_animation/frame; f1 onward follows the common authored death sequence. This runtime entry uses already delivered body paint. Native size1280×720; phone root texture698×393 from an852×393 window. Other foes are hidden; isolated controller fixtures, not full arena traversal or physical-device tests.

Derivations include all bounded corrections, per-frame cleanup counts, generatedraw/prompt/provenance sources and edge-erosion construction. Full metadata is in frames/{clips,derivations}.json and frames/boss_death/derivation.json. Original mandatory contract remains unchanged.
