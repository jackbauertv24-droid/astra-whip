# Art review pack

Frames: `/config/codex-workspace/astra-whip/art/frames` · contract 0.2.0 · 6 clips present, 58 missing.

Follow `prompts/ART_REVIEW.md`. Do the steps in this order and do not read `audit.md` or the clip intents until step 3.

1. **Blind description.** For each lineup, then each strip, write what you see in plain words before anything else.
   - `lineup_hero.png`
2. **Motion.** Read every `onion_*.png`: does each pair read as one continuous movement of the same body?
3. **Intent and checks.** Now read the contract and `audit.md`, compare, and adjudicate every FLAG.
4. **Attacks.** `composite_*.png`: whip held in the fist (cyan cross), reach covers the yellow hitbox on active frames.

Audit: **0 DEFECT, 0 FLAG** (see `audit.md`).

## Derived clips (ART_CONTRACT §11)

- `hero_idle`: scripted_fallback of `art/frames/style_hero_neutral/f000.png` (Planted feet; rigid head translation with a two-pixel breathing displacement easing through the chest to zero at hips.); reason: Generated whole-clip sheet failed G-02 / A-05 / A-06. See art/rejected/idle-sheet-r01/audit/audit.md.. Confirm it reads as the intended action.
- `hero_walk`: scripted_fallback of `art/frames/style_hero_neutral/f000.png` (Opposed boot swings beneath the painted coat, body weight dip, arm counter-motion and trailing cloth. Painted layers retain their dimensions.); reason: Generated clip sheet failed the scale/identity delivery contract. Retained evidence: art/rejected/idle-sheet-r01/audit/audit.md. These articulated candidates require independent motion review.. Confirm it reads as the intended action.
- `hero_start_move`: scripted_fallback of `art/frames/style_hero_neutral/f000.png` (Three-frame acceleration into first stride; shares the approved neutral layers.); reason: Generated clip sheet failed the scale/identity delivery contract. Retained evidence: art/rejected/idle-sheet-r01/audit/audit.md. These articulated candidates require independent motion review.. Confirm it reads as the intended action.
- `hero_stop_move`: scripted_fallback of `art/frames/style_hero_neutral/f000.png` (Reversed acceleration pose settles to neutral.); reason: Generated clip sheet failed the scale/identity delivery contract. Retained evidence: art/rejected/idle-sheet-r01/audit/audit.md. These articulated candidates require independent motion review.. Confirm it reads as the intended action.
- `hero_turn`: scripted_fallback of `art/frames/style_hero_neutral/f000.png` (Shoulder and weight transition around planted boots; state-machine facing flip supplies direction change.); reason: Generated clip sheet failed the scale/identity delivery contract. Retained evidence: art/rejected/idle-sheet-r01/audit/audit.md. These articulated candidates require independent motion review.. Confirm it reads as the intended action.

## Missing clips

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
