# Independent partial hero motion review

Scope: all 14 delivered clips in this pack, including the neutral reference. Absent clips are outside this partial review; this is not the full hero release gate. Reviewer did not inspect builder history, other verdicts or rejected candidates. The lineup was inspected first, then every strip. Blind notes were written in tool input before reading intent; two attempts to persist them with unavailable Python executables failed, so they are preserved below. Contract, bible, machine contract, index and audit were then read, and every onion and both permitted style references inspected.

## Blind observations recorded before intent

Lineup: A detailed brown long-coated, dark-haired male adventurer facing right. Neutral and several locomotion/reaction starts share essentially the same upright silhouette; walking start has spread legs and an extended forward arm. Crouch is a deep compact squat with folded knees and hands near them. All three airborne starts show the same bent-leg suspended pose, one knee forward and opposite boot trailing. Grounded feet appear aligned; airborne pose is presented with lowest boot at the line, so lineup alone does not communicate vertical travel. Identity, clothing, scale and rendering remain visually cohesive.

- crouch_enter F0–F3: standing, slight knee bend, deeper bend, full squat. Clear articulated hip/knee change; hands move toward knees. Upper body retains volume and identity. Weight shifts a little forward.
- crouch_exit F0–F3: exact-looking reverse of the above; clear rising from squat to standing. Coherent articulated action.
- crouch_idle F0–F5: virtually fixed deep squat, tiny upper-body/head changes; feet grounded, knees folded. Quiet held squat reads.
- fall F0–F3: same suspended bent-leg pose throughout, with slight arm/coat or body displacement. No visible leg extension or falling-specific posture. Reads as one airborne illustration held.
- hurt_recoil F0–F3: standing neutral throughout with tiny horizontal or torso changes. No visible flinch, guarding, buckling or head snap. Label is not supported by the action.
- idle F0–F7: standing neutral with subtle breathing/head-height variation and fixed boots. Appropriate quiet stance.
- jump_apex F0–F2: held bent-leg airborne drawing with minuscule change. Could serve as a short airborne hold; no distinct cresting action visible.
- jump_rise F0–F3: same bent-leg airborne drawing with slight displacement; no distinct rising extension or coordinated leg change. Looks the same as apex/fall.
- knockback F0–F3: upright neutral figure marginally shifting, no backward bend, arm throw or weight loss. No convincing impact response.
- start_move F0–F2: neutral to lifted forward boot to long stride. Recognizable first step, but rather abrupt pose spacing and little forward lean.
- stop_move F0–F2: long stride to lifted forward boot to neutral. Appears reversed first step, not weight-braced deceleration; foot moves upward before settling.
- turn F0–F2: same right-facing neutral throughout with tiny shift. No head/shoulder/hip reorientation or foot pivot.
- walk F0–F9: paired near-identical frames of five poses. Long stride F0/1, trailing bent boot F2/3, long stride F4/5, raised front boot F6/7, long stride F8/9. Bent trailing boot and raised front boot create some stepping impression, but opposing legs never clearly exchange roles: the same forward-side trouser/boot dominates every extended stride. F2→F4 unfolds back to same-looking contact; F6→F8 lowers front boot into same-looking contact. Arms are almost fixed and coat/knee shapes jump between drawings. Reads as a stitched stepping loop rather than established alternating gait.
- style_hero_neutral F0: single clear upright reference, consistent rendered leather, hair, boots and coiled rope.

All strip tiles show the complete body, including head, torso, arms, and two legs/boots (overlapping in the squat). No visible torso-only crop, canvas-edge truncation, detached debris, or opaque rectangle was observed. Faces, hair, leather costume and coil remain recognizably the same character; the walk has local costume/coat silhouette changes at pose switches rather than a different identity. Labels above are identifiers, not evidence of motion.

## Proportion and continuity

The neutral/standing/stride figures occupy the blue-height neighborhood with complete legs. Crouching reaches the yellow-height neighborhood through hip and knee flexion, retaining a plausibly constant head and torso size. All sources face right. The air pose's lowest boot alignment follows the contract; lack of global upward/downward travel on these sheets is not itself a defect because gameplay supplies translation.

Every onion was opened, with the following pair adjudications:

| Onion | Pairs inspected | Observation |
|---|---|---|
| idle | 0→1, 1→2, 2→3, 3→4, 4→5, 5→6, 6→7, 7→0 | Smooth tiny breathing change; planted feet and clean seam. |
| walk | 0→1, 1→2, 2→3, 3→4, 4→5, 5→6, 6→7, 7→8, 8→9, 9→0 | Within-pose pairs are almost held. At 1→2 and 3→4 the trailing boot bends/unbends without a readable leg exchange; 5→6 and 7→8 jump between contact and a conspicuously lifted front boot, with torso/coat changes. 9→0 is a near hold. The loop does not demonstrate a continuous alternating support/swing cycle. |
| start_move | 0→1, 1→2 | Large but plausible 50 ms first-step spacing. Front foot lifts then reaches contact; trailing foot pushes away. No limb disappearance. |
| stop_move | 0→1, 1→2 | Reverse of that first-step trajectory: front contact is lifted and pulled back while rear foot relocates. Missing a credible planted braking support. |
| turn | 0→1, 1→2 | Smooth slight body shear; no pivot/torso turn or leg weight transfer visible. Gameplay mirroring does not provide the missing anticipation/settle. |
| crouch_enter | 0→1, 1→2, 2→3 | Progressive flexion; substantial head descent but corresponding knee/hip bends. No limb teleport or uniform shrink. |
| crouch_exit | 0→1, 1→2, 2→3 | Same coherent joint sequence rising; reverse reuse reads as standing up. |
| crouch_idle | 0→1, 1→2, 2→3, 3→4, 4→5, 5→0 | Tiny coherent breathing, constant folded legs and clean seam. |
| jump_rise | 0→1, 1→2, 2→3 | Near-perfect overlap; minute cloth changes, no readable progression of articulated tuck. |
| jump_apex | 0→1, 1→2 | Near-perfect overlap. A short suspension hold is plausible, but the claimed release of tuck is not visible and the state has no discernible transition from rise toward fall. |
| fall | 0→1, 1→2, 2→3, 3→0 | Small cloth changes including seam; frozen bent legs, no readable extension or changing airborne balance. |
| hurt_recoil | 0→1, 1→2, 2→3 | Upper-body lateral displacement with boots fixed; no clear articulated flinch. Smoothness alone cannot make this neutral pose read as hurt. |
| knockback | 0→1, 1→2, 2→3 | Similar tiny body displacement; no sustained backward weight loss or defensive limb response. |

