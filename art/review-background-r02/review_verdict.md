# Independent background review r02

REVIEW: PASS

Reviewer: fresh independent agent `/root/background_review_r02`, 2026-10-20. No production edits. No prior review verdicts or builder fix/evidence notes were read. The approved environment reference image was viewed directly, without reading its neighboring review.

## Protocol and scope

Viewed `lineup_background.png` and each of the four `strip_bg_*.png` individually, saved `blind_observations.md`, then read that saved file before index/scope/audit or intent. Read `index.md`, `scope.json`, `audit.md` (0 DEFECT, 0 FLAG), original `contract/art_contract.json`, `docs/ART_CONTRACT.md` including §9, complete ART_BIBLE, ASSET_BRIEFS including §9, and ASSET_SPEC background/placement rules. The original actor animation contract remains unchanged. These four assets are separate static backgrounds; transparent effect border and actor anatomy rules do not apply to opaque panels.

All five actual style-lock references inspected: `art/frames/style_hero_neutral/f000.png`, `art/candidates/style_hero_attack_key.png`, `art/candidates/style_enemy_pursuer.png`, `art/candidates/style_terrain_patch_3x3.png`, and `art/review-style-v3/style_env_mockup.png`.

## Per-asset verdicts

| Asset | Verdict | Findings | Failing images |
|---|---|---|---|
| bg_sky | PASS | Dark violet painted cloud field matches the environment reference, stays behind all play information, and has no stars, warm distraction, pixel grid or photorealistic mismatch. Opaque static texture is appropriate. | None |
| bg_distant_silhouette | PASS | Teal mist and repeated spires establish distance with lower contrast than near masonry. Both wrap and midpoint join continue clouds, mist and silhouettes without a hard rectangular or material seam. Bilateral motifs are discernible when deliberately studied in the wide repeat, but remain plausible ruined-city rhythm and do not become a distracting joint in supplied stage captures. | None |
| bg_midground_arch | PASS | Matte charcoal/violet stone, pointed arches and tracery match the locked mockup and terrain family. Full strip/repeat clearly exposes reflected architecture; this is visible reuse, not an invisible organic panorama. The midpoint is a coherent broken central pier and the wrap forms a coherent paired-arch pier: no split blocks, lighting jump, clipped contour, material discontinuity or bright vertical seam. Its repetition is noticeable in the scene but does not impair depth or play readability. | None |
| bg_foreground_frame | PASS | Sparse near-black violet branch corners with a genuinely open transparent center, no opaque backing or visible extraction halo. Mirroring is apparent but harmless for corner framing. Visible segments remain high at screen edges, away from actors, landing lines and tells. | None |

## Exact image coverage

Individually inspected all four raw frames: `frames/bg_sky/f000.png`, `frames/bg_distant_silhouette/f000.png`, `frames/bg_midground_arch/f000.png`, `frames/bg_foreground_frame/f000.png`.

Individually inspected both complete triple repeats: `repeat_bg_distant_silhouette.png`, `repeat_bg_midground_arch.png`; both wrap crops: `seam_bg_distant_silhouette.png`, `seam_bg_midground_arch.png`; and both reflected midpoint crops: `mirror_join_bg_distant_silhouette.png`, `mirror_join_bg_midground_arch.png`. No material seam warrants rejection. Reflection is visible and is retained as a quality limitation rather than concealed by the verdict.

All 30 actual engine PNGs were individually opened, rather than judged only through a contact sheet. The table below applies separately to each named file in **both** `evidence/background-r02-native/` (1280×720) and `evidence/background-r02-phone/` (698×393), 15 per directory.

| File in each directory | Background integration judgment |
|---|---|
| threshold.png | PASS — branch corners stay high; hero, effigy, pursuer, bridge/gap and worn landing lines remain distinguishable. |
| bridge.png | PASS — standing hero and narrow bridge top separate from architecture. |
| lower-return.png | PASS — lower landing and step route remain explicit against violet depth; no foreground intrusion. |
| court.png | PASS — three low pursuers and upright hunter remain distinct from stone; foreground absent. |
| stairs.png | PASS — stair and elevated walkway surfaces read as continuous light edges, distinct from decorative arches. |
| upper-platforms.png | PASS — separated platform ends and lower route stay legible despite fine background masonry. |
| fallback.png | PASS — small fallback landing remains visible; foreground absent and no wall fog masks its cap. |
| checkpoint.png | PASS — hunter, rooted ranged figure, pursuer and checkpoint silhouette are separable; no background warm signal competes. This is background contrast review, not checkpoint-state approval. |
| mixed.png | PASS — corner framing is remote from ranged threat, low pursuer and platform landing edges. |
| arena.png | PASS — large boss contour, hunter, arena floor and exit are readable against dark wall. |
| ground-whip.png | PASS — actual active attack body and fine whip line can be followed against wall; sparse frame stays clear. |
| air-whip.png | PASS — actual jumping attack silhouette and whip remain visible against teal/open arch and stone; branches do not touch the attack. |
| strike_windup.png | PASS — raised heavy arm is distinct at native and phone size; no foreground crosses it. |
| hazard_windup.png | PASS — warm cracked floor ellipse is the dominant warm signal and clearly visible against violet wall base. |
| hazard_execute.png | PASS — low eruption remains distinct against the background and floor; foreground absent. |

The source architecture has dense fine texture, but scene scaling and darker wall values keep it subordinate to bright walkable caps and lit actors. Teal distance, violet sky and cold masonry form a coherent depth stack. The soft violet base blend remains behind actors/terrain and does not obscure the landing edge or hazard shape in any supplied image. No unintended alpha rectangle, chroma remnant, gore, text, franchise emblem, or warm decorative signal was observed.

## Limits

Capture metadata identifies ten fixed stage inspections, two actual input-driven active hero attacks, and three explicit production-8HP boss state fixtures per directory. This review accepts static background art and its readability in those supplied views only. It does not reapprove character animation, establish all traversal states, prove performance, or claim physical-device testing. No blocking images or unresolved audit flags were found.
