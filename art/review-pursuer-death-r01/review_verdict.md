# Independent acceptance review — pursuer_death r01

Scope: `pursuer_death` only. `pursuer_patrol_walk` is unchanged identity, size and entry calibration, not a newly accepted production clip. No production assets or code were edited. Earlier review verdicts were not consulted.

Blind observations were successfully saved in `blind_observations.md` before contract, index, audit, or clip metadata reads. Opened the lineup, both strips, both complete onion sheets, all six native death PNGs, and all five style-lock references. Read ART_CONTRACT, ART_BIBLE, ANIMATION_SPEC, relevant ASSET_BRIEFS and GAMEPLAY_RULES requirements, machine contract, clip metadata and derivations, and both audit files. Review used zero-based frame numbers.

| Clip | Verdict | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| pursuer_death | PASS | — | None | None |

## Anatomy, identity and action

The same gaunt olive/bone quadruped remains identifiable from patrol entry through F3: long head and hanging fibers, ragged spine covering, pale jointed forelimbs and folded hindlimbs. Every opaque body pose contains the complete creature. Occlusion in the folded poses is consistent with limb overlap; the body is neither cropped nor uniformly shrunk. Head and torso mass stay credible. All source poses face right and mirror correctly in the engine.

The patrol-to-F0 entry is a short shoulder/head compression over an unchanged ground origin. F0→F1 folds the hind knees and lowers the shoulders while the foreclaws remain available to carry weight. F1→F2 continues the head/chest descent and forearm extension. F2→F3 releases that support: the chest and head reach the floor, the forearms stretch along it, and the hindlimbs fold and trail. F3 has a low rounded back, but the chest, long face and limbs rest on the ground rather than supporting an alert crouch. It reads as a limp grounded collapse with the creature's mass retained. This is articulated pose change, not a translated or scaled standing cutout.

F3→F4 preserves the grounded corpse registration while its colors turn Ash Grey, transparency increases and small eroded gaps appear. F4→F5 reduces it to a very faint remnant with small settled flecks. The last stage is intentionally subtle at phone scale, but follows an already visible full collapse and grey dissolution; it is not an instantaneous disappearance of a living creature. There is no blood, open wound, dismemberment, hard rectangle or detached body-part debris.

## Every adjacent pair and boundary

- Entry patrol F0→death F0: same full creature and root; plausible initial buckle.
- F0→F1: knees fold and torso compresses; no limb teleport or scale jump visually.
- F1→F2: connected lowering of head/chest and further forearm extension.
- F2→F3: larger downward release into floor contact, appropriate to loss of support; body length redistributes into trailing limbs rather than vanishing.
- F3→F4: identical grounded mass erodes into ash; no registration pop.
- F4→F5: dissolution completes and flecks settle; no return to a living pose.
- F5→hold→hidden: faint final ash stays fixed through the hold, then cleanup removes it without a visible new pose or floor jump.

Both patrol onion sheets/strips were inspected for reference continuity; this review does not reopen their acceptance. No attack or weapon composites belong to this scoped clip.

## Audit FLAG adjudications

1. **A-11, F1 from F0: size 6.3%, height 2.9% — ACCEPTABLE.** The threshold is narrowly exceeded by a newly folded silhouette with more overlapping limbs and changed exposed hide. Native frames and onion overlay retain head, torso and limb scale; this is supported joint motion, not whole-body shrinkage or lost anatomy.
2. **A-11, F5 from F4: size 93.5%, height 95.9% — ACCEPTABLE.** These are dissolve frames. The ink threshold stops counting almost all of the deliberately low-alpha remnant. The visible previous corpse is grey and eroding before this final reduction; the remaining faint shape and flecks stay registered and settle. The measurement describes dissolution rather than a physical body-size pop.

No other FLAG or DEFECT appears in the supplied audit (0 DEFECT, 2 FLAG).

## Actual engine and phone evidence

Waited until both `evidence/pursuer-death-capture-r01.log` and `evidence/pursuer-death-phone-r01.log` ended in PASS before examining their captures. Inspected all 36 submitted PNGs through unchanged-scale crop sheets saved as `captures-engine-native.png` and `captures-phone-native.png`; also opened the complete F3 engine and phone screenshots to confirm scene context. Each sheet has right-facing samples on top and left-facing samples below; columns are before, F0, F1, F2, F3, F4, F5, hold, hidden. Crops preserve native pixels and cover the whole creature in every sample.

At 1280×720 and the submitted 852×393 phone viewport, both facings read as standing creature → buckle → lowered chest → prone body → grey ash → cleared floor. The full grounded collapse remains discernible at phone size, with no cutoff, hard edge, wrong facing or floor drift. The grey stage is faint against the masonry but occurs after the prone silhouette has made death unambiguous.

Read both capture.json files and `game/tests/capture_pursuer_death.gd`, plus the actual `Foe.take_hit` and dead simulation branch. The harness starts the normal pursuer at 1 HP and invokes the production damage handler, which reduces HP to zero and enters death. It does not directly select the death clip. Both facings expose all six sequential frames at elapsed 0, 0.0833, 0.1667, 0.2417, 0.325 and 0.400 seconds, consistent with six 80 ms contract durations and 120 Hz sample quantization. F5 remains visible at 0.7583 seconds and becomes hidden by 1.3083 seconds. Root x remains 1050, mirrored ground pivots are checked, and dead contact causes no health loss. Both records confirm all-six-frames-then-hold and no-dead-contact damage.

## Declared derivation

The supplied metadata declares a D23 scripted fallback: painted body keys and registered corpse, followed by scripted ash erosion/flecks. Independently judged the submitted action rather than relying on the cited static acceptance. The derived final motion reads as the intended collapse/ash-settle. Retain the declared scripted-animation quality debt in handoff as required by ART_CONTRACT §11.

REVIEW: PASS
