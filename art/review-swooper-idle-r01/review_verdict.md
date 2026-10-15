# Independent swooper idle review r01

Reviewer: fresh agent `/root/swooper_idle_review_r01`, 2026-10-15. Scope is the two present clips only; the inventory of 62 absent clips is outside this acceptance. No production files changed.

Blind evidence was saved in `blind_observations.md` after opening the single lineup and both strips, before index, audit, contracts, metadata or references. The blind description identifies a whole shrouded winged creature with hanging ragged cloth, not a legged humanoid or truncated torso. Both lineup tiles show the same head, body, wings and scale. In the idle strip, f0 has broad spread wings, f1 starts closing, f2 closes further, f3 is the tightest pose, f4 opens to the f2-like pose, and f5 opens to the f1-like pose. Cruise f0–f3 progressively close, f4 is the narrowest, f5 begins opening, f6 opens further, and f7 approaches f0. No tile loses a body part, changes costume or hits a canvas edge.

| Clip | Verdict | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| swooper_perch_idle | PASS | — | None blocking. Reads as stationary airborne idle with restrained wing flex. | None. |
| swooper_cruise | PASS | — | None blocking. Broad, articulated slow wingbeat; unchanged identity reference. | None. |

## Direct inspection and acting

Opened all 14 individual native RGBA frames, both complete onion sheets including idle 5→0 and cruise 7→0 seams, all five registered style references in `art/style-lock.json`, and all 28 engine PNGs in `evidence/swooper-idle-native` and `evidence/swooper-idle-phone`. Read both capture records, ART_CONTRACT, ART_BIBLE including its implementation style-lock amendment, ASSET_BRIEFS swooper brief, machine contract, index, audit and both derivation records.

The wing shoulders stay attached to the same torso. Outer fingers change angle and membrane shapes change with them; this is visible articulation rather than translation of a static drawing. The central hood, chest and trailing cloth remain stable, avoiding breathing by scaling the whole actor. The stationary cloth is restrained acting/quality debt, but does not defeat this small hovering idle. Native f3→f4 of idle reverses the wing travel cleanly; it does not cut to a different anatomy. Every onion pair is continuous: idle 0→1, 1→2, 2→3, 3→4, 4→5, 5→0; cruise 0→1, 1→2, 2→3, 3→4, 4→5, 5→6, 6→7, 7→0. No pair needs a corrective frame.

The term perch does not require feet planted on a prop here: this actor has no declared legs, the brief permits idle/perch and supplies no grounded pose requirement. The captures show a suspended idle with a stationary root. It reads as waiting in the air and does not impersonate the distinct wing-fold dive tell.

The source hood points toward screen right and trailing ragged cloth sweeps left. Its near frontal spread makes facing less emphatic than a long-snouted animal, but the head/cloth asymmetry consistently establishes the rightward source. Mirrored left captures retain the same identity and plausible lighting.

At phone display size the broad pale wings and hanging shroud remain separable from the blue-gray ruin. Wing closure is subtle but visible across the supplied sequence. The creature does not disappear into masonry, become a single speck, or acquire a cutout rectangle. Its painted matte weathered material, muted ash/bone values and restrained detail fit the five registered references; no gore or borrowed emblem is visible.

## Timing, handoff and derivations

Idle metadata matches six 150 ms frames, looped, totaling 900 ms. Cruise matches eight 90 ms frames, looped, totaling 720 ms. Engine records sample the expected idle frames at approximately 0, .15, .30, .45, .60 and .758 seconds and enter cruise at approximately .908 seconds in both directions. Both resolutions keep position `[1800,377.5]` throughout idle and the sampled transition. These are engine viewport captures, explicitly not physical-device tests.

The reused idle order `[0,1,2,3,6,7]` is acceptable under §11. It removes the deepest cruise contraction and slows the beat; the resulting sequence independently reads as a restrained stationary hover. Its last pose is near the first, so both the loop seam and the captured idle-f5→cruise-f0 handoff preserve size, body center and near-open wing pose. The transition does not pop or require a new takeoff drawing for this airborne interpretation.

Cruise's declared scripted fallback is acceptable visually: joints and membranes flex around fixed shoulders, with no torso scale pulse or detached mesh seam seen in any individual frame. This remains scripted-animation quality debt that should stay disclosed in release handoff under §11; the declaration is not a substitute for this visual review.

## Audit adjudication and scope

`audit.md` reports zero DEFECT and zero FLAG for the two clips. There are no FLAGs to accept or reject. Visual inspection found no additional blocking defect. No attack composite, whip socket or effect applies to these clips. This verdict approves only the presented idle and cruise frames and supplied viewport handoff evidence; it does not approve absent dive, hurt, death or other inventory clips.

REVIEW: PASS
