# Independent gait review r04

## Blind inspection, recorded before reading contract or pack metadata

Lineup: two right-facing brown-haired human adventurers in textured brown long coats, pale undersleeves, brown gloves, dark trousers and tall boots. Neutral stands with feet apart; walk starts in a long stride, left-screen boot behind and right-screen boot ahead. Both read as the same identity and approximately the same physical height, with walk slightly lower. Neck and head appear connected; no obvious loose external debris.

Walk strip: ten frames show strides and lifted boots. F0 and F1 are nearly identical long-stride poses. F2 draws the rear boot toward the planted forward boot. F3 lifts the right-screen boot with a bent knee while left-screen boot is planted. F4 extends that same right-screen boot; F5 spreads both boots on the floor; F6 lifts the right-screen boot again; F7 still lifts it; F8 lowers it; F9 returns to a long stride. Across these poses the left-screen boot usually occupies the support position while the right-screen leg repeats swing, so reciprocal left/right stepping is not clearly communicated. F2 and F6 shift the rope/hand relationship. Coat remains recognizably the same garment, but tails switch shape and length abruptly in middle poses. Head dips through F3-F4 and F6, then rises noticeably in F7. No plainly visible detached debris or head/neck split. Loop endpoints seem close but not identical: F9 has a more open/lower coat and differing forward boot than F0.

Neutral strip: single relaxed standing adventurer matching the lineup; long brown coat, rope at left-screen hip, boots on floor, slight rightward head turn. Clear connected neck, coherent body silhouette and no visible loose pixels at this scale.

## Per-tile observations from the blind strip inspection

These expand the visual observations above, using frame labels only as coordinates. Each figure is present from head to both boots, faces right, and has no canvas clipping or visible detached debris.

- Lineup neutral: a brown-haired man at rest, rope beside the left-screen glove, boots separated on the ground. The coat divides around visible trouser legs.
- Lineup walking figure: the same man extends one boot ahead and one behind, with the forward arm away from the torso. Full anatomy is visible and the head sits slightly below the other tile.
- Neutral F0: relaxed standing man with connected head, linen sleeves, long coat and two tall boots. No missing limb, hard rectangle or isolated speck is visible.
- Walk F0: broad stride with left-screen boot behind and right-screen boot forward. Rope hangs at the nearer hand and the tails separate over the legs.
- Walk F1: almost the same broad stride, slightly narrower. Both boots remain close to the floor.
- Walk F2: left-screen boot bends upward behind the body while right-screen boot stays on the ground. The nearer glove hangs independently beside a rope higher on the hip.
- Walk F3: left-screen boot is flat on the floor and right-screen knee and boot are lifted forward. Head and shoulders sit lower, and the coat forms a short triangular front flap.
- Walk F4: left-screen boot remains flat while right-screen boot extends forward nearer the ground. The coat spreads into differently shaped front and back panels.
- Walk F5: boots spread apart on the floor. Head is higher than the preceding tile and the front coat panel hangs farther forward.
- Walk F6: left-screen boot is under the body on the floor while right-screen boot is lifted ahead. The head dips, the glove/rope relationship differs, and both coat panels flare to the right.
- Walk F7: left-screen boot remains on the floor and right-screen boot remains lifted forward. Head is higher and the long rear coat tail sweeps left instead of right.
- Walk F8: lifted right-screen boot lowers slightly as the stance opens. Costume and head resemble the previous tile.
- Walk F9: wide stride returns, with left-screen boot behind and right-screen boot ahead. It closely resembles the starting tile.

## Scope and evidence

Reviewed only `style_hero_neutral` and `hero_walk`. Read the supplied review prompt, ART_CONTRACT, ART_BIBLE, machine contract, pack index and audit; inspected the complete walk onion sheet, all ten native walk frames and the allowed neutral style reference. Other clips listed missing in the index are outside this explicitly limited review. No earlier review, history, or builder files were consulted. The pack's derivation listing is treated as disclosure, not evidence of acceptance.

