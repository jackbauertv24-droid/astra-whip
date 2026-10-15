# Independent review: pursuer idle r02

Scope is `pursuer_idle` only. `pursuer_patrol_walk` is the unchanged size, identity and handoff reference; this review does not renew acceptance of unrelated clips or missing inventory. I did not create or process the production art, and did not read previous verdict files or builder notes.

Blind observations were saved successfully in `blind_observations.md` after opening the lineup and both complete strips, before contract, index, audit or metadata reads. Subsequently inspected ART_CONTRACT, ART_BIBLE, ANIMATION_SPEC, relevant machine contract entries, all five registered style-lock images, all six native idle PNGs, both complete onion sheets, clip timings/derivations, derivation records and both audit files. Both capture logs ended PASS before inspection. Inspected all 28 engine/phone captures through unchanged-scale crop sheets (all six idle frames and patrol entry in both facings at each viewport), with full-scene examples for context. Crop sheets are saved alongside this verdict.

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| pursuer_idle | PASS | None | Full creature, stable identity and scale; coherent local breathing with subordinate rag motion, fixed paws/root, continuous loop and patrol handoff in both facings. | None required. |

## Visual findings

Identity and anatomy: all F0–F5 retain the elongated head, pale sinewy limbs, excessively long clawed forelimbs, olive ragged hide and same four-limb construction. The body is complete and inside the canvas. The inner hind limb is flexed and partly suspended as in the reference stance; it does not vanish or become a replacement forelimb. No torso-only substitution, limb inflation, face/costume changes, clipped parts, debris or opaque edge is visible. Material treatment matches the pursuer style reference, with a deliberately lower patrol/idle posture rather than the reference's rear-up tell. Physical size remains the patrol size throughout.

Motion: F0→F1 begins a small chest/neck rise; F1→F2 continues it; F2→F3 reaches the upper breathing pose; F3→F4 and F4→F5 relax it; F5→F0 closes the small remaining displacement. Every pair is continuous. Rag/beard edges follow the body with a slight offset instead of jumping into unrelated shapes. The paws and lower legs stay registered on the shared ground line; there is no sliding, bouncing root or whole-body scaling. It reads as a quiet living pause, with restrained movement appropriate to idle. There is no requirement for all four limbs to animate during this planted pause.

Handoff: the final idle sample returns close to the same painted posture as patrol F0, and idle F0 is the matching neutral pose. Engine and phone captures show no identity, ground-level or size discontinuity on the 900 ms AI transition to patrol entry in either facing. The patrol onion sheet was inspected as continuity context, including its F7→F0 seam; it introduces no incompatible body structure at the entry.

Phone and mirroring: the low creature silhouette, raised long snout and pale limb breaks remain identifiable against the masonry at the actual phone viewport. At that size the breathing is very restrained and fine cloth detail is reduced, but the chest/head outline retains a small coherent change; the result does not depend on moving the whole sprite to simulate life. Mirroring preserves anatomy, readable orientation and plausible diffuse lighting. Captures show neither contact drift nor a rectangle, and the full scene retains a clear platform edge.

## Audit and derivation adjudication

`audit.json` and `audit.md` report 0 DEFECT and 0 FLAG across the two supplied clips; there are no FLAGs to accept or reject. Visual inspection finds no additional blocking defect in the scoped clip.

`pursuer_idle` declares a scripted fallback derived from patrol F0, local chest/neck deformation with three source pixels maximum lift and subpixel cloth follow-through, six unique breathing phases at 150 ms, looping. The visible motion agrees with that declaration and reads as stationary breathing. Acceptable under ART_CONTRACT §11 and ANIMATION_SPEC's reviewed cutout allowance. Retain the scripted fallback disclosure as quality debt in the release handoff; this approval does not characterize the clip as independently painted poses. The unchanged patrol fallback is context, not a new scoped deliverable.

Attacks, whip composites and effects are not applicable to this clip. Missing clips listed by this deliberately partial review pack are outside this acceptance scope.

REVIEW: PASS