## Per-clip verdict

| Clip | Verdict | Failing frames | Defect / result | Smallest correction |
|---|---|---|---|---|
| style_hero_neutral | PASS | — | Complete, coherent neutral identity reference. | None. |
| hero_idle | PASS | — | Subtle breathing is appropriate to a quiet planted stance. | None. |
| hero_walk | FAIL | F2–F7; transitions F1→F2, F3→F4, F5→F6, F7→F8 | Four pose changes do not establish alternating leg identity/support; nearly held frame pairs emphasize jumps in boots/coat. | Preserve usable contact endpoints, redraw opposing contact and passing poses F2–F7 with tracked left/right legs, then make neighboring frames genuine in-betweens; ensure planted support before swing. |
| hero_start_move | PASS | — | Neutral → lifted foot → contact reads as a brief first step despite economical spacing. | None required. |
| hero_stop_move | FAIL | F1 (and F0→F1→F2 trajectory) | Lifted front foot in the middle reads as a reversed start rather than stopping. | Replace F1 with a front-foot-planted braking/weight-settle pose that leads naturally into F2. |
| hero_turn | FAIL | F1–F2 | Tiny neutral deformation supplies no visible turn or convincing weight transfer. | Replace F1 with a readable hip/shoulder twist and pivot-foot load, then F2 with a settling stance; keep source-facing convention. |
| hero_crouch_enter | PASS | — | Actual knee/hip bending, stable identity and readable descent. | None. |
| hero_crouch_idle | PASS | — | Folded squat breathes subtly without shrinking or sliding. | None. |
| hero_crouch_exit | PASS | — | Reversed descent credibly reads as standing up. | None. |
| hero_jump_rise | FAIL | F1–F3 | Essentially a frozen airborne key; declared knee-tuck progression is not readable. | Keep F0; articulate knee/hip tuck and trailing foot/coat response through F1–F3 while retaining limb lengths. |
| hero_jump_apex | FAIL | F1–F2 | Brief hold is plausible in isolation, but delivered derivation does not visibly release the tuck or bridge to descent; same frozen pose as rise/fall. | Keep F0; make F1–F2 a small but visible knee/ankle release and arm/coat settle leading into the falling pose. |
| hero_fall | FAIL | F0–F3 | Bent-leg rise pose repeats; promised leg extension is invisible and fall has no distinct body balance. | Redraw the fall key with downward leg extension/readable descent balance, then use coherent small limb/cloth motion through the four-frame loop. |
| hero_hurt_recoil | FAIL | F1–F2 | Neutral figure shears slightly; no readable pain/impact event. | Keep endpoints; replace middle frames with torso/head flinch, bent knee and arm response, then recover. |
| hero_knockback | FAIL | F1–F3 | Upright neutral body lacks sustained backward recoil even allowing engine displacement. | Keep initial contact; create backward torso/head lean and reactive arms/legs across F1–F3, preserving anatomy. |

## All six audit flags

These flags are accepted as isolated measurement exceptions; accepting them does not approve unrelated motion defects.

| Flag | Decision | Visual reason |
|---|---|---|
| A-08 hero_walk F9, head 1.051× | Accept | Tiny threshold excess; face/cranium does not visibly inflate versus F8 or seam F0. Hair-outline difference is credible. Walk fails separately for gait. |
| A-08 hero_crouch_enter F2, head 1.077× | Accept | Inclined head/hair silhouette broadens, but facial/head scale remains plausible against neighboring bends; not a growing head. |
| A-11 hero_crouch_enter F1→F2, size 8.8%, height 17.9% | Accept | Visible hip/knee articulation and overlapping limbs/coat explain projected area loss; descent is continuous, not uniform scaling. |
| A-08 hero_crouch_exit F1, head 1.077× | Accept | Same inclined head as enter F2; same accepted silhouette explanation. |
| A-11 hero_crouch_exit F1→F2, size 9.6%, height 21.8% | Accept | Unfolding reveals body/cloth area while knees and hips extend; no abrupt identity or limb-length change. |
| A-11 hero_crouch_exit F2→F3, size 6.3%, height 17.9% | Accept | Final straightening and coat separation credibly increase area; complete figure remains constant anatomical scale. |

## Derivations and limits

All 12 listed derivations were adjudicated: idle and crouch_idle scripted breathing PASS; reversed crouch_exit PASS; reused start_move PASS. Scripted walk, turn, rise, apex, fall, hurt_recoil and knockback FAIL for the action-read reasons above; reused stop_move FAIL because reversal does not supply deceleration. A permitted derivation is not an exemption from visible action.

There are no delivered attack/whip composites or effects in this partial pack, so their grip, reach and effect progression are outside this verdict. No engine phone-size captures were provided here; no engine playback or full coverage approval is implied. The supplied 0-DEFECT audit establishes numeric compliance only and cannot override these visual failures.

REVIEW: FAIL (8 clips)
