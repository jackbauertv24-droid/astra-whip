# Art review pack

Frames: `/config/codex-workspace/astra-whip/art/frames-gait-review-r16` · contract 0.2.0 · 2 clips present, 62 missing.

Follow `prompts/ART_REVIEW.md`. Do the steps in this order and do not read `audit.md` or the clip intents until step 3.

1. **Blind description.** For each lineup, then each strip, write what you see in plain words before anything else.
   - `lineup_hero.png`
2. **Motion.** Read every `onion_*.png`: does each pair read as one continuous movement of the same body?
3. **Intent and checks.** Now read the contract and `audit.md`, compare, and adjudicate every FLAG.
4. **Attacks.** `composite_*.png`: whip held in the fist (cyan cross), reach covers the yellow hitbox on active frames.

Audit: **0 DEFECT, 0 FLAG** (see `audit.md`).

## Derived clips (ART_CONTRACT §11)

- `hero_idle`: scripted_fallback of `art/frames/style_hero_neutral/f000.png` (Planted feet; rigid head translation with a two-pixel breathing displacement easing through the chest to zero at hips.); reason: Generated whole-clip sheet failed G-02 / A-05 / A-06. See art/rejected/idle-sheet-r01/audit/audit.md.. Confirm it reads as the intended action.
- `hero_crouch_exit`: reversed of `hero_crouch_enter` (Exact reverse of entry frames.); reason: ART_CONTRACT §11 explicitly permits crouch exit reversal.. Confirm it reads as the intended action.
- `hero_crouch_idle`: scripted_fallback of `art/production-candidates/hero_crouch-key-v2.png` (Rigid head and shoulder breathing above folded hips, planted boots, one-pixel inhale and settle.); reason: Generated whole-clip sheet failed contract scale checks. Uses independently reviewed painted key; secondary motion remains subject to the full clip review.. Confirm it reads as the intended action.
- `hero_jump_rise`: scripted_fallback of `art/review-hero-keys-r05/key_4.png,art/review-hero-keys-r05/key_5.png` (A rising one-knee pose folds the trailing leg, progresses to a painted two-knee tuck, and settles the cape. Authored horizontal origin retained.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_jump_apex`: reused of `art/review-hero-keys-r05/key_5.png,art/review-hero-keys-r05/key_4.png,art/review-hero-keys-r05/key_6.png` (Two-knee suspension releases to one-knee balance and finally the painted extended-leg descent posture.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_fall`: scripted_fallback of `art/review-hero-keys-r05/key_6.png` (Distinct downward-leg key with rear calf rotating about its knee, lifted cloak flutter, and forward arm response; returns continuously to the loop start.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_hurt_recoil`: scripted_fallback of `art/frames/style_hero_neutral/f000.png,art/review-hero-keys-r05/key_3.png` (Painted torso/head flinch with defensive arm and knee articulation, followed by guarded release and recovery. Original endpoints retained.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_knockback`: scripted_fallback of `art/frames/style_hero_neutral/f000.png,art/review-hero-keys-r05/key_3.png` (Impact changes the neutral stance into a painted defensive backward lean, then knees/arms/cloth sustain that response during physical displacement.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_turn`: scripted_fallback of `art/production-candidates/hero_turn-neck-repair-key-r05.png,art/frames/style_hero_neutral/f000.png` (Planted weight anticipation, a painted hip/shoulder twist with pivot foot loaded, then a neutral settling stance; direct AI-painted neck repair retains the compact portrait and articulated twist.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_walk`: scripted_fallback of `art/production-candidates/hero_walk-key-edge-clean.png,art/production-candidates/hero_passing-key-v2-edge-clean.png,art/review-hero-keys-r06/key_3.png,art/production-candidates/hero_passing-b-key-edge-clean.png,art/frames/style_hero_neutral/f000.png,art/production-candidates/hero_walk-f3-key-r08.png,art/production-candidates/hero_walk-f4-key-r08.png,art/production-candidates/hero_walk-f5-key-r10.png,art/production-candidates/hero_walk-f6-boot-key-r09.png,art/production-candidates/hero_walk-f3-coat-key-r12.png,art/production-candidates/hero_walk-f4-coat-key-r12.png,art/production-candidates/hero_walk-f5-coat-key-r12.png,art/production-candidates/hero_walk-f6-coat-key-r12.png,art/production-candidates/hero_walk-f6-lift-key-r14.png` (Approved contact/passing keys supply articulated F0/F1/F2/F5/F6/F7/F8/F9, with approved neutral portrait reuse. F3/F4 are direct normalized painted near-coat/leg-depth poses and reuse the approved portrait rigidly with a feathered neck join after A08 failed. F5/F6 interpolate opposed contactB to passingB at0.6/0.8, retaining passingB upper body and independently articulated near/far legs so planted support advances continuously under the torso. F9 is distinct late-swing passingB-to-contactA at0.8. Runtime cleanup removes onlyalpha<=4; all candidates/rejections retained.); reason: Painted support-registration attempts failed intended coordinates and independent r14 rejected world-space foot slip/torso jump. ART_CONTRACT section11 fallback uses only independently approved body keys. Fresh full-loop review required.. Confirm it reads as the intended action.
- `hero_start_move`: reused of `art/frames/style_hero_neutral/f000.png,art/production-candidates/hero_passing-b-key-edge-clean.png,art/production-candidates/hero_walk-key-edge-clean.png` (Transition between neutral, lifted-foot and contact poses.); reason: Shared painted gait poses permitted by ART_CONTRACT §11.. Confirm it reads as the intended action.
- `hero_stop_move`: reused of `art/production-candidates/hero_walk-key-edge-clean.png,art/production-candidates/hero_brake-grounded-key-r03.png,art/frames/style_hero_neutral/f000.png` (Contact, direct painted grounded knee compression with rear boot drawing inward, then neutral settle. Middle body normalized once at 0.973214; approved neutral portrait reused rigidly 6 px down with feathered neck join after two generated portraits failed head tolerance. No limb deformation.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_jump_takeoff`: reused of `art/frames/style_hero_neutral/f000.png,art/frames/hero_crouch_enter/f001.png,art/review-hero-keys-r05/key_4.png` (Neutral load, planted compression, then articulated airborne push-off.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_land`: scripted_fallback of `art/review-hero-keys-r05/key_4.png,art/frames/hero_crouch_enter/f001.png,art/frames/style_hero_neutral/f000.png` (Airborne contact, planted knee/hip compression, a small articulated release, then upright recovery.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_knockdown`: scripted_fallback of `art/review-hero-keys-r05/key_3.png,art/review-hero-keys-r05/key_7.png,art/review-hero-keys-r04/key_6.png` (Backward painted flinch, bracing mid-fall, hip/elbow ground contact, then clothing settle.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_get_up`: reused of `art/review-hero-keys-r04/key_6.png,art/production-candidates/hero_getup-roll-key-r01.png,art/production-candidates/hero_getup-prep-key-r02.png,art/production-candidates/hero_getup-supported-key-r04.png,art/production-candidates/hero_getup-rise-key-r01.png,art/frames/style_hero_neutral/f000.png` (Initial floor-contact frame retained, then direct painted supported torso roll/leg draw-in, low recovery preparation, planted-palm/foot half-kneel, rising half-kneel, and stable neutral recovery. Each new painted pose individually normalized once with authored horizontal origin retained.); reason: The reverse-fall experiment failed supported recovery. Direct painted in-between poses replace held and unsupported frames; fresh independent motion review is required.. Confirm it reads as the intended action.
- `hero_death`: scripted_fallback of `art/review-hero-keys-r05/key_3.png,art/review-hero-keys-r05/key_7.png,art/review-hero-keys-r04/key_6.png,art/review-hero-keys-r05/key_8.png` (Full flinch and backward collapse through hip support into a painted resting body, followed by quiet fabric settle and a final hold. No get-up route.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.

## Missing clips

- `hero_idle`
- `hero_start_move`
- `hero_stop_move`
- `hero_turn`
- `hero_crouch_enter`
- `hero_crouch_idle`
- `hero_crouch_exit`
- `hero_jump_takeoff`
- `hero_jump_rise`
- `hero_jump_apex`
- `hero_fall`
- `hero_land`
- `hero_attack_ground`
- `hero_attack_air`
- `hero_attack_crouch`
- `hero_hurt_recoil`
- `hero_knockback`
- `hero_knockdown`
- `hero_get_up`
- `hero_death`
- `whip_attack_ground`
- `whip_attack_air`
- `whip_attack_crouch`
- `pursuer_idle`
- `pursuer_patrol_walk`
- `pursuer_alert`
- `pursuer_approach_walk`
- `pursuer_lunge_windup`
- `pursuer_lunge`
- `pursuer_recovery`
- `pursuer_hurt`
- `pursuer_death`
- `swooper_perch_idle`
- `swooper_cruise`
- `swooper_dive_telegraph`
- `swooper_dive`
- `swooper_recovery_climb`
- `swooper_hurt`
- `swooper_death_fall`
- `ranged_idle`
- `ranged_aim`
- `ranged_fire`
- `ranged_recover`
- `ranged_hurt`
- `ranged_death`
- `boss_idle`
- `boss_walk`
- `boss_turn`
- `boss_strike_windup`
- `boss_strike_execute`
- `boss_strike_recover`
- `boss_hazard_windup`
- `boss_hazard_execute`
- `boss_hazard_recover`
- `boss_hurt`
- `boss_death`
- `projectile_grave_shot`
- `vfx_whip_impact`
- `vfx_enemy_defeat`
- `vfx_checkpoint_activate`
- `vfx_hazard_telegraph`
- `vfx_hazard_eruption`

## Files

- `lineup_hero.png`
- `strip_style_hero_neutral.png`
- `strip_hero_walk.png`
- `onion_hero_walk.png`
