# Independent ground attack review r01

Scope: `style_hero_neutral`, `hero_attack_ground`, `whip_attack_ground` only. I did not generate or process these assets. I opened all lineup and strip images first and saved `blind_observations.md` before reading the contract, index, audit or metadata. No builder notes or prior verdicts were inspected. All 17 native snapshot frames, both onions, the composite, the registered style reference images, both audits, scoped derivations, and all 32 engine/phone capture images were opened. Both capture.json files were read. No scoped image is missing. The index's other absent clips and unrelated derivations are outside this acceptance scope.

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| style_hero_neutral | PASS | — | Full head-to-boots right-facing hunter; coherent two arms and two legs, recognizable face/hair/mantle/coat/linen/bracers/boots, grounded and correct standing height. | None. |
| hero_attack_ground | PASS | — | Recognizable hunter throughout; an articulated raised-arm wind-up, same-arm extension, follow-through and alternating-foot gathering recovery. No missing limbs, clipping, hard alpha edge or visible debris. | None. |
| whip_attack_ground | FAIL | 4–7, particularly 6→7 | Recovery reads as the lash shortening into the handle, then being replaced by a closed coil. F4–F6 contain successively shorter single open curves without accumulating returning length; F6's rightward open tip disappears and F7 supplies an unrelated hanging loop. The body and wrist stay nearly still across 6→7, so there is no gathering action to account for the abrupt shape change. | Redraw the recovery lash in F4–F6 so slack folds/loops accumulate continuously near the fist and F6 already approaches F7's hanging coil. Retain the approved grip sockets, active frames and final compact coil. |

## Identity, anatomy and size

The lineup shows the same full-body hunter in neutral and attack start. Both meet the blue standing line with feet at the red line. Every source faces right. All eight attack frames have continuous shoulders/elbows/wrists, a waist, two articulated legs and complete boots. Costume remains the same layered brown leather and cream linen; changes in skirt overlap follow the change in stance. Head and body do not visibly grow or shrink. No crouch is in scope. Style neutral is a static reference, so its single frame is appropriate.

## Every adjacent motion pair

| Pair | Body assessment | Weapon assessment |
|---|---|---|
| 0→1 | Large but readable anticipation: stance opens, knees load and striking elbow rises. Same figure, without a scale pop. | Coil releases into a backswing behind the raised grip; direction agrees with the hand. Acceptable fast wind-up. |
| 1→2 | Rapid elbow extension and shoulder turn into the strike. A large deliberate attack move over 75 ms, not a limb changing identity. Feet maintain the wide support stance. | Backswing advances into the forward lash at active start. Acceptable whip snap. |
| 2→3 | Small forward/down follow-through with consistent supporting legs and clothing. Distinct poses rather than an exact hold. | Forward wave travels slightly down/right; reach maintained. Accept. |
| 3→4 | Hand drops and folds toward waist; trunk and knees remain coherent. Accept. | Large downward return is plausible, but the curve loses considerable length without visible slack. Recovery continuity defect begins here. |
| 4→5 | Front boot lifts inward while rear boot supports; striking hand lowers. Readable gathering step. | Single shallow returning curve becomes shorter/deeper with no gathering fold. Defect. |
| 5→6 | Front boot lands while rear heel/boot lifts inward; torso rises. Alternating support is visible, rather than both boots skating together. Accept. | Open curve shortens again. Defect. |
| 6→7 | Rear foot settles, chest and hand settle into neutral. Small coherent finish. Accept. | Open rightward lash switches to a hanging coil without a preceding turn/fold. Defect. |

The final body pose returns close to the neutral reference without a size change. These are nonlooping clips; no loop seam is claimed.

## Grip, occlusion, reach and taper

All eight composite sockets sit in the striking fist; the wood grip emerges from the appropriate side. The glove occlusion prevents an overlaid grip being painted across the entire fist. Native weapon images contain continuous narrow leather curves, with fine tapering tips, no blank frame and no rectangular border. F0/F7 coils are compact. In the composites those coils lie largely against/behind the brown coat, so they are subdued; the active lash is visible in both facings at engine and phone size. F2/F3 cross the yellow hitbox and reach beyond its far edge. The lash does not detach on mirroring. Neither numerical attachment nor monotonic tip distance proves a believable recovery shape: the visual defect above remains despite those passing measurements.

## Audit adjudication

Both the main audit and supplemental stricter whip audit report 0 DEFECT and the same single FLAG. A-11 `hero_attack_ground` F001, size +6.2% from F000, height change 3.1%: **accepted**. The wider open stance, separated forearm and opened coat expose additional ink; head, torso and boots remain at the same apparent scale. The onion shows articulated anticipation, not a uniformly enlarged figure. No other FLAG appears in either audit.

## Derivation and timing

The scoped body derivation uses painted action keys and in-betweens. It reads as an intentional attack with anticipation, execution and recovery rather than a translated neutral cutout. The scoped weapon is a declared scripted fallback; sampled colors and numeric geometry preserve material and registration but do not resolve its recovery motion defect.

Both captured timelines show all eight ordered frames in both facings, total attack 0.5 s, with F2 at 0.15 s and F3 at about 0.2083 s active; F4 at about 0.2583 s is inactive. The small offsets from exact frame boundaries are consistent with discrete capture sampling. Source durations are 75/75/50/50/62.5/62.5/62.5/62.5 ms, matching the contract. Engine/phone captures confirm the body and weapon remain synchronized and feet grounded. Phone-size silhouettes distinguish neutral, wind-up, extension and return. The open lash is thin but visible; the final coil change is compressed into the last recovery sample rather than physically explained. Still capture sequences establish these sampled poses/times; they are not a continuous video.

REVIEW: FAIL (1 clips)
