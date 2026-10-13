# Independent style calibration review

Scope: only the five ART_BIBLE §8 pieces in `art/review-style-v3`. Reviewed against ART_BIBLE, ART_CONTRACT, art_contract.json and ART_REVIEW. No other review packs, builder notes, prior verdicts or production frames were read. The independent observations were saved in `blind_descriptions.md` before reading the briefs, scope or audit. This is a style-key and static composition verdict, not approval of production animation, interpolation, timing, or motion.

## Blind observations retained

- Neutral: full standing human facing right, brown long coat, cream sleeves, dark trousers and boots, dark tied-back hair and bare face. Hanging gloved arms and brown loops at the near hip; weight appears supported by both feet.
- Attack: same brown-coated human, wide stance, forward fist horizontal, opposite arm bent at waist. Raw body alone reads as punch/thrust preparation; whole body visible. A tiny red sliver above the sleeve warranted inspection.
- Creature: hunched thin creature facing right, two grounded rear legs, two long lifted clawed forelimbs, elongated hooded-looking head and ragged green-gray material. Entire body present; threatening and unnatural.
- Terrain: nine-cell slate masonry square with bright top lip and central knot/rosette carving. Clearly rectilinear, worn stone.
- Scene: gothic ruined arches before a distant city in cyan fog and purple-gray sky; sparse dark trees frame the edges. Small brown human on continuous stone platform, pale post with gold diamond to right. Warm human is distinct from the cool setting.

The calibration lineup gives matching neutral/attack identity and scale and a shorter, distinct creature. The native hero lineup and strip show the same complete neutral image, soles on the ground guide and head at the height guide.

## Piece verdicts

| Piece | Verdict | Failing frame | Findings | Smallest correction |
|---|---|---|---|---|
| `style_hero_neutral` | PASS | — | Full head-to-boot figure with plausible adult anatomy; mantle, coat skirts, bracers and hip coil are readable. Both legs and boots are present. Right-facing source and left-facing mirrored copy remain plausible; neither light nor mantle makes the mirror look broken. Contact overlay contains the main body and marks source socket (233,337) on the near glove at the top of the coil; the coil/short grip meets that glove rather than floating beside an empty hand. Full scene, phone and grayscale preserve human silhouette, lit face and sleeves against stone. | None required. |
| `style_hero_attack_key` | PASS | — | Recognizably the same head, hair, mantle, linen, coat and boots as neutral. Bent knees, planted feet, open chest and extended arm explain the lower head position through posing rather than shrinking. Fist remains visible. Socket (355,288), game (49.5,−80), lies in that fist and within the plausible active region. Schematic grip/root touches it, and the continuous thin line crosses the yellow region to its far boundary at source x592, corresponding to +168 u from pivot. The schematic is sufficient for this key-pose gate; scene and phone/grayscale copies preserve strike direction. | None required for calibration. |
| `style_enemy_pursuer` | PASS | — | Whole four-limbed creature with rear feet down, forelimbs lifted and elongated head raised; my first biped impression describes the reared pose, not missing front legs. The high head/shoulder outline is a credible vertical alert spike relative to the specified low quadrupedal patrol. Long claws, thin limbs, ragged hide and wrong proportions avoid a natural animal/pet read. No exposed wound or explicit gore. Contact overlay is present, and the body and lifted limbs remain distinguishable beside the hero at scene/phone size and in grayscale. | None required. |
| `style_terrain_patch_3x3` | PASS | — | Grid overlay shows 128-source-pixel / 64-u modules and the walkable y0 boundary. Continuous light top lip agrees with collision, and decorative carving stays below it. Three-wide repeat preserves ordinary masonry joints without a conspicuous repeat-boundary lighting stripe, discontinuous cap or gap. One carving per patch gives controlled repetition. Scene/grayscale preserve the top edge. | None required. |
| `style_env_mockup` | PASS | — | Layered gothic scene uses subdued distant teal silhouettes, stronger near architecture, a clear platform and sparse frame-edge vegetation. Separate background, terrain and hero sources are present and visually match the composition. Hero feet meet the platform; fog remains behind the play plane. Hunter, boots and face/linen highlights survive the supplied phone and grayscale previews. The single gold diamond supplies the intended scarce interactable signal; its schematic status is declared. The mockup contains no enemy. | None required. |

## Cross-checks and limits

The style is coherent painted illustration rather than pixel art or a photographic background mixed with a cartoon actor. No baked text/UI appears in candidate art; labels are restricted to review overlays. No distinctive franchise crest, cross-based decoration, gore, magical whip glow or floor shadow was identified. Fine costume details naturally simplify on phone, while the identity-bearing silhouette and materials remain readable.

The apparent red sleeve sliver in the raw attack preview was checked directly in the PNG bytes: the 20 bright red pixels at approximately x304–314/y277–278 all have alpha 1/255, below the contract ink threshold of 40. They are absent as a visible red mark in the proper scene composites. This is not an opaque marker or release-blocking defect at this gate; transparent-edge RGB cleanup would be optional hygiene.

The neutral audit reports 0 DEFECT and 0 FLAG over one clip. There are no audit flags to accept or reject. That limited audit is not extrapolated to the other pieces: their static pose, connection, coverage, repetition and scene readability were inspected visually. No required style evidence was missing or unreadable.

The generic index lists missing production clips; these are outside the explicitly limited five-piece gate and are not failures of this pack. No motion strips, animation loops, crouch transitions, production whip progression or effects were approved. The schematic whip demonstrates socket/hitbox feasibility, not final whip material or motion. The pursuer patrol comparison is against the written low-patrol brief, as §8 expressly allows for its single alert key.

REVIEW: PASS
