# Independent scoped gait review r11

Scope: `hero_walk` and `style_hero_neutral` only. Blind observations were saved in `blind_motion_observations.md` before consulting instructions, intent, metadata or audit. No prior verdict was consulted and no art was modified.

Inspected the lineup, both strips, all eleven individual native PNGs, all ten onion pairs including F9→F0, and all ten desktop plus all ten phone Godot captures. Read the review protocol, art contract, art bible, animation specification, style lock, scoped audit, contract timings and scoped derivation metadata.

| Clip | Verdict | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| style_hero_neutral | PASS | — | Complete coherent standing human; head, torso, two legs and boots are present, identity and size match the lock, right facing, grounded feet and small held coil. | None. |
| hero_walk | FAIL | F3–F6; transitions F2→F3 and F6→F7 | Alternating leg identity/support is not convincingly established. The brown foreground boot remains the forward boot through the first contact, passing and next forward swing; the darker rear leg remains behind rather than visibly becoming the forward swing leg. F2→F3 changes from rear-foot recovery/front-foot support directly to rear support/front forward lift, without a readable crossing and opposite-leg advance. F6→F7 repeats the same rear-lift/front-lift reset. This reads as repeated steps with the same leg and a rear-foot shuffle. | Repaint the second half-step F3–F6 with explicit opposite-leg advance: retain the near leg continuously as it moves rearward in support, bring the far leg through overlap to forward swing/contact, then release the near leg into recovery toward F7. Preserve the approved head, torso scale and canvas. Maintain boot cuffs/material and occlusion order so each leg can be followed across F2→F3 and F6→F7. |

Full anatomy and identity: all eleven native images contain complete bodies, both feet, coherent arms and the same face/hair/coat/hip coil. No torso substitution, clipping, debris, obvious portrait-size jump or overall scale jump was seen. Torso/cloth/arm variation is visible and appropriate secondary motion. The darker grey rear boot in F3–F5 also makes leg tracking less reliable; preserve the brown leather identity while using consistent shading for depth.

Uniqueness: F0/F1 initially looked almost held in the blind strip, but native inspection shows a real change in the boot separation and lower-body position. F4/F5 also differ in forward boot placement and arm position. F9 is a distinct late pose, not an exact F0 duplicate. The unique-pose requirement does not independently fail here; it does not resolve the alternating-leg problem.

Pair assessment: F0→F1 is small but real; F1→F2 draws the legs inward with rear recovery; F2→F3 fails leg-role continuity as above; F3→F4 lowers the forward boot toward contact; F4→F5 is a modest contact progression; F5→F6 lifts the rear boot; F6→F7 fails role continuity as above; F7→F8 lowers the forward boot and draws the rear boot back; F8→F9 extends into contact; F9→F0 is a small, believable final contact adjustment. There is no separate scale/costume pop at the loop seam. The seam itself passes.

Engine evidence: the complete hunter remains visible and separates from the background in every desktop and phone capture. The lifts/contact silhouettes survive phone reduction, but the same front/back shuffle remains; display scale does not establish an opposite-leg stride. These are frame captures, so they substantiate rendered poses and display readability rather than independently prove travel-speed foot planting.

FLAG adjudication: scoped audit reports 0 DEFECT and 0 FLAG. No flags to accept or reject. The visual motion defect is outside those numerical checks. Missing unrelated clips listed in the index are outside this review scope.

REVIEW: FAIL (1 clips)
