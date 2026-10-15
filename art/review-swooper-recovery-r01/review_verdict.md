# Independent animation review — recovery r01

Reviewer: independent `/root/swooper_recovery_review_r01`. Scope: new recovery and the unchanged dive/cruise references, including both outgoing/incoming handoffs. No builder verdict was supplied. This is approval of these three clips, not approval of the missing production inventory.

I opened the lineup and every strip and successfully saved `blind_observations.md` before opening metadata, contracts, references or audit. I subsequently opened all 18 individual frame PNGs, all three onion sheets (including cruise f7→f0), all four painted source keys, every one of the five registered `style_lock_r01` reference images, ART_CONTRACT, ART_BIBLE, applicable ASSET_BRIEFS, contract JSON, clip/derivation records, the recovery rig/normalizations and the cruise/dive preparation scripts. I visually inspected all 16 PNGs in each of `evidence/swooper-recovery-native` and `evidence/swooper-recovery-phone`, and read their capture records. No requested image was missing or unreadable. No production files were edited.

| Clip | Verdict | Failing frames | Finding and smallest required correction |
|---|---|---|---|
| swooper_recovery_climb | PASS | — | Bank/catch, righting and two conspicuous wing contractions read as an effortful climb in the engine captures. Coarse six-frame cadence is visible, but the wing strokes are substantially stronger than cruise and the wings remain attached. No required correction. |
| swooper_dive | PASS | — | Folded dart rotates into the low horizontal pass without changing body scale; terminal pose supplies a coherent start for the opened-wing catch. No required correction. |
| swooper_cruise | PASS | — | Broad silhouette with restrained continuous wing articulation; f7→f0 closes cleanly. No required correction. |

## Identity, scale, anatomy and facing

The same angular hood, hidden face, small wrapped torso, two articulated membrane wings and long shredded trailing cloth persist through the four source keys and delivered frames. The banked catch is a different painting, but neither its hood nor its central torso reads as a different-sized creature. The righting key has modest changes in individual rag edges, which remain cloth pose variation rather than a costume replacement. No feet are required for this flight actor; the entire designed body/tail is present. None of the delivered poses is cut off, contains a hard rectangle, or shows floating detached membrane pieces.

Bounding-envelope changes are chiefly wings spreading/folding and the tail rotating. They should not be interpreted as whole-body scale changes. Catch normalization is 1.0 and righting is approximately 0.950, both bounded uniform operations. The repeated derived recovery poses preserve the source trunk and cloth instead of scaling the whole figure. The downstroke poses lose projected membrane area, but the hood and torso stay the same size.

Cruise and the upright recovery poses are three-quarter views with a partly frontal hood, so their facing is less emphatic than the dart. The hood opening/tip and body presentation are consistent with the right-facing source; dive and banked catch make that direction explicit. Mirrored left engine captures preserve that relation. I do not find an actual left-facing source frame.

At recovery f2/f4 the high outer wing joints remain visible while the membrane tips sweep down and inward. The inner shoulders connect continuously to the shrouded trunk; there is no visible root gap or membrane sliding off the body. The extreme contraction is angular, but remains a recognizable folded joint configuration rather than a resized bat drawing. Cruise uses a smaller version of that flexion.

## Motion and handoffs

Cruise pairs f0→1, 1→2, 2→3, 3→4, 4→5, 5→6, 6→7 and seam 7→0 all retain the same body anchor. The wing motion is small and the tail is mostly held; acceptable for restrained cruise, with scripted-animation quality debt retained.

Dive pairs f0→1 and f1→2 rotate the same folded body around its middle. F2→3 is a small cloth/strut adjustment. The large envelope-height changes do not produce a shrinking hood or torso.

Recovery f0→1 is the largest visible orientation change. My blind concern was a possible jump; the individual images and scene evidence clarify it as a banked catch turning upright while the tail swings below the body. It is brisk and sparsely sampled, but the middle of the body stays anchored and the wing placement follows the bank rather than teleporting to a detached location. F1→2 contracts both outer wings; f2→3 reopens them; f3→4 and f4→5 repeat that effort. At 150 ms per pose this is a deliberately coarse pumping action, not a smooth high-frame-count flap. It nevertheless shows distinct working strokes and differs visibly from the lighter cruise oscillation. No pair requires a blocking correction.

Dive f3→recovery f0 abruptly opens the wings, as a catch should, while retaining the rightward hood and left-streaming cloth. Recovery f0 supplies a banked bridge instead of jumping directly from dart to upright cruise. Recovery f5→cruise f0 uses the same spread pose, so it has no art seam. In both directions, the engine samples show continuous climb at one horizontal position and then a patrol-height return; the sprite's body does not detach from its gameplay pivot.

Both capture records describe a natural dive→recovery transition, approximately 0.908 s recovery, altitude 64→182.5, and samples of all six recovery frames followed by cruise f0. The visible positions agree with ascent. At phone presentation the membrane edge/hood/tail remain distinguishable from the dark masonry, and the wide/narrow pumping silhouettes remain readable. The fine internal membrane detail is naturally lost at that size; action recognition does not depend on it. These are emulated phone viewport captures (`physical_device: false`), not evidence of physical-device testing.

## Every audit FLAG adjudicated

| FLAG | Decision | Visual reason |
|---|---|---|
| A-11 swooper_dive f001: size 1.6%, height 28.1% from f0 | Accept | Rotation lowers the diagonal folded silhouette; hood/body size and wing attachment stay coherent. |
| A-11 swooper_dive f002: size 0.6%, height 21.9% from f1 | Accept | Further pitch into the horizontal pass changes the envelope, not the physical creature scale. |
| A-11 swooper_recovery_climb f002: size 12.7%, height 2.9% from f1 | Accept | Outer-wing contraction narrows the visible membranes while the same-size hood/trunk remains at the body anchor. No global shrink is visible. |
| A-11 swooper_recovery_climb f003: size 10.4%, height 3.4% from f2 | Accept | Reopening the membranes restores the broad silhouette; it is a stroke change, not body growth. |
| A-11 swooper_recovery_climb f004: size 10.1%, height 3.6% from f3 | Accept | Second contraction repeats the same connected-joint action with stable central body. |
| A-11 swooper_recovery_climb f005: size 11.2%, height 3.4% from f4 | Accept | Second reopening ends on the cruise-compatible wide pose without a trunk-size change. |

## Derivation and style decision

All three labelled D23 derivations are accepted as their intended actions. Recovery's two painted keys provide the bank/righting change; mesh-derived f2/f4 and reused f3/f5 provide repeated exertion and a clean terminal pose. Cruise's fixed-root wing mesh reads as restrained flight, and dive's body-center pitch plus folded-wing/cloth adjustments read as an active folded pass. Acceptance is based on the visible outputs, not the scripts' angle labels. Retain all three as declared scripted fallback/reuse quality debt in the handoff.

The creature's matte, weathered ash/bone-gray paint, restrained highlights and ragged shroud belong with the registered pursuer and hunter material treatment and the cool ruined environment. There is no glow, gore, bright decorative signal, or pet-like animal presentation. The bank/righting keys do not introduce a different rendering style. Attack/whip/effect composite rules are not applicable to this three-clip flight pack.

REVIEW: PASS
