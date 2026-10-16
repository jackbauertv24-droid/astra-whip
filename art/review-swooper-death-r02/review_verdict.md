# Independent swooper death review r02

Scope: `swooper_cruise` and `swooper_death_fall` in this pack, with the supplied native and phone engine evidence. I did not generate or edit the art. Blind descriptions were saved in `blind_observations.md` after opening every lineup and strip, before contextual files. No earlier review folder, builder notes, or previous verdict was consulted. Physical-device and full-project approval are outside scope.

| Clip | Result | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| `swooper_cruise` | PASS | None | Eight connected wing poses preserve the hood, torso, full ragged lower body, wing roots and scale; the modest slow beat closes continuously through F7→F0. | None required. |
| `swooper_death_fall` | PASS | None | The banked interruption loses its extended wing support into a complete hanging folded body, settles locally, erodes into ash, then visibly descends and rests on the floor before cleanup in both facings and capture sizes. | None required. |

## Inspection record

Opened the lineup, both strips and both onion sheets, including cruise F7→F0; opened each individual delivered PNG (`swooper_cruise/f000–f007.png`, `swooper_death_fall/f000–f004.png`). Opened all five images listed in `art/style-lock.json`, the approved identity image `art/production-candidates/swooper-identity-r02/key.png`, and the collapse source `art/production-candidates/swooper-death-collapse-r05/key.png`.

After the blind phase, consulted `docs/ART_CONTRACT.md`, `docs/ART_BIBLE.md`, `docs/ASSET_BRIEFS.md`, `contract/art_contract.json`, `prompts/ART_REVIEW.md`, pack index/audit, delivered clip metadata and derivations, and `tools/prepare-swooper-death.mjs`. The contract assigns this flying actor no legs and a body-center pivot; absence of human legs is therefore consistent with its complete shrouded anatomy.

Opened both capture manifests and EVERY PNG in `evidence/swooper-death-native` and `evidence/swooper-death-phone`: before-cruise, all five death frames, hold350ms, ground-settle and cleanup, for left and right. This is 18 PNGs per evidence folder, 36 total. Native capture is 1280×720; phone viewport is declared 852×393 with the landscape game content fitted within it. Neither manifest claims a physical device.

## Identity, anatomy, style and motion

The painted matte bone/ash/decayed cloth treatment belongs with the locked creature and environment references. The hood and descending cloth remain the same visual identity through the bank and compact hanging silhouette. Wings are folded alongside the body rather than removed; long fingers/struts and membranes remain connected. Nothing is clipped at a canvas edge. No human torso stretched to impersonate a full figure, detached appendage, gore, blood or rectangular alpha boundary is visible.

Cruise F0→F1→F2→F3→F4 progressively narrows the wing envelope, then F4→F5→F6→F7 opens it. The shoulders and body remain registered while the outer struts and membranes move. F7→F0 is a small final opening step, not a seam reset or identity change. It reads as a restrained slow wingbeat rather than a floating static drawing.

Death F0→F1 is deliberately the largest pose change: the banked broad wings drop down beside the hood into a narrow unsupported bundle. The same central mass and ragged cloth make this readable as loss of lift; the body does not become a miniature copy. F1→F2 is a small sag of the hanging wings/hood. F2→F3 retains the folded outline while contrast and coverage erode. F3→F4 ends the recognizable body in a small soft irregular ash cluster and scattered low-opacity remnants. At phone size the detailed flecks are subdued, but the main pale cluster remains visible and trackable against the dark stone.

## Automated FLAG adjudications

- **A-11, `swooper_death_fall` F001, F0→F1: size change 12.6%, height change 6.4% — ACCEPT.** The onion and full PNGs show open wing surface becoming overlapping folded wings, not global shrinking. Hood and body scale remain consistent, and the transition reads as a rapid lethal loss of support. The larger surface-area change is appropriate to this articulated collapse.
- **A-11, `swooper_death_fall` F004, F3→F4: size change 70.8%, height change 79.4% — ACCEPT.** Both frames are dissolve poses. The recognizable body fades out into a soft held ash residue, so a large reduction in measured ink is the intended action. F3 already establishes erosion; F4 does not introduce a hard edge, blood effect, detached limb or replacement character. The held residue remains visible through travel and floor arrival in the actual phone captures.

The audit reports zero DEFECTs and exactly these two FLAGs. Its unrelated missing-clip inventory is outside this two-clip review.

## Actual fall, anchor, hold and cleanup

Both facings retain a fixed horizontal root while the reported vertical positions progress from y379.1123 at the lethal onset to y392.6123, y404.6123, y418.1123 and y430.1123 across F1–F4. At 350ms, frame 4 remains held at y442.1123 with opacity 1. These deltas agree with 180u/s descent; the images show downward movement rather than an animation held in the original flight position.

At approximately 1.0417s the root is at y560, and the soft pale residue visibly meets the walkable floor in both native and phone ground-settle captures. At phone size it is small and quiet, but discernible as a low ash mound against the dark masonry just above the bright floor edge; it is also visible in the earlier F4/hold captures as a falling pale cluster. It has no rectangular boundary and does not read as gore. The center anchor stays coherent throughout; the ash does not jump sideways when held or when it lands.

At approximately 1.2583s, cleanup captures show the residue gone; metadata records `visible:false` and near-zero opacity. Both manifests retain hero HP5 after lethal enemy damage and show the production enemy HP changing from1 to0. The supplied sequence demonstrates arrival, a visible ground rest, and subsequent cleanup. Still captures do not independently measure the exact continuous fade curve between the supplied samples.

## D23 action judgment

Both derivations were judged by their resulting images and motion, not by their approved-source labels. Cruise's mesh-derived wing articulation reads as flight. Death's reused interruption, painted folded pose, local sag and scripted erosion read together as a complete lethal fall and ash-settle sequence. The fallback provenance remains declared quality debt in metadata, but does not itself create a visual failure.

REVIEW: PASS
