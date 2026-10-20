# Independent review: boss hazard r01

Blind observations were written, saved and read in `blind_observations.md` before opening the index, contract, scope, audit, provenance or intent. No prior reviewer verdict or builder conversation was read. Reviewed all ten strips, all ten onion sheets, lineup, five style-lock reference images, original/review contracts, ART_BIBLE and ASSET_BRIEFS hazard requirements. Both complete capture JSONs parsed successfully: eight records each, including both facings, full cycles and three real punish branches. Review-only `engine-native-0..7.png` and `engine-phone-0..7.png` preserve every sample in JSON order. Original full-size native and phone images were also inspected. These are sampled engine sequences, not a continuous video; conclusions about timing use the recorded frame times and transitions.

Acceptance scope is the three hazard clips and supplemental late hurt. Support clips are assessed as references below; this does not grant independent release approval to their full gameplay use outside this pack.

| Clip | Verdict | Failing frames | Finding and smallest correction |
|---|---|---|---|
| boss_hazard_windup | FAIL | engine F0–F7, both facings/sizes | Body raises and holds an open reaching hand coherently, but no synchronized Ember Bright cracked floor ring is visible anywhere in the actual full captures. Restore the telegraph rendering and capture the full 1200 ms tell with the ring visible at the locked target. No body-frame correction required by this review. |
| boss_hazard_execute | FAIL | engine F0–F3, both facings/sizes | Open hand presses downward and releases into a supported stoop, but the required synchronized eruption is entirely absent from the full engine images. Restore eruption rendering and recapture the full 400 ms phase and handoff; body alone reads as lowering an arm, and does not communicate the floor danger. |
| boss_hazard_recover | PASS | — | All six native frames preserve helmet identity/physical scale, grounded boots, plated legs and the same torso/hand. Low loading then gradual return reads as recovery. Execute F3→recover F0 is coherent; recover F5→walk F0 returns to neutral without a size jump. |
| boss_hurt_hazard_late | PASS | — | Three-frame release preserves physical helmet, joined gauntlet and support; late recovery hit→hurt F0→F1→F2→recover F5→walk F0 is coherent in both facings. Small flinch is appropriate to the 200 ms reaction. |
| boss_idle (support) | PASS | — | Full-body identity and grounded stance persist, restrained breath and cloth movement; F7→F0 onion seam has no visible pop. |
| boss_walk (support) | PASS | — | Both armored legs remain present through eight frames and F7→F0. Dense cloth overlaps lifted boots, but not a missing or extra limb; neutral entry from recovery is coherent. Full locomotion outside sampled handoff is not engine-validated here. |
| boss_hurt (support) | PASS | — | Three restrained upright recoil frames retain helmet, costume and support. |
| boss_hurt_stooped (support) | PASS | — | Small recoil stays low, preserving leg/torso support. Real early punish branches return to recovery F2 without an upright reset. |
| boss_hurt_rising (support) | PASS | — | Small recoil stays near the rising recovery posture. Actual mid-recovery hit branches resume F4 coherently. |
| boss_hurt_half_stoop (support) | PASS | — | Three native poses and onions preserve identity, support and a restrained reaction. This particular clip is not exercised by the supplied hazard sequences. |

## Visual evidence

Windup F0 is neutral; F1 lifts a fist, F2 opens it, F3–F4 extends it, and F5–F7 maintains the tell with minimal breathing motion. Open fingers stay attached to the bracer; elbow silhouettes are angular but read as articulated plate rather than a detached arm. Native execute F2 has the sharpest elbow bend; scrutiny of strip and onion finds continuous upper-arm/forearm contact, not a floating gauntlet. F2→F3 closes the fist while loading the torso; the largest movement is a plausible 100 ms downward release, not a limb teleport. Torso and legs retain body mass while the helmet tilts: no head shrinking/growing, no torso-only figure, no shoe sliding along the ground, no obvious canvas clipping, key rectangle or debris. Source frames face right and mirrored engine figures remain plausible.

At original phone capture size (698×393 image inside the recorded 852×393 window), boss and hunter remain distinct and the forward arm separates from the torso. The held hand silhouette is visible despite tiny finger detail. Recovery and small hurt are intentionally subtler. However, there is no floor signal distinguishing dangerous ground from safe ground; even an observant player cannot locate the target zone from these captures. This is the material phone-readability blocker, not an anatomy objection.

Specific unambiguous evidence: `evidence/boss-hazard-phone/cycle-right-hazard_windup-f07.png` shows the held reach and airborne hunter, with plain gray floor at the target and no ring. `evidence/boss-hazard-native/cycle-right-hazard_execute-f02.png` shows the lowered open hand and airborne hunter with no eruption below. Every remaining full-cycle sample in both directions has the same absence. JSON hazard_x is 6385 for right-facing and 6095 for left-facing; the hunter occupies that target region. The absence is not caused by a cropped contact sheet: original full images show it too. ASSET_BRIEFS §5/§11 requires synchronized telegraph and eruption, and ART_BIBLE §4 assigns the ring the floor-level warm danger signal.

Both captures record approximately 1208 ms windup, 400 ms execute and 908 ms recovery. Punish branches show actual whip contact and HP changing 8→7 with stooped/rising/hazard_late context, then return to recovery and walk. These substantiate real context transitions; they do not supply the missing hazard visuals. The late branch records that full commitment extends beyond the original window, which is gameplay timing evidence rather than a sprite-art failure.

## Audit and provenance

Audit reports zero DEFECT and zero FLAG. There are no FLAGs to accept. Numeric results did not determine these judgments.

The index incorrectly says no derivations are declared. Per-clip `frames/boss_hazard_windup/derivation.json`, `boss_hazard_execute/derivation.json`, `boss_hazard_recover/derivation.json` and `boss_hurt_hazard_late/derivation.json` explicitly declare scripted fallbacks; other supplemental hurt derivations also exist. Hazard derivations retain the neutral helmet/body/legs and use a generated hand attached to a three-piece arm rig. The late hurt records a fixed-sole 12→6→0 degree release. This method agrees with the visible restrained articulation and is permitted by §11, but must be listed correctly in the review index and release handoff as known quality debt. Correct the derivation discovery/index metadata before final acceptance; the present absence of an aggregate derivations file must not hide these declarations.

Inspected hand-key provenance and registration: source canvas conversion is a uniform resolution conversion, followed by recorded uniform normalization factor 1.0057142857142858 around measured foot pivot. It does not indicate a nonuniform body squeeze. Provenance does not override the visual findings. All five registered style references were viewed: matte painted forms, corroded slate/decay cloth and subdued light are compatible; no obvious gore, franchise crest or new bright decorative signaling appears in the reviewed boss bodies.

No whip composites or effect strips are included in this body pack; boss body does not carry a whip. Missing in-engine synchronized hazard effects are still observable in, and block acceptance of, the requested full hazard action. Sprite recovery/hurt passes do not approve the absent VFX or broader scene readability against finished masonry; captures use an untextured test arena.

REVIEW: FAIL
