# Independent static source key review

STATIC KEY REVIEW: PASS

Reviewer: /root/swooper_static_key_review_r01. Scope: f000.png and lineup.png only, representing the source key identified by key.json. This approves a static identity/pose reference, not any animation, runtime integration, or release. No builder verdict, audit summary, or builder reasoning was consulted. No production files were edited.

## Protocol and references

I first visually inspected lineup.png and f000.png, then successfully saved blind_observations.md before reading key.json, ART_CONTRACT.md, ART_BIBLE.md, the ASSET_BRIEFS.md swooper section, or style-lock.json. I then visually inspected the registered style_enemy_pursuer.png, style_hero_neutral/f000.png, and style_env_mockup.png, plus art/guides/swooper.png. The blind description independently recognized a ragged winged wraith with a small hooded body and a long trailing shroud, which agrees with the stated intended pose.

## Measurements independently computed on f000.png

Using the repository PNG decoder and alpha >=40 ink threshold: canvas 384×256; source has alpha; all four corner alpha values are zero. Ink bounds are x53..335, y44..212, giving 283×169 px. The bounding-box center is (194,128), compared with the declared pivot (192,128). No ink touches the two-pixel border ring; no visible-alpha exact magenta pixels remain. All 12,745 ink pixels form one 8-connected component, so there is no separate ink debris. S is 112.894 px; no approved swooper S baseline exists in this single-key pack, so this is a measured reference value rather than proof of cross-frame scale consistency.

The 169 px envelope closely matches the 170 px cruise design and the guide's height span. The body crosses the central flight-pivot neighborhood; the shroud extends downward from it while the wings occupy the upper half. The ink centroid is (196.74,103.00), which is pulled upward by wing area and is not an anatomical pivot criterion. The total envelope is centered appropriately and the actual torso remains near the declared pivot. No foot baseline applies to this legless flight design.

## Visual findings

- Identity and body completeness: the small hooded torso, upper body, long tapering shroud and both complete wings are present. The lack of visible legs is appropriate because the swooper explicitly declares no legs. This does not read as a cropped torso. The shroud gives the body a complete descending endpoint rather than an abrupt cutoff.
- Wing anatomy: two distinct wing roots join the shoulder region; bent leading spars and radiating fingers support continuous membrane panels. Both wings retain their tips and torn trailing edges. The partially raised, asymmetric spread is a plausible static upstroke pose with a broad flight silhouette. No detached wing, duplicated free limb, or obvious impossible joint is visible. Motion and articulation through a wingbeat remain untested.
- Facing: the hood's opening/profile projects toward image right, with the trailing shroud pulled down-left. Right-facing is readable, although the hood is small and mostly concealed, so wing shape is the dominant read.
- Silhouette: broad batlike wings plus a narrow body clearly distinguish this threat from the quadruped and upright hunter. At the supplied native scale the main silhouette is readable without interior detail. Thin shroud tips are secondary detail and should not carry a gameplay tell.
- Palette and materials: ash-gray membrane, muted brown-gray structural highlights, and subdued dark folds match the weathered, desaturated material language of the locked enemy and hunter references. Old-bone-colored spars remain restrained. A tiny reddish-brown torso accent reads as aged material; it does not read as blood, a wound, an Ember signal, or a glow. No explicit gore is visible. This is visual palette-family acceptance, not an exact swatch-membership proof over painted intermediate colors.
- Style and light: matte painted shading, soft internal occlusion, restrained highlights on upper edges, and worn cloth texture fit the registered illustrated style. The wing supports read as clean structural anatomy beneath membrane rather than bone exposed through a wound. No photorealistic treatment, cartoon outline, pixel-art blocks, text, franchise emblem, floor shadow, or scenery is present.
- Edges and extraction: the gray lineup background exposes fine torn margins without an obvious key-color fringe or rectangular matte. The transparent single-frame view also shows continuous clean contour edges. Fine edge pixels and narrow strips are intentional ragged material, rather than floating debris.

## Limits

No animation is approved. This review does not establish wing articulation across cruise, the distinct folded 600 ms telegraph, dive/recovery acting, identity stability across clips, loop seams, engine-size readability against actual level masonry, or any timing and state coverage. Those require their own complete review packs. Within this static-key scope, there is no blocking defect in f000.png.
