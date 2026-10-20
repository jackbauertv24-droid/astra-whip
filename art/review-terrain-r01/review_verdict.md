# Independent terrain review r01

Scope: fourteen opaque static terrain tiles only. Independent reviewer did not generate, process or audit this art. Blind sequence completed: opened lineup_terrain.png, individually opened all fourteen strip_terrain_*.png, saved per-tile blind_observations.md and read that saved file before index, audit, scope or contracts. No builder notes or prior verdicts were read. No production edits were made.

## Basis and coverage

Read upstream ART_CONTRACT.md (including §9), ART_BIBLE.md, ASSET_BRIEFS §8, ASSET_SPEC §4, original contract/art_contract.json, pack index.md, scope.json, review_contract.json and audit.md. The original animation inventory does not contain these static tiles. Scoped requirements are one opaque 128×128 frame, origin (0,0), with collision owned by level data. Character anatomy, transparent border, onion, VFX growth and whip rules are inapplicable.

Individually opened every delivered raw frame: frames/terrain_{bottom_left,bottom_mid,bottom_right,cap_left,cap_mid,cap_right,fill_center,inner_left,inner_right,plat_end_left,plat_end_right,plat_mid,side_left,side_right}/f000.png (14/14), in addition to all 14 strips and the lineup.

Opened all five style-lock images from art/style-lock.json: art/frames/style_hero_neutral/f000.png; art/candidates/style_hero_attack_key.png; art/candidates/style_enemy_pursuer.png; art/candidates/style_terrain_patch_3x3.png; art/review-style-v3/style_env_mockup.png. These were comparison context, not a re-review of actors or background.

Opened all five repeat samples: patch_3x3.png, repeat_fill_3x3.png, repeat_sides.png, repeat_caps_9.png, platform_repeat.png. Inspected interiors and boundaries, repeated vertical sides, nine-cap span and actual top-32-source-pixel thin-platform crop.

Read both capture.json files and individually opened all 20 actual PNGs. Exact filenames below apply in BOTH evidence/terrain-r01-native/ (1280×720) and evidence/terrain-r01-phone/ (698×393): kit-board.png, kit-collision-overlay.png, stage-threshold.png, stage-bridge.png, stage-lower-return.png, stage-stairs.png, stage-upper-platforms.png, stage-fallback-step.png, stage-checkpoint.png, stage-arena.png. Coverage is 10/10 native and 10/10 phone. The board shows all 14 roles, stepped concavities, underside corners, a long thin platform and a joined single-cell platform. It is nonplayable inspection geometry; the eight stage samples are fixed inspection views. Neither capture set claims traversal or physical-device proof.

## Visual findings

Masonry is matte, cold gray with violet mortar, irregular large stone faces and restrained worn coping, consistent with the approved terrain patch and environment reference. Source detail remains painted rather than pixel-art styled. Scale relative to the hunter and threats remains consistent with the reference. No text, crosses, franchise symbols, gore or hazard-like warm decoration appear in the submitted tiles. The kit uses the plain masonry part of the approved vocabulary; absence of carving on these reusable structural tiles is acceptable, with original pointed arches and knotwork present in the authorized scene context. It introduces no competing ornament vocabulary.

The repeated squares are visibly modular: dark mortar outlines form a regular grid and the same branching cracks recur. This is also strongly present in the approved patch and mockup. Their boundaries read as masonry block joints, without bright accidental gaps, foreign backing color, or a false walkable ledge through the interior. I do not treat every visible mortar joint as a rejected texture seam. Nine-wide coping and 3×3 fill remain materially coherent; repetition is apparent but does not change the surface or obstruct gameplay reading.

The top wear line is light and continuous in engine views and aligns with the red collision boundary on both board overlays. Chipped source coping remains subordinate to the continuous rendered edge. Exposed sides are darker, undersides terminate with a small-stone band, and concave roles turn the coping into the neighboring wall without suggesting an open hole. The 32-source-pixel crop yields a shallow dark fascia with a clear light top; long spans and joined half-end single-cell spans have closed ends and no misleading full-height stone hanging below. Collision remains level-data-owned.

At actual supplied phone image size, bridge, lower return, stair lips, upper platforms and the fallback landing remain visible. Terrain adds no foreground clutter across actors, landing edges or tell silhouettes. Existing actors, UI and background are context only; these static views do not establish attack animation or traversal correctness.

## Per-asset verdict

All rows refer to f000; a dash means no failing sample and no correction required.

| Asset | Verdict | Failing frame/sample | Finding | Smallest correction |
|---|---|---|---|---|
| terrain_cap_left | PASS | — | Worn cap and dark left boundary read as exterior top corner. | — |
| terrain_cap_mid | PASS | — | Repeated coping stays continuous; body joints match reference masonry. | — |
| terrain_cap_right | PASS | — | Right cap terminates coherently without losing walkable edge. | — |
| terrain_side_left | PASS | — | Exposed left border remains readable through vertical repeats; FLAG adjudicated below. | — |
| terrain_side_right | PASS | — | Repeated right face remains a vertical edge, not a bright false ledge. | — |
| terrain_fill_center | PASS | — | Repeated gray body and dark module joints stay within approved material grammar. | — |
| terrain_bottom_left | PASS | — | Left border meets distinct underside band in a closed corner. | — |
| terrain_bottom_mid | PASS | — | Bottom band reads as underside rather than another walkable cap. | — |
| terrain_bottom_right | PASS | — | Closed right underside corner matches adjacent bottom band. | — |
| terrain_inner_left | PASS | — | Left concavity reads in stepped board silhouette with continuous coping. | — |
| terrain_inner_right | PASS | — | Opposite concavity turns cleanly at the board step. | — |
| terrain_plat_end_left | PASS | — | Cropped left end closes long and single-cell platforms. | — |
| terrain_plat_mid | PASS | — | Top32 crop retains shallow fascia and continuous landing line. | — |
| terrain_plat_end_right | PASS | — | Cropped right end closes long and joined single-cell spans. | — |

## Audit FLAG adjudication

Audit: 0 DEFECT, 1 FLAG. TILE-SEAM side_left→side_left:y, edge RGB mean 55.27 over reference-calibrated diagnostic 41.85: ACCEPTABLE. Inspected raw side_left, its strip, all three rows of repeat_sides.png, patch_3x3.png and both kit boards. The horizontal junction changes stone face brightness and interrupts the narrow vertical molding, but reads as a dark masonry joint rather than an illuminated cut, backing gap or material change. Comparable rectangular joints and abrupt stone-face value changes are visible in the approved terrain patch and mockup. At phone size this remains a narrow dark joint; exposed silhouette and collision line remain unambiguous. The numeric exceedance is a diagnostic tripwire, not an original-contract tolerance and not approval in itself. This decision follows direct comparison of the images.

No missing images or uninspected scoped samples. Approval is limited to this static terrain art and its supplied renderer evidence; original animation requirements remain independent.

REVIEW: PASS
