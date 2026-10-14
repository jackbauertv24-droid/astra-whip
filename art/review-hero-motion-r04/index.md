# Art review pack

Frames: `/config/codex-workspace/astra-whip/art/frames` · contract 0.2.0 · 19 clips present, 45 missing.

Follow `prompts/ART_REVIEW.md`. Do the steps in this order and do not read `audit.md` or the clip intents until step 3.

1. **Blind description.** For each lineup, then each strip, write what you see in plain words before anything else.
   - `lineup_hero.png`
2. **Motion.** Read every `onion_*.png`: does each pair read as one continuous movement of the same body?
3. **Intent and checks.** Now read the contract and `audit.md`, compare, and adjudicate every FLAG.
4. **Attacks.** `composite_*.png`: whip held in the fist (cyan cross), reach covers the yellow hitbox on active frames.

Audit: **2 DEFECT, 12 FLAG** (see `audit.md`).

## Derived clips (ART_CONTRACT §11)

- `hero_idle`: scripted_fallback of `art/frames/style_hero_neutral/f000.png` (Planted feet; rigid head translation with a two-pixel breathing displacement easing through the chest to zero at hips.); reason: Generated whole-clip sheet failed G-02 / A-05 / A-06. See art/rejected/idle-sheet-r01/audit/audit.md.. Confirm it reads as the intended action.
- `hero_crouch_exit`: reversed of `hero_crouch_enter` (Exact reverse of entry frames.); reason: ART_CONTRACT §11 explicitly permits crouch exit reversal.. Confirm it reads as the intended action.
- `hero_crouch_idle`: scripted_fallback of `art/production-candidates/hero_crouch-key-v2.png` (Rigid head and shoulder breathing above folded hips, planted boots, one-pixel inhale and settle.); reason: Generated whole-clip sheet failed contract scale checks. Uses independently reviewed painted key; secondary motion remains subject to the full clip review.. Confirm it reads as the intended action.
- `hero_jump_rise`: scripted_fallback of `art/frames/style_hero_neutral/f000.png,art/review-hero-keys-r05/key_2.png,art/review-hero-keys-r05/key_3.png,art/review-hero-keys-r05/key_4.png,art/review-hero-keys-r05/key_5.png,art/review-hero-keys-r05/key_6.png,art/review-hero-keys-r05/key_7.png,art/review-hero-keys-r05/key_8.png,art/review-hero-keys-r04/key_6.png,art/frames/hero_crouch_enter/f001.png` (A rising one-knee pose folds the trailing leg, progresses to a painted two-knee tuck, and settles the cape. Authored horizontal origin retained.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_jump_apex`: reused of `art/frames/style_hero_neutral/f000.png,art/review-hero-keys-r05/key_2.png,art/review-hero-keys-r05/key_3.png,art/review-hero-keys-r05/key_4.png,art/review-hero-keys-r05/key_5.png,art/review-hero-keys-r05/key_6.png,art/review-hero-keys-r05/key_7.png,art/review-hero-keys-r05/key_8.png,art/review-hero-keys-r04/key_6.png,art/frames/hero_crouch_enter/f001.png` (Two-knee suspension releases to one-knee balance and finally the painted extended-leg descent posture.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_fall`: scripted_fallback of `art/frames/style_hero_neutral/f000.png,art/review-hero-keys-r05/key_2.png,art/review-hero-keys-r05/key_3.png,art/review-hero-keys-r05/key_4.png,art/review-hero-keys-r05/key_5.png,art/review-hero-keys-r05/key_6.png,art/review-hero-keys-r05/key_7.png,art/review-hero-keys-r05/key_8.png,art/review-hero-keys-r04/key_6.png,art/frames/hero_crouch_enter/f001.png` (Distinct downward-leg key with rear calf rotating about its knee, lifted cloak flutter, and forward arm response; returns continuously to the loop start.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_hurt_recoil`: scripted_fallback of `art/frames/style_hero_neutral/f000.png,art/review-hero-keys-r05/key_2.png,art/review-hero-keys-r05/key_3.png,art/review-hero-keys-r05/key_4.png,art/review-hero-keys-r05/key_5.png,art/review-hero-keys-r05/key_6.png,art/review-hero-keys-r05/key_7.png,art/review-hero-keys-r05/key_8.png,art/review-hero-keys-r04/key_6.png,art/frames/hero_crouch_enter/f001.png` (Painted torso/head flinch with defensive arm and knee articulation, followed by guarded release and recovery. Original endpoints retained.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_knockback`: scripted_fallback of `art/frames/style_hero_neutral/f000.png,art/review-hero-keys-r05/key_2.png,art/review-hero-keys-r05/key_3.png,art/review-hero-keys-r05/key_4.png,art/review-hero-keys-r05/key_5.png,art/review-hero-keys-r05/key_6.png,art/review-hero-keys-r05/key_7.png,art/review-hero-keys-r05/key_8.png,art/review-hero-keys-r04/key_6.png,art/frames/hero_crouch_enter/f001.png` (Impact changes the neutral stance into a painted defensive backward lean, then knees/arms/cloth sustain that response during physical displacement.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_turn`: reused of `art/frames/style_hero_neutral/f000.png,art/review-hero-keys-r05/key_2.png,art/review-hero-keys-r05/key_3.png,art/review-hero-keys-r05/key_4.png,art/review-hero-keys-r05/key_5.png,art/review-hero-keys-r05/key_6.png,art/review-hero-keys-r05/key_7.png,art/review-hero-keys-r05/key_8.png,art/review-hero-keys-r04/key_6.png,art/frames/hero_crouch_enter/f001.png` (Planted weight anticipation, a painted hip/shoulder twist with pivot foot loaded, then a neutral settling stance.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_walk`: scripted_fallback of `art/production-candidates/hero_walk-key-edge-clean.png,art/production-candidates/hero_passing-key-v2-edge-clean.png,art/review-hero-keys-r06/key_3.png,art/production-candidates/hero_passing-b-key-edge-clean.png,art/frames/style_hero_neutral/f000.png` (Four approved painted contact/passing keys; near/far leg masks interpolated along measured hip/knee/ankle/foot paths, nearest-parent paint retained without texture cross-fades, near leg composited last. Neutral head reused rigidly with a feathered neck join. Authored horizontal origin preserved. Named middle-frame replacements F3/F4/F6 are direct normalized AI-painted in-betweens, with no scripted body deformation. Revision r05: only F3/F4/F6 replaced using separately articulated support/swing legs from approved passing/contact poses; support sole remains grounded while other boot swings forward. Upper torso/head/hand retained from immediate neighbours. Revision r05: only F3/F4/F6 replaced using separately articulated support/swing legs from approved passing/contact poses; support sole remains grounded while other boot swings forward. Upper torso/head/hand retained from immediate neighbours.); reason: Generated sheets failed scale; first rig and held-pose gait failed visual continuity. This full alternating candidate requires independent motion acceptance.. Confirm it reads as the intended action.
- `hero_start_move`: reused of `art/frames/style_hero_neutral/f000.png,art/production-candidates/hero_passing-b-key-edge-clean.png,art/production-candidates/hero_walk-key-edge-clean.png` (Transition between neutral, lifted-foot and contact poses.); reason: Shared painted gait poses permitted by ART_CONTRACT §11.. Confirm it reads as the intended action.
- `hero_stop_move`: reused of `art/frames/style_hero_neutral/f000.png,art/review-hero-keys-r05/key_2.png,art/review-hero-keys-r05/key_3.png,art/review-hero-keys-r05/key_4.png,art/review-hero-keys-r05/key_5.png,art/review-hero-keys-r05/key_6.png,art/review-hero-keys-r05/key_7.png,art/review-hero-keys-r05/key_8.png,art/review-hero-keys-r04/key_6.png,art/frames/hero_crouch_enter/f001.png` (Front contact, planted knee/hip compression for braking, then upright settle. Named middle frame replaced.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_jump_takeoff`: reused of `art/frames/style_hero_neutral/f000.png,art/review-hero-keys-r05/key_2.png,art/review-hero-keys-r05/key_3.png,art/review-hero-keys-r05/key_4.png,art/review-hero-keys-r05/key_5.png,art/review-hero-keys-r05/key_6.png,art/review-hero-keys-r05/key_7.png,art/review-hero-keys-r05/key_8.png,art/review-hero-keys-r04/key_6.png,art/frames/hero_crouch_enter/f001.png` (Neutral load, planted compression, then articulated airborne push-off.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_land`: scripted_fallback of `art/frames/style_hero_neutral/f000.png,art/review-hero-keys-r05/key_2.png,art/review-hero-keys-r05/key_3.png,art/review-hero-keys-r05/key_4.png,art/review-hero-keys-r05/key_5.png,art/review-hero-keys-r05/key_6.png,art/review-hero-keys-r05/key_7.png,art/review-hero-keys-r05/key_8.png,art/review-hero-keys-r04/key_6.png,art/frames/hero_crouch_enter/f001.png` (Airborne contact, planted knee/hip compression, a small articulated release, then upright recovery.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_knockdown`: scripted_fallback of `art/frames/style_hero_neutral/f000.png,art/review-hero-keys-r05/key_2.png,art/review-hero-keys-r05/key_3.png,art/review-hero-keys-r05/key_4.png,art/review-hero-keys-r05/key_5.png,art/review-hero-keys-r05/key_6.png,art/review-hero-keys-r05/key_7.png,art/review-hero-keys-r05/key_8.png,art/review-hero-keys-r04/key_6.png,art/frames/hero_crouch_enter/f001.png` (Backward painted flinch, bracing mid-fall, hip/elbow ground contact, then clothing settle.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_get_up`: reversed of `art/frames/style_hero_neutral/f000.png,art/review-hero-keys-r05/key_2.png,art/review-hero-keys-r05/key_3.png,art/review-hero-keys-r05/key_4.png,art/review-hero-keys-r05/key_5.png,art/review-hero-keys-r05/key_6.png,art/review-hero-keys-r05/key_7.png,art/review-hero-keys-r05/key_8.png,art/review-hero-keys-r04/key_6.png,art/frames/hero_crouch_enter/f001.png` (Exact reverse of reviewed-reference fall candidates: elbow/hip support, bracing hand, then rising defensive stance. Must read as recovery in independent review.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.
- `hero_death`: scripted_fallback of `art/frames/style_hero_neutral/f000.png,art/review-hero-keys-r05/key_2.png,art/review-hero-keys-r05/key_3.png,art/review-hero-keys-r05/key_4.png,art/review-hero-keys-r05/key_5.png,art/review-hero-keys-r05/key_6.png,art/review-hero-keys-r05/key_7.png,art/review-hero-keys-r05/key_8.png,art/review-hero-keys-r04/key_6.png,art/frames/hero_crouch_enter/f001.png` (Full flinch and backward collapse through hip support into a painted resting body, followed by quiet fabric settle and a final hold. No get-up route.); reason: Approved painted body keys supply articulated action poses after the earlier secondary-motion candidates failed independent review. All newly assembled clips require fresh motion review.. Confirm it reads as the intended action.

## Missing clips

- `hero_attack_ground`
- `hero_attack_air`
- `hero_attack_crouch`
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
- `strip_hero_idle.png`
- `onion_hero_idle.png`
- `strip_hero_walk.png`
- `onion_hero_walk.png`
- `strip_hero_start_move.png`
- `onion_hero_start_move.png`
- `strip_hero_stop_move.png`
- `onion_hero_stop_move.png`
- `strip_hero_turn.png`
- `onion_hero_turn.png`
- `strip_hero_crouch_enter.png`
- `onion_hero_crouch_enter.png`
- `strip_hero_crouch_idle.png`
- `onion_hero_crouch_idle.png`
- `strip_hero_crouch_exit.png`
- `onion_hero_crouch_exit.png`
- `strip_hero_jump_takeoff.png`
- `onion_hero_jump_takeoff.png`
- `strip_hero_jump_rise.png`
- `onion_hero_jump_rise.png`
- `strip_hero_jump_apex.png`
- `onion_hero_jump_apex.png`
- `strip_hero_fall.png`
- `onion_hero_fall.png`
- `strip_hero_land.png`
- `onion_hero_land.png`
- `strip_hero_hurt_recoil.png`
- `onion_hero_hurt_recoil.png`
- `strip_hero_knockback.png`
- `onion_hero_knockback.png`
- `strip_hero_knockdown.png`
- `onion_hero_knockdown.png`
- `strip_hero_get_up.png`
- `onion_hero_get_up.png`
- `strip_hero_death.png`
- `onion_hero_death.png`
