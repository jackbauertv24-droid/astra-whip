# Independent pursuer idle review r01

Scope: `pursuer_idle` only. `pursuer_patrol_walk` was inspected as unchanged identity, scale and transition calibration; it is not being accepted again here. Other missing inventory clips are outside this scoped review.

Blind observations were saved and their successful write verified before reading intent, audit, index or scoped metadata. Reviewed prompts/ART_REVIEW.md, ART_CONTRACT, ART_BIBLE, ANIMATION_SPEC, machine contract, all five registered style-lock images, lineup, both strips, both complete onion sheets, all six native idle PNGs, scoped clips/derivation metadata and audit. No earlier review verdict or builder notes were opened.

Both capture logs ended PASS before capture inspection. Inspected both capture.json records and all 14 images from each capture set through unchanged-scale crops, alongside full native and phone scene views. Crop sheets are `captures-engine-native-crops.png` and `captures-phone-native-crops.png`; each contains right F0–F5 and patrol F0, then left F0–F5 and patrol F0. They preserve capture pixels, without enlargement or rescaling.

| Clip | Verdict | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| pursuer_idle | FAIL | F0→F1; F5→F0; actual F5→patrol F0 | The reused neutral F0 has a visibly different body/cloth drawing from the following painted poses. The lower chest and hanging inner forelimb thicken into rounder masses at F1, while shoulder/back folds and drapery redraw. At F5→F0 the upper silhouette contracts and the broader, softer neutral drawing returns in a single exposure. This is a repeated drawing/volume pop rather than a clean breath return; the same discontinuity reaches the natural patrol handoff. | Keep the calibrated patrol/F0 key fixed. Repaint the F1 entry and F5 return to match its chest, forelimb thickness and cloth construction much more closely, with small connected breathing displacement. Preserve grounded paws. Adjust neighboring poses only if needed to retain continuity after those endpoint corrections, then obtain a fresh review. |

## Anatomy, identity and size

Every idle frame contains the complete head, back, hindquarters and four identifiable limbs, including the farther tucked hind limb and the two elongated forelimbs. No torso-only substitution, clipped extremity, detached limb, hard rectangle or loose debris was found. It faces right in source and mirrors plausibly. The gaunt body, long forelimbs, drooping pointed head shroud, ragged decay-colored back and pallid limbs match the style-lock creature. There is no animal/pet read or explicit gore.

The overall physical scale and ground alignment match patrol. No whole-body shrink animation is apparent through F1–F5, but F0 changes the perceived volume and drawing construction enough to interrupt that consistency. This distinction matters: acceptable bounding height does not make the endpoint change visually seamless.

## Motion and all adjacent pairs

- F0→F1: defective. Most obvious is the changing chest/inner hanging forelimb mass and cloth/shoulder rendering. The body seems to change drawing in place instead of proceeding through the first small inhalation.
- F1→F2: acceptable short breathing displacement, with connected limbs and steady contacts.
- F2→F3: acceptable small chest/head-drape settling; the outline remains one body.
- F3→F4: acceptable subtle back/neck motion, without a limb jump.
- F4→F5: acceptable small settling motion, with consistent scale and anatomy.
- F5→F0: defective loop return. The upper outline and back/shoulder volume step back to the different neutral drawing. At 150 ms per exposure this return arrives as an abrupt reset after the small F1–F5 movements.

The sequence contains living movement rather than a frozen or translated picture: small chest/back expansion and drapery changes are visible. The grounded rear paw and low forward claw contact remain registered; the changes in toes are small painted contour variation, not a walking step or root translation. The failure is continuity at the endpoints, not absent animation or skating.

## Engine, handoff and phone view

The records show six idle samples at 150 ms spacing, stationary root x=1050 in both directions, and the actual AI transition to patrol F0 after 900 ms. Both directions display the complete creature on the floor, and the feet do not translate during idle. Native capture confirms the F0/F1 change and the return to the neutral drawing at handoff. Patrol F0 matches idle F0, so matching only these two neutral images does not solve the actual F5→patrol F0 transition.

At phone size the low ragged quadruped remains visible against the stone, with its head direction and long front limbs readable. Very small breathing details are subdued at that scale, which is appropriate. The phone captures do not excuse the clear native endpoint discontinuity. No additional facing, anchoring, clipping or phone readability failure was found.

## Every audit FLAG adjudicated

1. **A-11 FLAG, pursuer_idle F1, size +7.0%, height +1.8% from F0: DEFECT.** The onion overlay and original images show the changed chest/inner forelimb thickness and cloth drawing rather than merely a soft expansion within stable anatomy. It crosses the measured tripwire and has a visible corresponding pop.
2. **A-13 FLAG, pursuer_idle F0, size change 8.0%, height change 3.4% from F5: DEFECT.** The final-to-first overlay has a wider discrepancy around the back, shoulder, head and forelimbs than neighboring breathing pairs. The upper outline resets and the neutral rendering returns abruptly. This also affects the actual transition from idle F5 to the identical patrol F0.

Accepted FLAGs: none.

The derivation is disclosed and the result reads as stationary breathing, but reuse does not waive seamless-loop and handoff requirements. No attack, whip, effect or reversed action applies to this scope. Production files were not edited.

REVIEW: FAIL (1 clips)
