# Independent ART_CONTRACT §9 review — secondary motion r06

Scope: the 18 present clips only. No art changes. I inspected lineup_hero.png and all 18 strip images before reading the supplied text. The blind description below was composed at that point; the initial attempt to save it failed because `python` is unavailable, so it is recorded here with the completed review. I subsequently inspected every onion image, including all four loop seams, and native frames for turn, stop, rise, fall, knockdown, get-up and death. Earlier reviews and source/build files were not opened.

## Blind image description

Lineup: a brown-haired, pale-skinned male adventurer wears a brown leather coat and shoulder mantle, cream sleeves, dark trousers and boots, with a waist coil. Each tile contains a full body; crouched and airborne tiles rearrange limbs rather than simply shrinking the standing silhouette. The coat, hair and general face remain recognisable.

- **style_hero_neutral F0:** Full upright body facing right, both boots planted, arms lowered. The face and neck sit above a layered collar; no detached pieces or clipping are apparent.
- **hero_idle F0–F7:** Full upright body in every tile. F0, F1, F2, F3, F4, F5, F6 and F7 keep the same feet and costume, with minute upper-body movement and no obvious stray marks.
- **hero_start_move:** F0 stands; F1 raises the forward boot and opens the forward arm; F2 extends into a stride. All three retain the full head, torso and two legs.
- **hero_stop_move:** F0 and F1 show almost the same extended stride; F2 abruptly shows the closer standing feet. Each tile contains a complete body and the same costume.
- **hero_turn:** F0 stands facing right; F1 opens the chest toward the viewer with wider legs and separated arms; F2 returns to the original right-facing stance. The middle head remains in profile and appears unusually square at the shoulder join.
- **hero_crouch_enter:** F0 stands; F1 bends the knees; F2 folds deeper at hips/knees; F3 becomes a compact crouch with hands near the knees. The boots remain on the same baseline and the head does not visibly shrink.
- **hero_crouch_idle F0–F5:** Each tile has a complete low crouched body, overlapping folded legs and forearms near knees. F0 through F5 show tiny upper-body shifts while the boots remain fixed.
- **hero_crouch_exit:** F0 is the low crouch; F1 a deeper squat; F2 a shallow knee bend; F3 upright. All limbs are present throughout.
- **hero_jump_takeoff:** F0 stands; F1 lowers the body on bent knees; F2 has a raised knee, folded trailing leg and opened forward arm. The airborne pose remains complete.
- **hero_jump_rise:** F0 raises one knee; F1 rearranges the bent trailing leg; F2 folds into a tighter tuck and extends the forward palm; F3 holds that tuck with a small change. No body edge is cropped.
- **hero_jump_apex:** F0 has the tight tuck; F1 opens into a one-knee pose; F2 extends the legs downward and spreads the arms. These are three different complete airborne postures.
- **hero_fall F0–F3:** Full body with arms outward, split legs and one low boot. F0 through F3 keep that posture with very small changes at the boot/cloth edges.
- **hero_land:** F0 is the knee-raised airborne posture; F1 plants both feet in a shallow squat; F2 begins rising from that squat; F3 stands. The full body remains visible in all four tiles.
- **hero_hurt_recoil:** F0 stands; F1 leans backward with a raised open palm and bent knees; F2 holds the lean; F3 stands again. All limbs remain present.
- **hero_knockback:** F0 stands; F1, F2 and F3 lean backward with the palm raised, knee bend and small placement changes. No missing limb or isolated speck is obvious.
- **hero_knockdown:** F0 is a backward standing lean; F1 and F2 show a seated-looking airborne fall with reaching rear hand and extended legs; F3, F4 and F5 recline on the floor supported near the elbow/hip with one knee bent. The body remains complete.
- **hero_get_up:** F0, F1 and F2 recline on the floor; F3 and F4 lift into the same seated-looking airborne posture with extended feet and a reaching hand; F5 becomes a standing backward lean. There is no visible kneel, feet-under-hips posture or upright recovery.
- **hero_death:** F0 leans backward; F1 and F2 fall in a seated airborne posture; F3 and F4 recline supported near the elbow; F5, F6, F7, F8 and F9 lie supine with a bent knee. The final two tiles retain the complete corpse rather than showing a fade.

## Identity, anatomy and motion findings

Standing bodies reach the design guide with a complete head-to-boots silhouette. Crouching reaches the lower guide by knee/hip folding, preserving recognisable head size. All source poses face right; the turn's central chest opening is legitimate rotational articulation. No canvas clipping, floor rectangle, debris, detached hand or missing limb is visible. The waist coil remains attached to the costume.

Idle and crouch-idle retain planted feet with small chest/head breathing changes. Their seams and the fall seam overlap closely without a pose jump. Fall has small rear-calf and cloth motion around an intentionally held descent posture; it is a short living loop rather than whole-body translation. Start, crouch transitions, takeoff, rise, apex and landing contain visibly distinct limb/hip postures. The short impact clips contain a torso/arm/knee reaction rather than merely sliding neutral artwork.

