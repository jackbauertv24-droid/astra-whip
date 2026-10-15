# Independent pursuer walk acceptance review

Scope: `pursuer_patrol_walk` and `pursuer_approach_walk` only. Other pursuer actions and missing unrelated clips are outside this verdict. I did not generate, process or audit these assets. `blind_observations.md` was saved after opening every lineup and strip, before reading contract/index/audit/metadata. No builder notes or previous verdicts were consulted.

| Clip | Result | Failing frames / transitions | Defect | Smallest correction |
|---|---|---|---|---|
| pursuer_patrol_walk | FAIL | F4–F7, F0 at seam; especially F4→F5→F6→F7→F0 and F6→F7 | Near hind paw alternates tucked/extended/tucked/extended instead of completing a single forward swing into stance. Forepaw ground contacts also jump rather than staying fixed against actual travel; late-loop support visibly stutters. | Repaint the named late-half limb poses and seam endpoint as needed, retaining the successful torso/identity: assign four stable limb identities, give each one continuous stance then lifted forward swing, and register each planted paw against the recorded per-frame world advance. Review the shared correction at both cadences. |
| pursuer_approach_walk | FAIL | F4–F7, F0 at seam; same shared frames and transitions | Identical gait defects repeat faster. Reusing the patrol art and correcting cycle travel does not correct individual support-foot sliding or repeated backward hind-paw resets. | Reuse the corrected patrol poses; retain canonical70ms source timings and validate at actual35/27 playback and100u/s travel. |

## Evidence inspected

Opened all16 native snapshot frames individually, both strips, both full onion sheets including all eight adjacent pairs and F7→F0 seams, audit.md/json, index and the two scoped derivation records. Read the review protocol, ART_CONTRACT, ART_BIBLE, ANIMATION_SPEC, style-lock manifest and machine contract. Opened all five registered style reference images and `approved-rear-up-reference.png`; the latter was used only for identity.

Both `evidence/pursuer-walk-capture-r01.log` and `evidence/pursuer-walk-phone-r01.log` end PASS. Each capture directory contains32 PNGs and capture.json. All64 source captures were decoded and their creature/ground regions inspected at unchanged pixel scale in the four `capture-inspection-*.png` reviewer sheets. Original full scene engine and phone captures were also opened for context, both facings and states. These are real AI state captures, not a claim that animation quality passed because the harness passed.

Engine and phone capture.json agree: patrol60u/s, playback1,0.725s measured cycle,43.5u travel; approach100u/s, playback1.2962962962963,0.433333s measured cycle,about43.335u travel. Canonical source durations remain90ms and70ms. Approach therefore displays roughly54ms per source frame. Sampled advancement is about5–5.83u/frame in either gait. This makes a stance foot need roughly10–11.67source px of backward movement per frame at2px/u; whole-cycle travel alone is insufficient proof of contact registration.

## Identity, anatomy, scale and display

PASS: complete quadrupedal body in every frame; head, both forelimbs, both hindlimbs, shoulders and haunches present, with plausible occlusion of far limbs. No waist-up substitute, severed limb, canvas clipping, debris or opaque rectangle. Long pale limbs, bent joints, angular long muzzle, hanging beard/hide and layered Decay Green back preserve the approved creature. Matte painted material belongs with the style references; no gore. Design height and physical bulk stay reasonably consistent; this is articulation rather than whole-body shrinking. All source frames face right.

PASS: mirrored captures preserve ground height and overall physical scale. Mirroring does not create a new anatomical omission or an implausible one-sided light. At698×393 phone capture size the creature remains a distinguishable low, long, hostile silhouette with moving limbs; fine toes merge as expected. The gait discontinuities become a small repeated scramble/stutter, not a smooth supported walk. Phone reduction does not cure them.

## Pair-by-pair motion judgment (both clips share these poses)

- F0→F1: acceptable early unloading; full body and four limb identities remain readable.
- F1→F2: acceptable main body continuity. The pale near hind limb folds forward and the near forelimb advances; there is no whole-creature scaling jump. See FLAG adjudication below.
- F2→F3: acceptable progression toward the forward forepaw contact, with rear paw lifting. This pair alone reads as a step.
- F3→F4: body/material continuity passes, but the rearward extended hind stance returns abruptly while the forepaw remains far forward. This starts the confused late-half phase rather than presenting an unambiguous opposite-side contact.
- F4→F5: FAIL in the support sequence. The pale near rear foot curls up behind/under the rump; the long near fore support changes location sharply rather than following the ground's backward movement.
- F5→F6: FAIL. The near hind limb opens back out toward the rear ground position after its tuck, instead of carrying that foot forward toward the next contact. This is a reset/stamp, not forward swing continuation.
- F6→F7: FAIL. The same hind paw lifts/tucks again immediately, while the long front paw jumps forward/down into another contact. This repeats the unloading action rather than advancing a coherent four-leg phase.
- F7→F0: FAIL. Hind paw re-extends to rear ground again; forward fore support snaps back toward the F0 location. Torso seam is stable, but individual feet do not form a continuous supported stride.

The far hind leg does move under the belly and the far foreleg alternates between under-shoulder and ahead poses; neither is missing. Their movement does not supply a stable opposite-side support explanation for the near hind foot's repeated lift/reset or the near forepaw's abrupt ground-contact displacement. A convincing monstrous gait may be uneven, but its planted feet still require physical continuity.

## FLAG adjudication

- A-11 `pursuer_patrol_walk` F2, size+6.4%, height+0.9% from F1: ACCEPTED as an isolated size-proxy flag. Native frames and onion F1→F2 show changed limb overlap/open silhouette, not a uniformly enlarged head/torso or changed identity. This does not excuse the separate late-loop gait failures.
- A-11 `pursuer_approach_walk` F2: ACCEPTED for the same visual reason; it is the identical reused artwork.

No automated DEFECT was reported. No further FLAGS were present. Allowed reuse/derivation is correctly disclosed and is acceptable in principle; the actual motion still fails the visual acceptance gate. No production art or code was changed during this review.

REVIEW: FAIL (2 clips)
