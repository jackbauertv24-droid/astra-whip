# Art review pack

Frames: `/config/codex-workspace/astra-whip/art/review-boss-hazard-r02/frames` · contract 0.2.0 · 12 clips present.

Follow `prompts/ART_REVIEW.md`. Do the steps in this order and do not read `audit.md` or the clip intents until step 3.

1. **Blind description.** For each lineup, then each strip, write what you see in plain words before anything else.
   - `lineup_boss.png`
2. **Motion.** Read every `onion_*.png`: does each pair read as one continuous movement of the same body?
3. **Intent and checks.** Now read the contract and `audit.md`, compare, and adjudicate every FLAG.
4. **Attacks.** `composite_*.png`: whip held in the fist (cyan cross), reach covers the yellow hitbox on active frames.

Audit: **0 DEFECT, 0 FLAG** (see `audit.md`).

## Derived clips (ART_CONTRACT §11)

- `boss_hazard_windup`: scripted_fallback of `art/frames/boss_idle/f000.png,art/production-candidates/boss-hazard-key-r01/registered.png,art/production-candidates/boss-hazard-key-r01/raw.png,tools/prepare-boss-hazard.mjs,tools/lib/boss-supported-pose.mjs` (Generated articulated open palm, cropped by recorded polygon and attached to the approved three-piece front-arm rig. Original helmet,body,small rear arm,plated legs and fixed soles are preserved. Supported torso loading and closed-gauntlet stoop return use the approved support rig. Windup opens forward below shoulder height; execution presses down and releases to the knee; recovery returns to exact neutral. Low-alpha resampling cleanup is explicit in the rig source.); reason: The full generated key changes the approved boot placement and stance width; reuse only its new hand paint to preserve planted-foot continuity.. Confirm it reads as the intended action.
- `boss_hazard_execute`: scripted_fallback of `art/frames/boss_idle/f000.png,art/production-candidates/boss-hazard-key-r01/registered.png,art/production-candidates/boss-hazard-key-r01/raw.png,tools/prepare-boss-hazard.mjs,tools/lib/boss-supported-pose.mjs` (Generated articulated open palm, cropped by recorded polygon and attached to the approved three-piece front-arm rig. Original helmet,body,small rear arm,plated legs and fixed soles are preserved. Supported torso loading and closed-gauntlet stoop return use the approved support rig. Windup opens forward below shoulder height; execution presses down and releases to the knee; recovery returns to exact neutral. Low-alpha resampling cleanup is explicit in the rig source.); reason: The full generated key changes the approved boot placement and stance width; reuse only its new hand paint to preserve planted-foot continuity.. Confirm it reads as the intended action.
- `boss_hazard_recover`: scripted_fallback of `art/frames/boss_idle/f000.png,art/production-candidates/boss-hazard-key-r01/registered.png,art/production-candidates/boss-hazard-key-r01/raw.png,tools/prepare-boss-hazard.mjs,tools/lib/boss-supported-pose.mjs` (Generated articulated open palm, cropped by recorded polygon and attached to the approved three-piece front-arm rig. Original helmet,body,small rear arm,plated legs and fixed soles are preserved. Supported torso loading and closed-gauntlet stoop return use the approved support rig. Windup opens forward below shoulder height; execution presses down and releases to the knee; recovery returns to exact neutral. Low-alpha resampling cleanup is explicit in the rig source.); reason: The full generated key changes the approved boot placement and stance width; reuse only its new hand paint to preserve planted-foot continuity.. Confirm it reads as the intended action.
- `boss_idle`: scripted_fallback of `art/frames/boss_walk/f000.png,tools/prepare-boss-idle.mjs` (Reuse accepted walk neutral support, local0–2px inhale above hips,0.6px shroud sway,unchanged boots/pivot and no actor scale. Eight125ms samples complete a1s loop.); reason: D23 continuation from approved boss construction after generated sheet failed actor scale/registration; local idle requires fresh motion/runtime review. Scripted animation remains quality debt.. Confirm it reads as the intended action.
- `boss_walk`: scripted_fallback of `art/production-candidates/boss-identity-r01/key.png,tools/prepare-boss-walk.mjs` (Two connected plated-leg bone rigs with fixed-length upper/lower segments, flat translated boots, alternating60% stance,22px swing clearance,89.6px stride, small weight/shroud response; no global scale or per-frame recenter.); reason: Generated eight-frame sheet enlarged actors to485–503px versus352px and changed root registration; retained raw/equal crops/rejection. D23 local rig requires fresh full gait/runtime review and remains scripted animation quality debt.. Confirm it reads as the intended action.
- `boss_hurt`: scripted_fallback of `art/frames/boss_idle/f000.png,tools/prepare-boss-hurt.mjs` (Small connected4° upper-body recoil easing through hips to fixed legs/soles,2° release and exact neutral endpoint. No global scaling or actor recentering.); reason: D23 continuation from approved boss construction after retained generated sheet failed scale/registration; brief local hurt must pass fresh action/runtime review. Scripted motion remains quality debt.. Confirm it reads as the intended action.
- `boss_hurt_stooped`: scripted_fallback of `art/frames/boss_idle/f000.png,tools/prepare-boss-strike.mjs,tools/lib/boss-supported-pose.mjs` (Posture-aware70/70/60ms flinch from the same supported leg/torso rig; fixed soles,rigid upright head and connected counter-recoil. Late variants release toward the pose due after the200ms interruption.); reason: A neutral standing hurt would pop out of a supported recovery. Supplemental context poses preserve the stance and handoff without changing mandatory timings or AI clocks.. Confirm it reads as the intended action.
- `boss_hurt_rising`: scripted_fallback of `art/frames/boss_idle/f000.png,tools/prepare-boss-strike.mjs,tools/lib/boss-supported-pose.mjs` (Posture-aware70/70/60ms flinch from the same supported leg/torso rig; fixed soles,rigid upright head and connected counter-recoil. Late variants release toward the pose due after the200ms interruption.); reason: A neutral standing hurt would pop out of a supported recovery. Supplemental context poses preserve the stance and handoff without changing mandatory timings or AI clocks.. Confirm it reads as the intended action.
- `boss_hurt_half_stoop`: scripted_fallback of `art/frames/boss_idle/f000.png,tools/prepare-boss-strike.mjs,tools/lib/boss-supported-pose.mjs` (Posture-aware70/70/60ms flinch from the same supported leg/torso rig; fixed soles,rigid upright head and connected counter-recoil. Late variants release toward the pose due after the200ms interruption.); reason: A neutral standing hurt would pop out of a supported recovery. Supplemental context poses preserve the stance and handoff without changing mandatory timings or AI clocks.. Confirm it reads as the intended action.
- `boss_hurt_hazard_late`: scripted_fallback of `art/frames/boss_idle/f000.png,tools/prepare-boss-hazard.mjs,tools/lib/boss-supported-pose.mjs` (Fixed-sole supported12→6→0degree release over70/70/60ms. This supplemental flinch finishes at the neutral pose due after a late hazard-recovery hit.); reason: The900ms hazard recovery reaches neutral sooner than the1100ms strike recovery.. Confirm it reads as the intended action.
- `vfx_hazard_telegraph`: generated_sheet of `art/production-candidates/hazard-fx-keys-r01/telegraph-sheet-corrected-raw.png,art/production-candidates/hazard-fx-keys-r01/telegraph-sheet-correction-prompt-r02.txt` (Four directly painted sustained warning frames, uniform canvas-resolution conversion, then base-anchor registration only. No scripted animation or global size curve.); reason: Paired floor signal required for the boss hazard tell.. Confirm it reads as the intended action.
- `vfx_hazard_eruption`: reused of `art/production-candidates/hazard-fx-keys-r01/eruption-sheet-raw.png,art/production-candidates/hazard-fx-keys-r01/eruption-sheet-prompt.txt,art/frames/vfx_hazard_telegraph/f003.png` (Six directly painted eruption frames share one bounded uniform0.8518518518518519 scale to honor the46u height ceiling, base-anchor registration and the reused full-width warning gutter. Fire motion is directly painted; no procedural animation or phase interpolation.); reason: The generated peak measured108sourcepixels; shared92/108 normalization preserves relative phase sizes. A persistent full-width gutter marks the complete dangerous zone throughout the400ms eruption.. Confirm it reads as the intended action.

## Files

- `lineup_boss.png`
- `strip_boss_hazard_windup.png`
- `onion_boss_hazard_windup.png`
- `strip_boss_hazard_execute.png`
- `onion_boss_hazard_execute.png`
- `strip_boss_hazard_recover.png`
- `onion_boss_hazard_recover.png`
- `strip_boss_idle.png`
- `onion_boss_idle.png`
- `strip_boss_walk.png`
- `onion_boss_walk.png`
- `strip_boss_hurt.png`
- `onion_boss_hurt.png`
- `strip_boss_hurt_stooped.png`
- `onion_boss_hurt_stooped.png`
- `strip_boss_hurt_rising.png`
- `onion_boss_hurt_rising.png`
- `strip_boss_hurt_half_stoop.png`
- `onion_boss_hurt_half_stoop.png`
- `strip_boss_hurt_hazard_late.png`
- `onion_boss_hurt_hazard_late.png`
- `strip_vfx_hazard_telegraph.png`
- `onion_vfx_hazard_telegraph.png`
- `strip_vfx_hazard_eruption.png`
- `onion_vfx_hazard_eruption.png`
