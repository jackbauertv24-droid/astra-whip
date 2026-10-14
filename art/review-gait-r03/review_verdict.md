# Independent gait review r03

## Blind visual notes recorded before reading intent or contracts

Opened lineup_hero.png, strip_hero_walk.png, and strip_style_hero_neutral.png first.

The neutral is a right-facing, long-haired brown-coated human with pale sleeves, metal forearm pieces, boots and a looped cord at the near hip. The walk retains that recognizable appearance. The ten walk images show an initial broad split stance repeated almost exactly in F0/F1, a narrowing and crossing of legs through F2/F3, another spread in F4/F5, an almost merged leg silhouette in F6, and a conspicuously lifted forward boot in F7/F8 before F9 returns to a broad stance. The torso/head are unusually still, with slight vertical shifts. Near-hand placement alternates between hip and lower thigh. It is difficult to track two independent anatomical legs through the middle poses: the crossing boot arrangement and coat obscure support changes. F6 has a detached dark fleck behind the feet. The forward lifted boot in F7 appears noticeably higher than the other swing poses. Neutral and walk have similar head size and coat texture. No clear left-facing frame is present.

## Scope and evidence

Only `style_hero_neutral` and `hero_walk` are adjudicated. The other 62 missing production clips and full game release gate are outside this review. Opened all provided sheets, the complete ten-pair onion including F9→F0, the permitted neutral reference, ART_REVIEW, ART_CONTRACT including §11, ART_BIBLE, machine contract, index and audit. The blind observations above were saved before these texts were read. Per-frame detail below is subsequent inspection, not a retroactive claim of additional blind notes.

## Frame inspection

| Tile | Visible body / pose / oddity |
|---|---|
| neutral F0 | Complete right-facing human from hair to two boot soles; upright relaxed stance, coat and hip coil; no missing limbs, debris or clipping visible. |
| walk F0 | Complete right-facing human in wide contact stance, back heel raised, forward boot flat; identity close to neutral. |
| walk F1 | Essentially held F0 stance with minute lower-body movement; the initial motion stalls. |
| walk F2 | Rear boot lifts and moves under the coat while front boot stays grounded; near hand/coil and skirt have changed from preceding contact. |
| walk F3 | Boots overlap tightly beneath a substantially narrower skirt; knee and hip ownership become difficult to read. |
| walk F4 | Coat suddenly becomes broader and longer at the front/right; legs spread beneath it, but the hip-to-leg connection is concealed by a changed skirt silhouette. |
| walk F5 | Similar opposite split stance, with right boot extending; full body present. |
| walk F6 | Legs and boots merge into a narrow crowded support column; a small detached dark fleck sits behind the feet. |
| walk F7 | Front boot abruptly rises with a bent knee while the other boot is planted; body rises and skirt/hand change together. |
| walk F8 | Same lifted forward leg lowers somewhat; thigh and boot remain readable. |
| walk F9 | Wide contact returns, with lower head/torso than F8; two boots visible and no clipping. |

## Identity, proportions and joins

PASS for right-facing identity and complete body across the provided clips: the same face/hair, mantle, pale sleeves, bracers, leather vest and boots remain recognizable. Standing/walking height stays near the blue guide; no torso-only or globally shrinking figure is present. The reused head has stable dimensions, and the visible collar/neck joins do not show a detached head or hard rectangular paste edge. No crouch, attacks or effects are provided in scope. The principal failure is localized continuity below the belt rather than a head-size or facing failure.

## Motion and alternating support

There is an attempted alternating gait: F0–F2 show one boot supporting while the trailing boot advances, and F7–F8 clearly show the other support with a forward swing. This is more than a globally translated standing cutout. It does **not** yet read as a convincingly continuous alternating support/swing cycle: F3/F6 lose the separate leg construction, and transitions change coat/hand/leg appearances at once. The resulting passing poses read as replacement silhouettes rather than two persistent anatomical legs advancing under one consistent costume.

| Onion pair | Decision |
|---|---|
| F0→F1 | Small movement, no teleport; almost held contact produces a cadence stall. |
| F1→F2 | Plausible swing direction, but noticeable hand/coil and skirt replacement. |
| F2→F3 | Swing advances plausibly; overlapping boots and narrowed coat obscure the support chain. |
| F3→F4 | FAIL: front skirt/hip silhouette expands abruptly, restoring substantial area and revealing a different lower-body arrangement. |
| F4→F5 | Small believable movement in the spread stance. |
| F5→F6 | FAIL: broad split changes into crowded fused boots and narrower skirt; support-leg ownership becomes unclear. |
| F6→F7 | FAIL: front boot jumps outward/upward, body rises, hand/coil and skirt change together; missing smooth passing-to-swing progression. |
| F7→F8 | Believable lowering of lifted boot; no major independent head jump. |
| F8→F9 | Visible torso settle and broadening to contact; needs smoothing alongside F6–F8 to preserve the same hip/leg chain. |
| F9→F0 | Good positional loop seam; no gross size or costume pop. |

## Clip verdicts and smallest corrections

| Clip | Verdict | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| style_hero_neutral | PASS | — | Complete consistent right-facing standing reference. | None. |
| hero_walk | FAIL | F3, F4, F6, F7, F8, F9 | Lower-body/coat replacement pops; passing legs merge; F6 debris; lift and settle lack continuous support/swing articulation. | Repair F3/F4 and F6/F7 passing transitions using persistent near/far thigh, knee, ankle and boot shapes; preserve the coat hem/hand/coil identity across these transitions. Smooth F8/F9 landing against those repaired neighbours. Remove the detached fleck in F6. Retain the recognizable upper-body/head and good loop seam. |

Corrections must preserve anatomical limb lengths and costume detail, rather than merely adjust total ink area. A planted support boot should stay on the ground while the other boot follows a short coherent swing arc; each passing frame should show a plausible knee-to-boot connection even when the coat overlaps it. The F0/F1 pause is secondary cadence debt, not the sole basis for FAIL.

## Every audit flag

- **A-11, hero_walk F4 (F3→F4), size +9.2%, height 0.0%: DEFECT.** The onion visibly confirms skirt/lower-body area popping, despite unchanged total height. Repair F3/F4 lower-body and hem continuity.
- **A-11, hero_walk F6 (F5→F6), size change 6.3%, height 0.0%: DEFECT.** A genuine passing pose can reduce silhouette area, but here both boots crowd into a poorly articulated mass with changed skirt shape. The image does not provide a convincing continuous anatomical explanation. Repair F6 against F5/F7; remove its detached fleck as an additional visual defect.
- **A-11, hero_walk F7 (F6→F7), size change 6.5%, height 2.8%: DEFECT.** The simultaneous front-boot lift, torso rise and clothing/hand change looks abrupt rather than a small believable next step. Repair F6/F7 swing and coat continuity.

Accepted flags: none.

## Derived-clip decision

`hero_walk` is explicitly listed as `scripted_fallback` using four contact/passing painted keys plus the neutral head, interpolated leg masks and nearest-parent paint. Derivation is permitted by §11; it receives the same visual gate as generated art. **FAIL for intended walking action continuity.** The source/method declaration explains the construction but does not justify the observed passing-leg and costume pops. No other derived clips are provided in scope.

REVIEW: FAIL (1 clips)
