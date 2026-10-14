# Independent hero key review, round 04

## Blind numbered observations

Recorded after opening lineup.png and key_1.png through key_7.png, before reading any text, contract, scope, or style references.

1. Full standing brown-haired male adventurer, facing right in three-quarter profile; brown shoulder cape and long split coat, cream sleeves, bracers, boots, coiled rope at hip. Relaxed arms and grounded feet. Complete silhouette.
2. Same apparent character in a broad rightward walking stride; front boot extended right and rear boot left, coat tails trailing. Complete silhouette and closely matching scale.
3. Same apparent character in a narrower rightward walking step; trailing knee bent and heel raised, front foot supporting weight. Head is slightly lower than 1. Complete silhouette.
4. Same apparent character in a moderate rightward stride with both legs separated and arms low; resembles an alternate walk contact. Complete silhouette and matching costume.
5. Same apparent character with a raised forward knee/boot and rear support foot, reading as a deliberate high step in a walking cycle. Head height close to 1. Complete silhouette.
6. Same apparent character reclined on the ground, torso propped partly on a bent arm, one knee elevated and the other leg stretched right. Reads as knocked down or sitting up after a fall. Both boots and head are present; body proportion appears compatible with standing keys.
7. Same apparent character in a deep crouch, rightward arm extended horizontally gripping a short handle, other hand near the bent knee. Reads as a low attack preparation or crouching strike. Complete body; no extended lash visible.

Across the lineup, brown/cream clothing, dark hair, facial direction, and small rendered detail remain consistent. No obvious opaque rectangle or broad colored fringe is visible on the dark presentation backgrounds.

## Scope and references

After recording the blind observations, read scope.md, prompts/ART_REVIEW.md, docs/ART_CONTRACT.md, docs/ART_BIBLE.md, and contract/art_contract.json. Opened only the permitted style references: art/frames/style_hero_neutral/f000.png and art/candidates/style_hero_attack_key.png. No previous review or builder history was consulted.

This is isolated reference-key approval, as scope.md specifies. It evaluates full anatomy, recognizable identity, physical scale, single-pose intent, facing, and visible extraction edges. It does not approve animation, walk-cycle alternation, continuity, timing, get-up derivation, complete whip attachment/reach, engine appearance, or release. No audit flags or sequence/composite images were supplied for this limited gate; none are accepted or waived here.

## Per-key verdict

| Key | Intended reference | Verdict | Failing image | Findings | Smallest correction |
|---|---|---|---|---|---|
| 1 | Neutral | PASS | — | Full head-to-boots anatomy, relaxed upright stance, right-facing identity matches the approved neutral reference. Grounded boots and unchanged head/costume proportions. | None. |
| 2 | Contact A | PASS | — | Extended front and rear legs form a readable walking contact pose; both boots, arms and coat remain intact. Identity, head and limb scale agree with neutral. | None for this isolated key. |
| 3 | Passing A | PASS | — | Raised trailing heel and bent rear knee read as a passing step. Modest lowering is consistent with leg articulation, with no torso-only or shrinking defect. | None for this isolated key. |
| 4 | Alternate contact B | PASS | — | Separated legs and forward foot read as a walking contact pose at consistent scale. Full lower body remains visible. This static approval does not establish opposite-leg alternation with key 2; that requires sequence evidence. | None for this isolated key. |
| 5 | Passing B | PASS | — | Forward knee and boot lifted clear of the ground, opposite leg supporting the body: readable passing/high-step pose. Full anatomy and consistent costume/face. | None for this isolated key. |
| 6 | Reclined knockdown | PASS | — | Grounded, reclined figure has complete head, torso, arms and two booted legs; bent upper leg and bracing arm communicate a fallen/reclined state. Head and limb sizes remain compatible with upright reference. It does not read as a miniature standing figure. | None for this isolated key. |
| 7 | Crouching strike body | PASS | — | Hips and knees visibly fold into a low crouch, head retains the standing character's scale, and the extended arm grips a handle. Complete boots and coat fit within the frame. The body communicates a rightward low strike; the separate lash is outside scope. | None for the body key. |

## Scale and transparency evidence

The guide-line lineup shows standing keys close to the blue height line, all ground-contact silhouettes on the red line, and the crouching key near the yellow line through bent anatomy. All seven face right and retain the brown mantle, cream sleeves, steel bracers, split coat, dark hair, and leather boots of the approved identity. No unexplained armor or major costume substitution is visible.

A direct PNG decode, using alpha >= 40 for ink, confirms all seven are 512×512 RGBA with transparent corner pixels and no visible exact-magenta pixels. The measured figures have ample canvas margins; every lowest ink row is y=448.

| Key | Ink height (px) | Square root of ink area (S) |
|---|---:|---:|
| 1 | 224 | 115.14 |
| 2 | 222 | 115.70 |
| 3 | 218 | 110.00 |
| 4 | 216 | 116.46 |
| 5 | 224 | 116.74 |
| 6 | 105 | 120.25 |
| 7 | 142 | 106.64 |

These height and size readings fit the applicable stand, stride, impact, and crouch-strike bands relative to the neutral reference. Visual inspection of every individual key and the dark-background lineup shows no obvious colored extraction fringe, opaque rectangle, clipped body part, or detached debris. This is a visual edge judgment supplemented by the listed pixel checks, not a claim to have run the production art audit.

## Decision

All seven isolated reference keys pass the stated limited scope. They are suitable as pose/identity references for further work. Production clips, motion, and complete whip composites still require their own independent review.

REVIEW: PASS
