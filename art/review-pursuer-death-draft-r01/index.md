# Art review pack

Frames: `/config/codex-workspace/astra-whip/art/review-pursuer-death-draft-r01/frames` · contract 0.2.0 · 2 clips present, 62 missing.

Follow `prompts/ART_REVIEW.md`. Do the steps in this order and do not read `audit.md` or the clip intents until step 3.

1. **Blind description.** For each lineup, then each strip, write what you see in plain words before anything else.
   - `lineup_pursuer.png`
2. **Motion.** Read every `onion_*.png`: does each pair read as one continuous movement of the same body?
3. **Intent and checks.** Now read the contract and `audit.md`, compare, and adjudicate every FLAG.
4. **Attacks.** `composite_*.png`: whip held in the fist (cyan cross), reach covers the yellow hitbox on active frames.

Audit: **0 DEFECT, 2 FLAG** (see `audit.md`).

## Derived clips (ART_CONTRACT §11)

- `pursuer_patrol_walk`: scripted_fallback of `art/review-pursuer-keys-r01/f000.png,tools/prepare-pursuer-gait.mjs,art/production-candidates/pursuer-gait-rig-r02/rig.json` (Rigid painted bone parts rotated about connected joints from an independently approved static key. Four fixed limb identities, continuous stance and lifted forward swing; stance travels10.8source px per frame. No whole-body scaling. Isolated old toe fragments outside limb cutouts are removed from the remaining connected torso layer.); reason: D23 fallback after generated gait failed independent motion review (art/review-pursuer-walk-r01/review_verdict.md). Static key independently accepted in art/review-pursuer-keys-r01/review_verdict.md. Full new motion review required; disclose scripted animation as quality debt.. Confirm it reads as the intended action.
- `pursuer_death`: scripted_fallback of `art/frames/pursuer_lunge_windup/f001.png,art/production-candidates/pursuer-death-f001-key-r01.png,art/production-candidates/pursuer-death-f002-key-r01.png,art/production-candidates/pursuer-death-corpse-clean-r01.png,art/production-candidates/pursuer-death-ash-r01/f004.png,art/production-candidates/pursuer-death-ash-r01/f005.png,tools/prepare-pursuer-ash.mjs,art/review-pursuer-corpse-key-r01/review_verdict.md` (Reuse approved compression for the lethal buckling entry, directly painted intermediate fall poses and independently accepted complete grounded corpse. Final two frames derive soft Ash Grey erosion and descending/settling flecks from that approved corpse; no whole-body scale. Generated body keys get one factor1 baseline registration. Alpha<=4 cleanup only.); reason: Complete the one-HP lethal sequence with supported collapse and D13 ash rather than a tinted held pose. Body identity is preserved through a declared D23 scripted ash derivation from approved paint; retain derived-animation quality debt and require full independent motion review.. Confirm it reads as the intended action.

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
- `pursuer_alert`
- `pursuer_approach_walk`
- `pursuer_lunge_windup`
- `pursuer_lunge`
- `pursuer_recovery`
- `pursuer_hurt`
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

- `lineup_pursuer.png`
- `strip_pursuer_patrol_walk.png`
- `onion_pursuer_patrol_walk.png`
- `strip_pursuer_death.png`
- `onion_pursuer_death.png`
