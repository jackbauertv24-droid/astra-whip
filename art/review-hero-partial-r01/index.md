# Art review pack

Frames: `/config/codex-workspace/astra-whip/art/frames` · contract 0.2.0 · 14 clips present, 50 missing.

Follow `prompts/ART_REVIEW.md`. Do the steps in this order and do not read `audit.md` or the clip intents until step 3.

1. **Blind description.** For each lineup, then each strip, write what you see in plain words before anything else.
   - `lineup_hero.png`
2. **Motion.** Read every `onion_*.png`: does each pair read as one continuous movement of the same body?
3. **Intent and checks.** Now read the contract and `audit.md`, compare, and adjudicate every FLAG.
4. **Attacks.** `composite_*.png`: whip held in the fist (cyan cross), reach covers the yellow hitbox on active frames.

Audit: **0 DEFECT, 6 FLAG** (see `audit.md`).

## Derived clips (ART_CONTRACT §11)

- `hero_idle`: scripted_fallback of `art/frames/style_hero_neutral/f000.png` (Planted feet; rigid head translation with a two-pixel breathing displacement easing through the chest to zero at hips.); reason: Generated whole-clip sheet failed G-02 / A-05 / A-06. See art/rejected/idle-sheet-r01/audit/audit.md.. Confirm it reads as the intended action.
- `hero_crouch_exit`: reversed of `hero_crouch_enter` (Exact reverse of entry frames.); reason: ART_CONTRACT §11 explicitly permits crouch exit reversal.. Confirm it reads as the intended action.
- `hero_crouch_idle`: scripted_fallback of `art/production-candidates/hero_crouch-key-v2.png` (Rigid head and shoulder breathing above folded hips, planted boots, one-pixel inhale and settle.); reason: Generated whole-clip sheet failed contract scale checks. Uses independently reviewed painted key; secondary motion remains subject to the full clip review.. Confirm it reads as the intended action.
- `hero_jump_rise`: scripted_fallback of `art/production-candidates/hero_air-key-v2.png` (Restrained knee tuck and trailing coat progression from the approved airborne pose.); reason: Generated whole-clip sheet failed contract scale checks. Uses independently reviewed painted key; secondary motion remains subject to the full clip review.. Confirm it reads as the intended action.
- `hero_jump_apex`: scripted_fallback of `art/production-candidates/hero_air-key-v2.png` (Tuck releases as upward motion stops; coat settles.); reason: Generated whole-clip sheet failed contract scale checks. Uses independently reviewed painted key; secondary motion remains subject to the full clip review.. Confirm it reads as the intended action.
- `hero_fall`: scripted_fallback of `art/production-candidates/hero_air-key-v2.png` (Leg extension and cloth flutter during descent with a continuous loop seam.); reason: Generated whole-clip sheet failed contract scale checks. Uses independently reviewed painted key; secondary motion remains subject to the full clip review.. Confirm it reads as the intended action.
- `hero_hurt_recoil`: scripted_fallback of `art/frames/style_hero_neutral/f000.png` (Torso and head recoil together about planted feet, then recover; no global resize.); reason: Generated whole-clip sheet failed contract scale checks. Uses independently reviewed painted key; secondary motion remains subject to the full clip review.. Confirm it reads as the intended action.
- `hero_knockback`: scripted_fallback of `art/frames/style_hero_neutral/f000.png` (Sustained backward torso lean during state-driven horizontal knockback.); reason: Generated whole-clip sheet failed contract scale checks. Uses independently reviewed painted key; secondary motion remains subject to the full clip review.. Confirm it reads as the intended action.
- `hero_turn`: scripted_fallback of `art/frames/style_hero_neutral/f000.png` (Three weight-transfer poses at the facing transition, with direction controlled by gameplay.); reason: Generated whole-clip sheet failed contract scale checks. Uses independently reviewed painted key; secondary motion remains subject to the full clip review.. Confirm it reads as the intended action.
- `hero_walk`: scripted_fallback of `art/production-candidates/hero_walk-key-edge-clean.png,art/production-candidates/hero_passing-key-v2-edge-clean.png,art/production-candidates/hero_contact-b-key-v2-edge-clean.png,art/production-candidates/hero_passing-b-key-edge-clean.png` (Four independently reviewed painted gait poses with small weight/coat settle in-betweens; ten-frame sequence.); reason: Whole-clip generation failed size contract; leg-cutout attempt was visually rejected and archived. Painted pose assembly still requires motion approval.. Confirm it reads as the intended action.
- `hero_start_move`: reused of `art/frames/style_hero_neutral/f000.png,art/production-candidates/hero_passing-b-key-edge-clean.png,art/production-candidates/hero_walk-key-edge-clean.png` (Transition between neutral, lifted-foot and contact poses.); reason: Shared painted gait poses permitted by ART_CONTRACT §11.. Confirm it reads as the intended action.
- `hero_stop_move`: reused of `art/production-candidates/hero_walk-key-edge-clean.png,art/production-candidates/hero_passing-b-key-edge-clean.png,art/frames/style_hero_neutral/f000.png` (Transition between neutral, lifted-foot and contact poses.); reason: Shared painted gait poses permitted by ART_CONTRACT §11.. Confirm it reads as the intended action.

## Missing clips

- `hero_jump_takeoff`
- `hero_land`
- `hero_attack_ground`
- `hero_attack_air`
- `hero_attack_crouch`
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
- `strip_hero_jump_rise.png`
- `onion_hero_jump_rise.png`
- `strip_hero_jump_apex.png`
- `onion_hero_jump_apex.png`
- `strip_hero_fall.png`
- `onion_hero_fall.png`
- `strip_hero_hurt_recoil.png`
- `onion_hero_hurt_recoil.png`
- `strip_hero_knockback.png`
- `onion_hero_knockback.png`