The stop clip lacks a convincing middle weight transfer: its rear boot remains behind the pelvis in F1 and then appears directly below the hip in F2. The turn's native F1 has a straight horizontal shoulder/head-patch ledge and vertical cut at the back-neck/upper mantle boundary; the painted neck silhouette is interrupted by the square assembly edge. Get-up visibly reverses airborne collapse rather than lifting a supported body onto its feet.

## Per-clip verdict

| Clip | Verdict | Failing frames | Finding and smallest correction |
|---|---|---|---|
| style_hero_neutral | PASS | — | Complete, consistent standing identity and grounded boots. |
| hero_idle | PASS | — | Small breathing cycle with planted feet and continuous seam. |
| hero_start_move | PASS | — | Neutral → lifted boot → stride reads as a short movement start. |
| hero_stop_move | FAIL | F1→F2; replace F1 | Middle pose repeats the extended contact; the rear boot snaps inward to neutral without visible support transfer. Replace F1 with a narrower braking/weight-transfer pose that moves the rear boot partway under the hip, bends the loaded knee and settles the torso. |
| hero_turn | FAIL | F1 | Native frame has a square, straight-edged head/neck-to-mantle assembly boundary. Repaint only the back-neck/collar/upper shoulder join, preserving the head identity and articulated body pose. |
| hero_crouch_enter | PASS | — | Real hip/knee folding, consistent anatomy and grounded boots. |
| hero_crouch_idle | PASS | — | Complete low stance with subtle supported breathing and clean seam. |
| hero_crouch_exit | PASS | — | Reverse bend reads as standing through the legs, not growing. |
| hero_jump_takeoff | PASS | — | Compression followed by distinct knee/arm airborne articulation. |
| hero_jump_rise | PASS | — | Trailing-leg fold progresses into tucked suspension; coherent body. |
| hero_jump_apex | PASS | — | Tuck releases through one-knee balance into extended descent. |
| hero_fall | PASS | — | Held descent silhouette has small calf/cloth changes and continuous loop. |
| hero_land | PASS | — | Feet plant, knees/hips compress and body rises to neutral. |
| hero_hurt_recoil | PASS | — | Brief backward torso/arm/knee flinch returns to standing. |
| hero_knockback | PASS | — | Distinct defensive lean with small ongoing limb/cloth response. |
| hero_knockdown | PASS | — | Fast backward fall proceeds through bracing hand to hip/elbow ground contact and settle. |
| hero_get_up | FAIL | F3–F5 | F3/F4 lift the seated body with neither palm nor feet carrying its weight; F5 snaps to backward recoil rather than recovered stance. Replace F3 with planted-hand/foot tuck, F4 with supported half-kneel/squat and F5 with a stable standing recovery. Keep F0–F2. |
| hero_death | PASS | — | Full backward collapse, hip/elbow contact, supine settle and final hold. A held corpse is permitted by ANIMATION_SPEC; no fade is required. |

## Adjudication of all 9 audit FLAGs

| FLAG | Decision | Visual basis |
|---|---|---|
| A-08 hero_crouch_enter F2, head 1.077× | ACCEPT | Head/hair silhouette varies slightly with angle; the actual face remains consistent and has not enlarged as a separate swollen head. |
| A-11 hero_crouch_enter F1→F2, S 8.8%, H 17.9% | ACCEPT | Folded hips/knees and overlapping coat reveal less area; feet remain supported. The silhouette changes through articulated bending rather than scale. |
| A-08 hero_crouch_exit F1, head 1.077× | ACCEPT | Same visually consistent intermediate head as entry F2; no apparent head-size pop. |
| A-11 hero_crouch_exit F1→F2, S 9.6%, H 21.8% | ACCEPT | Unfolding hips/knees exposes the torso/coat and raises the body with both boots planted. |
| A-11 hero_crouch_exit F2→F3, S 6.3%, H 17.9% | ACCEPT | Final knee/hip extension restores upright silhouette without stretching body parts. |
| A-08 hero_land F0, head 1.103× | ACCEPT | Hair/angled collar contribute to the top-band measurement; head is recognisably proportionate to the same airborne body. |
| A-11 hero_knockdown F0→F1, S 6.3%, H 25.9% | ACCEPT | Fast heavy-impact transition folds the hips and throws the legs forward while the torso tips back. The reaching hand and subsequent ground contact explain the fall; no uniform scale change. |
| A-11 hero_death F0→F1, S 6.3%, H 25.9% | ACCEPT | Same articulated backward collapse, appropriate to the lethal impact. |
| A-11 hero_death F4→F5, S 6.6%, H 32.4% | ACCEPT | Supporting elbow releases and the upper body/head settle onto the floor; the extended corpse silhouette preserves body-part proportions. |

Every present derived clip was assessed on the delivered images; derivation labels confer no approval. The unrelated missing inventory, attacks, effects, engine reachability, playback reel and phone-size engine recording are outside this pack's supplied scope and remain NOT-TESTED. This is a visual frame/continuity verdict, not engine approval.

REVIEW: FAIL (3 clips)