Identity and physical size: full anatomy, right facing, recognizable hair/costume and approximately reference-scale limbs are present throughout. The walking figure does not read as a resized torso. Frame height changes are principally pose changes; the defects below concern continuity. Every native frame has a visibly connected neck; no detached head, obvious pasted horizontal neck cut, canvas-edge cut or external debris was found. Coat material remains consistent, but panel silhouettes and the rope placement change abruptly around replacement poses.

## Adjacent motion and seam

| Pair | Observation |
|---|---|
| F0→F1 | Small believable closure of the stride; very little torso motion. |
| F1→F2 | Rear foot lifts and draws inward toward passing; believable. |
| F2→F3 | Defect: rear boot changes from tucked back/up to flat support while the formerly grounded front boot jumps up into a bent forward knee. This skips the readable passing/contact transfer. Shoulder/head dip and the coat front simultaneously change. |
| F3→F4 | The forward boot extends plausibly in isolation, but it is the same forward swing instead of a continuation of the rear-foot passing seen in F2. Coat panel silhouettes also widen/change. |
| F4→F5 | Defect attributable to F4: extension lands, but the torso/head rises and the front skirt shape changes abruptly at the boundary to the retained contact pose. |
| F5→F6 | Defect: the forward boot lifts again immediately after contact instead of continuing backward through support while the other foot swings. Head dips and the nearer hand/rope and coat panels change together. |
| F6→F7 | Defect attributable to F6: head and shoulder jump back up, hand/rope restore another layout, and rear coat tail jumps from the rightward flare to a leftward sweep. The two lifted forward boots have different shapes/angles rather than a clean short continuation. |
| F7→F8 | Short believable continuation toward contact; stable torso identity. |
| F8→F9 | Feet spread into the contact pose; readable. |
| F9→F0 | Acceptable seam. Native endpoints closely match, with no visible size or limb teleport. The initial strip-scale impression of endpoint differences is not sustained by the native inspection. |

The cycle contains recognizable walking poses, but it does not convincingly show two uninterrupted alternating steps. The F2→F3 transfer and F5→F6 renewed forward lift interrupt that read. A walk cannot pass §9/§11 merely because the foot line, height and area stay inside their numeric bands.

## Clip verdicts and smallest corrections

| Clip | Verdict | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| `style_hero_neutral` | PASS | — | Full connected standing figure, consistent identity/reference proportions, right facing, no visible debris or clipping. | None. |
| `hero_walk` | FAIL | F3, F4, F6 | F3/F4 interrupt the rear-foot passing phase; F6 repeats the forward-foot lift after contact and changes coat/head/rope motion abruptly. | Replace only `f003.png`, `f004.png`, `f006.png`: derive F3/F4 anatomically from F2 and F5, preserving the planted supporting leg through transfer and moving the opposite swing leg continuously into the second contact; derive F6 from F5 and F7 with the support foot progressing backward and the opposite leg entering passing. Keep each replacement's head/shoulder position, neck join, rope/hand location and coat panels on short paths between those neighbours. Do not alter F0/F1/F2/F5/F7/F8/F9 or rescale the whole clip. |

## FLAG adjudication

- **A-08 `hero_walk` F6, head width 1.077 × reference: accepted as an isolated silhouette flag.** Native inspection shows a somewhat fuller rear hair outline with the head angled down/right; the face and cranial proportions still read as the same adult and do not show a miniature or enlarged head. This is not sufficient by itself to reject physical scale. F6 nevertheless fails for the independently visible gait and coat/torso continuity defects above. Its replacement should retain the reference face/head proportions and remove the abrupt neighbouring pose change.

No other FLAG is listed in `audit.md`. Attacks, effect composites, crouches and other derived clips are outside the supplied neutral/walk scope. The disclosed `hero_walk` scripted fallback fails the intended-action acceptance for the reasons above.

REVIEW: FAIL (1 clips)
