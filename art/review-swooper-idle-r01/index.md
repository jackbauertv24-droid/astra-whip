# Art review pack

Frames: `/config/codex-workspace/astra-whip/art/review-swooper-idle-r01/frames` · contract 0.2.0 · 2 clips present, 62 missing.

Follow `prompts/ART_REVIEW.md`. Do the steps in this order and do not read `audit.md` or the clip intents until step 3.

1. **Blind description.** For each lineup, then each strip, write what you see in plain words before anything else.
   - `lineup_swooper.png`
2. **Motion.** Read every `onion_*.png`: does each pair read as one continuous movement of the same body?
3. **Intent and checks.** Now read the contract and `audit.md`, compare, and adjudicate every FLAG.
4. **Attacks.** `composite_*.png`: whip held in the fist (cyan cross), reach covers the yellow hitbox on active frames.

Audit: **0 DEFECT, 0 FLAG** (see `audit.md`).

## Derived clips (ART_CONTRACT §11)

- `swooper_perch_idle`: reused of `swooper_cruise` (Exact approved frame reuse in order [0,1,2,3,6,7], each150ms: slower900ms hovering beat, omitting the deepest cruise downstroke; root stationary through idle and source frame1 approaches frame0 at cruise handoff.); reason: ART_CONTRACT §11 permits reused frames. Idle still requires its own independent acting/timing/handoff review.. Confirm it reads as the intended action.
- `swooper_cruise`: scripted_fallback of `art/production-candidates/swooper-identity-r02/key.png` (Separate articulated wing meshes with fixed shoulder roots, elbow flexion and phase-lagged membrane camber; unchanged torso, no global scaling. See tools/prepare-swooper-cruise.mjs and rig.json.); reason: Painted opposite-pose generation moved and changed the central hood/body instead of preserving the flight pivot (art/production-candidates/swooper-downstroke-r01). Static source key independently accepted; derived animation requires separate review.. Confirm it reads as the intended action.

## Missing clips

- `style_hero_neutral`
- `hero_idle`
- `hero_walk`
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

- `lineup_swooper.png`
- `strip_swooper_perch_idle.png`
- `onion_swooper_perch_idle.png`
- `strip_swooper_cruise.png`
- `onion_swooper_cruise.png`
