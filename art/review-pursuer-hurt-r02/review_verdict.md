# Independent art acceptance — pursuer hurt r02

Reviewer: fresh agent `/root/pursuer_hurt_review_r02`, 2026-10-15. Scope: `pursuer_hurt` only. Patrol and approach are unchanged comparison/handoff references; this verdict does not accept the missing clips or reopen their earlier reviews. No production assets were edited.

Protocol: opened the lineup and all three strips first, then saved and verified `blind_observations.md` (2484 bytes) before reading contract, clip metadata, index or audit. Read ART_CONTRACT, ART_BIBLE, ANIMATION_SPEC, relevant ASSET_BRIEFS/GAMEPLAY_RULES, machine actor/pose/clip contract, index, both derivation manifests, rig metadata and both audit files. Opened all three onions, all three native hurt PNGs and all five registered style-lock images. No earlier review verdicts or builder notes were opened. The style-lock register and required derivation manifest contain references to earlier reviews; those linked reviews were not consulted.

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| `pursuer_hurt` | PASS | None | Complete identity-preserving articulated asymmetric hit recoil, stable support and physical size, short recovery into approach; both facings remain readable at phone size. | None required. |

## Anatomy, identity and size

All three native frames contain a whole creature, including the long pointed head and hanging fringe, layered hide/back plates, both forelimbs and both hindlimbs through their claws. Bent and overlapping limbs remain connected; no torso-only substitute, amputated foot, crop, detached speck or rectangular matte is visible. The head and painted bone segments retain their dimensions as they rotate. The raised head in f000 is a pose change, not an enlarged creature. The f002 body matches the approach reference's scale and horizontal stance. Source faces right throughout; the runtime left mirror preserves anatomy and lighting acceptably.

The pallid limbs and olive hide match the registered pursuer reference and the illustrated scene. The other four style-lock pieces were inspected for the common material/light treatment. There is no added gore, pet-like redesign, glow, or mismatched rendering style.

## Motion and action

Hurt f000 retracts and lifts the head/chest while one forearm folds sharply toward the chest and the other remains extended toward its support. This is an unequal protective flinch. F001 unwinds that fold and lowers the head; f002 restores the long low approach silhouette. It reads as a brief hit and release, rather than a repeated idle breath. It does not use the alert reference's sustained high rear-up with both front limbs lifted. The early f000 recoil is the strongest pose and the remaining two poses recover progressively.

Onion f000→f001 and f001→f002 show connected joint rotation and a short torso/head arc. No limb changes identity or length, and no body scale jump appears. The support paws remain registered while the folded forelimb lowers; the far hindlimb can lift as weight returns forward. The rig record independently specifies fixed fore-far contact (197.8,224) and hind-near contact (113.4,224) in all three poses, consistent with the images. This is articulated motion, not an unarticulated cutout moving as one unit. The cutout joints have a stiff illustrated quality, but remain convincing at this brief three-frame cadence; the declared scripted fallback remains release quality debt under §11.

All patrol/approach onion pairs, including loop seams, were inspected as references. The hurt f002→approach f000 handoff returns to the same complete low creature with no apparent scale change, ground jump or support-foot slide. The native three-frame strip and recorded sampling show a clear recoil/recovery over 180 ms.

## Actual-handler and phone evidence

Both `evidence/pursuer-hurt-capture-r02.log` and `evidence/pursuer-hurt-phone-r02.log` ended in PASS before capture inspection. Opened every PNG in each of `evidence/pursuer-hurt-engine-r02` and `evidence/pursuer-hurt-phone-r02`: hurt f00/f01/f02 and approach f00 for right and left, eight per directory, sixteen total. Read every sample and timing field in both `capture.json` files.

At 1280×720, the complete creature and uneven forelimb fold remain visible against the masonry. At the recorded phone viewport (852,393), the upright recoil head and retracted front limb distinguish f00 from the lower f02 and resumed approach. Fine claws are small at phone scale, but the overall hit silhouette remains readable in both facings. Feet remain on the platform; the approach capture keeps the same registration and physical size. No UI covers the actor.

Both directions and viewports record hurt frames at elapsed 0, 0.0666667 and 0.125 seconds, followed by approach frame 0. Measured duration is 0.1833333 seconds against a nominal 0.18 seconds, within one simulation step. The approach state's elapsed value resets to zero; it is not an absolute handoff timestamp. Recorded x stays 1050.83337402344 for the right-facing sequence and 1049.16662597656 for the left-facing sequence, including the handoff, confirming a stationary root. The PASS logs report actual `take_hit` interruption of windup.

This nonlethal demonstration explicitly uses test-only initial HP=2. Both capture records separately report normal lethal state `death`, and both logs confirm normal 1 HP damage enters death. This acceptance makes no claim that normal 1 HP gameplay reaches nonlethal hurt; it accepts the authored clip and its actual damage-handler path under that explicit test condition.

## Audit and derivations

`audit.md` and `audit.json` agree: zero DEFECT, zero FLAG, empty findings. There are no accepted or unresolved FLAGs. Missing inventory outside this scoped review is not accepted here. Whip composites and burst effects do not apply to this creature reaction. The hurt scripted derivation is declared and visually reads as its intended action; patrol/approach derivations were consulted only for reference continuity.

REVIEW: PASS
