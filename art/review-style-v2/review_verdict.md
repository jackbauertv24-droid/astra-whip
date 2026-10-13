# Independent style calibration review

## Blind descriptions (recorded before reading intent, audit, or briefs)

- Lineup: a full-height, slender human adventurer in a brown split long coat, cream sleeves, forearm bracers and tall boots; a second view appears to be the same man lunging or punching right with an extended closed fist; a smaller, hunched olive-grey creature leans right with long claws and ragged, leaflike extensions. The creature is roughly two-thirds of the upright human's height. All feet sit on the same baseline.
- Neutral strip: a single upright, right-facing three-quarter human in relaxed stance, with both arms hanging, coil at the near hip, brown hair and exposed face. Both boot soles appear grounded. It reads as standing rather than an action.
- Attack candidate: the same long-coated man in a broad split stance, leftward arm drawn back and rightward fist extended horizontally. The torso and coat open into a strong diagonal. Without an added weapon, the visible action reads as a straight punch; no projecting whip or distinctly readable held handle is evident at this size.
- Creature candidate: a lean crouching humanoid monster with a narrow skull or snout, bent digitigrade-looking legs, long forward clawed arms, and olive ragged fronds or cloth-like skin. Predatory and forward-leaning, with a separated silhouette and no obvious equipment.
- Terrain candidate: nine square dark grey cracked masonry panels in a three-by-three grid, with a thin top coping and an engraved interlaced circular emblem in the center panel. Tile seams and corners are prominent and regular.
- Scene candidate: detailed ruined Gothic arcades and distant spired castles in cold cyan haze under purple-grey clouds. A small warm brown human stands on a broad stone floor. A small gold diamond on a grey post appears to mark an objective to the right. Foreground stone has conspicuously repeated panels and circular emblems; architectural depth reads clearly.

## Scope and evidence

Reviewed only ART_BIBLE §8's five static calibration pieces. Read the contract, bible, scope and audit after the initial blind descriptions. `lineup_hero.png` was opened subsequently and shows the same single neutral figure described above; it adds no new pose. Opened the neutral source, mirrored preview and contact/socket overlay; attack source, socket/hitbox overlay and scene previews; pursuer source, contact overlay and scene previews; terrain source, collision grid and three-wide repetition; environment source, phone and grayscale previews. No artwork was changed.

The generic index lists 63 absent production clips. Those are outside this explicitly limited style gate and are not failures of these five pieces. There are no animation pairs, onion skins, derived motion clips or effect progressions in scope. No production animation or final whip-layer approval is given here.

## Per-piece verdict

| Piece | Verdict | Failing frame/evidence | Finding | Smallest necessary correction |
|---|---|---|---|---|
| `style_hero_neutral` | FAIL | f000 / `neutral_contact_socket.png` | The cyan marker at source (236,344) sits on the hanging coil beside the near glove, rather than on the actual hand's grip. The overlay does not establish the required hand-at-grip relationship. | Re-anchor the neutral socket to the visible gripping hand and show the grip/coil connection clearly in the overlay. If the painted hand does not actually hold a grip, locally clarify only that hand/handle junction; retain the approved-looking body, scale and costume. |
| `style_hero_attack_key` | PASS | — | Same full-bodied hunter, planted stance, extended unobscured fist and plausible schematic whip connection/reach. | None for this static body-key gate. |
| `style_enemy_pursuer` | PASS | — | Unnatural gaunt creature with lifted forelimbs and raised head; distinct alert silhouette and readable contact-scale presentation. | None. |
| `style_terrain_patch_3x3` | PASS | — | Readable coping at the collision line; repeat joins read as consistent masonry joints, with no anomalous panel seam. | None. |
| `style_env_mockup` | PASS | — | Layered Gothic scene preserves hunter, floor edge and single checkpoint accent at phone size and in grayscale. | None. |

## Detailed observations

**Hero identity and scale.** Both poses contain head, torso, pelvis, two articulated legs and boots. Neither is a torso stretched to target height. The neutral reaches the 224 px standing guide; the attack retains comparable head size, coat construction, boots, pale sleeves, brown hair and bracers. Both face right. The attack spreads the limbs and rotates the body rather than shrinking the figure. There is no crouch in this pack to assess. The neutral mirror remains anatomically plausible and the mantle and broad form light do not create an obviously reversed shadow problem. No cast floor shadow, cut-off limb, hard extraction rectangle or conspicuous detached debris is visible.

**Neutral socket defect.** The source marker is visibly displaced toward the hip coil from the glove at the end of the near forearm. The marker alone cannot substitute for a held grip. The contact rectangle itself is plausible: its bottom meets the boot baseline and its upper edge excludes a small portion of the head as expected from the 104 u body against the 112 u visual height. This is a narrow socket/hand evidence failure, not a request to regenerate the whole hunter.

**Attack hand and schematic whip.** The outstretched fist is present and unobscured. The socket at (389,280) meets its lower edge; the arm, shoulder and planted rear leg support the strike. The socket sits about 2 u above the hitbox's upper edge, and the schematic falls into the active band before continuing to x +168 u. That is a plausible flexible whip path. The body alone initially reads as punching, as recorded blind, but the required schematic makes the intended action clear. Brief 2 explicitly asks for a body-only key with a schematic whip; absence of a final painted thong/handle here is not a production-whip defect. Actual oak grip, rings, braid, taper and animated continuity still require their later production review. The static attack and line survive phone/grayscale presentation.

**Pursuer.** The high head and lifted forward limbs are a clear vertical alert event compared with the specified low four-limbed patrol posture. Two rear supports and two long forelimbs are discernible; the alert frame's temporarily humanoid read is consistent with rearing up. It is not pet-like or a natural animal. Its size beside the hunter is plausible for the contract's alert envelope rather than the lower patrol shoulder line. The contact overlay encompasses the lower body while the raised head extends above it, appropriate to this tell. The creature remains distinct against masonry in grayscale. Ragged hide and skeletal suggestions do not expose wounds or gore.

**Terrain and scene.** The 64 u grid aligns with tile boundaries and the top coping gives one continuous walkable edge. The patch's three-wide repetition is detectable through repeated carving, but its joins do not introduce a separate lighting stripe, gap or false collision edge. The center ornament is confined to one tile in each nine-tile patch. Material and carving vocabulary match the larger architecture. In the scene, fog is behind the play plane, foreground branches frame the sides, and neither covers the hunter or landing surface. At 844×475 the hunter remains a full human silhouette with a lit face and pale sleeve; in grayscale the coat and legs remain distinguishable from the wall. The amber checkpoint diamond is the sole bright warm signal; subdued hunter leather does not compete as an interactable. The scene is painted rather than photographic, with restrained cold depth and no visible pixel-art treatment, UI text or explicit gore.

## Audit adjudication

`audit.md` and `audit.json` report 0 DEFECT and 0 FLAG over the one audited neutral clip. There are no FLAGs to accept. This does not automatically approve the four other static pieces, and the neutral socket issue is a visual finding outside those successful measurements.

REVIEW: FAIL (1 clips)
