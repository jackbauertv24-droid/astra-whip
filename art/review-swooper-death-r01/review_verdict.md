# Independent swooper death review

Scope: `swooper_cruise` and `swooper_death_fall` in this pack, plus both facings in the supplied native and phone engine captures. This is not project approval or physical-device approval. Both capture manifests explicitly say `physical_device: false`.

Blind descriptions were saved to `blind_observations.md` before opening the index, audit, intents, contracts or references. I opened both onions, including cruise F7→F0, all thirteen individual delivered PNGs, all five registered style-lock images, the swooper identity key and painted death-collapse r05 key. I inspected its normalization/provenance, the declared derivation and `tools/prepare-swooper-death.mjs`. I opened both capture manifests and all 36 supplied capture images: before, F0–F4, hold350ms, ground-settle and cleanup for both facings at both sizes. No builder notes or earlier review verdicts were consulted.

| Clip | Result | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| `swooper_cruise` | PASS | — | Connected broad wing articulation, stable hood/body proportions, coherent return through F7→F0. | None. |
| `swooper_death_fall` | FAIL | F004; hold350ms and ground-settle, both facings/native and phone | The final ash becomes visually absent before it reaches the floor. Ground-settle captures are effectively indistinguishable from cleanup; the required ash-settle cannot be read at phone size. | Keep a small, soft, readable ash cluster in the held final frame and register it to the falling body origin so it visibly arrives and rests on the ground before cleanup. Preserve the collapse keys and 350ms clip timing. |

## Anatomy, identity and acting

The ash-grey membranes, ochre-grey spars, shrouded small torso and fraying tail belong to the same painted design as the approved identity. They also fit the subdued textured gothic style of the five references. Both wings remain present and attached; there is no cropped limb, free-floating strut, unexplained new limb or obvious scale distortion. No gore is present.

Cruise uses restrained articulation rather than translation of a static drawing. Every adjacent onion pair follows the same shoulder roots and stable torso. F3→F4 slows at the narrow phase and F4→F7 opens in an orderly reversal; F7→F0 is small enough for a continuous 720ms loop. The movement is subtle but readable in the broad silhouette.

Death F0 banks out of broad flight. F1 brings both spars and membranes down alongside the torso with no supported fan left at the top. The progression is fast, but the resulting closed, limp silhouette reads as lost lift rather than another powered wingbeat. F1→F2 is a small sag/hood droop, not another held active flight pose. The source key's nominal folded envelope remains anatomically compatible with the earlier hood and cloth body. F2→F3 erodes and softens the same silhouette. F3→F4 is visually a near disappearance.

The bank-to-fold change is large in the onion, but the relevant visible motion is inward/downward folding around the same central body. It is acceptable as a rapid 70ms lethal buckle within this five-frame action; it does not warrant a separate replacement of F1.

## Runtime fall, timing and visibility

Both capture manifests describe normal production 1HP becoming 0HP and entering `death_fall`, with no loss of hero HP. The two facings mirror correctly. Before→F0 keeps the creature at the flight origin while the pose banks; F1 and F2 then visibly descend. The reported root positions support actual falling motion: y379.1123 at onset, y392.6123 at75ms, y404.6123 at141.67ms, y418.1123 at216.67ms, y430.1123 at283.33ms and y442.1123 at350ms. Those increments match180u/s with fixed x, so this is not a sprite-only downward illusion or per-frame recentering.

At native size the 70ms bank, folded buckle and sag remain distinct; at phone size the narrowing silhouette and initial descent still communicate defeat. F3 is already very faint, and F4/350ms are effectively gone. The recorded root then continues to y560 at1.0417s before cleanup at1.2583s. In all four ground-settle images, no readable grounded ash grouping establishes that endpoint. The root telemetry proves a floor stop, but cannot substitute for the missing visible ash arrival/settle. Cleanup itself is clean and does not leave a rectangle or persistent ghost.

## Audit FLAG adjudication

- **A-11, F001, size12.6% / height6.4% change from F000: accepted.** The individual frames and onion show broad diagonal membranes folding down into a narrow silhouette; the hood and torso are not uniformly shrunk. This is the intended loss of wing support, with connected limbs and no identity change.
- **A-11, F004, size92.7% / height95.6% change from F003: defect in the supplied runtime result.** Substantial ink loss is valid for a dissolve, and there is no evidence of whole-body scaling. However, the reduction leaves only tiny low-contrast flecks, so the required held/falling ash and final ground settle do not read, especially on the phone captures. Retain the dissolve but give the remaining ash enough soft area/opacity to establish its final trajectory and resting location.

## D23 derivations

Cruise's declared local wing rig is accepted on the visible connected motion and stable body, not merely because reuse is allowed. Death's reused bank, painted limp fold and local sag produce a readable interrupted-flight collapse. The declared source normalization is a single bounded1.012658 factor for the static key; the animation script does not globally scale or recenter the body. The erosion preserves a consistent dissolving source, but its held final stage is too insubstantial in the actual captures to complete the ash-settle action. D23 therefore does not justify approval of that stage. Preserve the scripted-animation quality-debt disclosure.

REVIEW: FAIL (1 clips)
