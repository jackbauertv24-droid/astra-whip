# Independent art review — hero keys r02 and idle r01

## Blind descriptions (recorded before pack scope, measurements and audit)

1. A full-body brown-haired man in a layered brown coat, cream sleeves, dark trousers and tall boots stands facing right. Both arms hang low and a small coil hangs at the near fist; legs and boot soles are visible.
2. The same-looking full-body man steps right with separated legs and a trailing coat. His forward arm is slightly extended and his low rear fist carries a compact coil; no limb appears cut off.
3. A full-body man crouches low, facing right, with his torso leaning forward over folded thighs and knees. Two boots sit beneath the bent legs and a compact coil is beside the low fist; the head is not conspicuously smaller than the standing head.
4. A full-body man is suspended in a tucked, right-facing pose, with one knee raised forward and the other leg bent beneath him. The coat tails extend backward and the low fist appears to carry the coil.
5. A full-body man reclines almost horizontally, looking right, propped on a bent arm with one knee raised. His head, torso, both legs and boots remain visible; the coat and coil lie around his hip.
6. A full-body man stands with feet apart and one fist raised behind his head, holding a short handle horizontally. His other hand is near his waist and his coat opens around two visible legs; no long whip thong is visible.
7. A full-body man leans right with a straight arm extended at shoulder height and a short handle projecting from the fist. His other arm bends toward his waist and his legs spread into a planted stance; no long whip thong is visible.
8. A full-body man crouches with one arm extended right and a handle projecting past the fist. His other hand lies by the hip and his knees and boots fold beneath him; his outline reaches the same low level as tile 3.

The two tiles in the idle pack lineup show the same full-body, right-facing man with both boots on a shared baseline and a small coil at his lowered fist. Face, coat layers, bracers and boots appear the same, with no obvious difference in body scale.

Idle strip tile descriptions:
- F0: Full-body man standing right, arms down and coil beside his hip. Both legs and boots are distinct.
- F1: Same man and standing pose with a very small upper-body displacement. Boots remain planted and costume features remain intact.
- F2: Same man, with the upper outline slightly shifted relative to F0. Full legs, both boots and the coil remain visible.
- F3: Same standing figure, head and shoulders slightly elevated relative to F0. No missing limbs or cropped body are visible.
- F4: Same complete figure in the middle of a restrained settling movement. His stance and clothing identity remain consistent.
- F5: Same complete standing man with the upper body returning toward the initial outline. The coil stays beside the fist.
- F6: Same man nearly matching the initial pose. Boots and lower legs remain distinct and planted.
- F7: Same full-body man close to the initial outline. No specks, hard backdrop rectangle or anatomical changes are visible.

The neutral strip's single tile shows the same complete standing man, head to boot soles, with a compact coil by his lowered near hand. No obvious crop, missing leg or unwanted background rectangle is visible.

## Comparison, motion and scope

All eight numbered keys preserve the recognizable face/hair mass, mantle, cream sleeves, brown fitted vest, long divided coat, belt, bracers and tall boots of the supplied style-neutral reference. The standing strike also matches the approved strike reference's anatomy and costume. All face right and contain complete bodies. Standing and walking approach the blue height guide; crouches reach the yellow line through folded hips and knees, preserving head scale. The reclining figure keeps long legs and a normally sized torso rather than compressing them. Pose-dependent overlaps explain the more compact silhouettes.

Direct individual inspection included every key PNG, specifically key_2.png and key_7.png as requested. The walking key retains a readable near fist and compact coil. The standing strike has an explicit handle emerging from the closed fist; it is a usable socket reference. The windup and crouching strike likewise have plausible hand/handle contacts. Full rope continuity, taper, reach, timing and attack composites remain unreviewed because these layers/clips were not supplied.

The idle onion was inspected for all eight pairs: F0→F1, F1→F2, F2→F3, F3→F4, F4→F5, F5→F6, F6→F7 and F7→F0. Each shows a very small coherent upper-body displacement, with stable feet, intact costume and no teleporting limbs. The seam is as small as the internal steps. At the supplied 125 ms spacing the sequence is consistent with restrained breathing; this is a still-strip/onion assessment, not a claim of viewing an engine playback capture.

The declared scripted fallback translates the rigid head by at most two pixels and eases through the chest to fixed hips. That matches the visible result and reads as a subtle standing idle. Independent hair/coat motion is minimal; retain the scripted-fallback quality-debt disclosure under §11. No additional correction is necessary for the supplied idle's anatomy or continuity.

The supplied measurements are consistent with the visible size comparison: neutral 224 px, walk 222 px, crouch and crouching strike 142 px. Head width is 39 px neutral, 40 px walk and 38 px crouch, consistent with bending without shrinking. Windup's top-band width is arm-contaminated and is not a literal head measurement. The impact and airborne outlines shorten because of pose, not apparent whole-character scale loss.

## Per-key visual findings

These results concern isolated anatomy/identity/scale/grip references only; they do not approve animations derived from them.

| Key | Intended reference | Visual result | Failing frames | Smallest correction | Usable as derivation reference visually |
|---|---|---|---|---|---|
| 1 | Neutral | PASS | — | None | Yes |
| 2 | Walking contact | PASS | — | None | Yes |
| 3 | Deep crouch | PASS | — | None | Yes |
| 4 | Airborne rise | PASS | — | None | Yes |
| 5 | Knocked down on hip | PASS | — | None | Yes |
| 6 | Attack windup | PASS | — | None | Yes, body/grip only |
| 7 | Extended standing strike | PASS | — | None | Yes, body/grip only |
| 8 | Extended crouching strike | PASS | — | None | Yes, body/grip only |

## Supplied clip visual findings

| Clip | Visual result | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| style_hero_neutral | PASS | — | Complete right-facing neutral reference, consistent identity and scale | None |
| hero_idle | PASS | — | Eight consistent full-body poses; slight breathing displacement, planted feet and smooth onion seam | None; disclose scripted-fallback quality debt |

Audit adjudication: audit.md and audit.json contain zero DEFECT and zero FLAG; there are no accepted flags. Edge-cleanup metadata reports removal only of alpha ≤3 pixels in keys 2 and 7, without changing measured ink or silhouette. The lineups show no visible isolated specks or hard background rectangles. No attack composite or effect strip was supplied within this checkpoint.

Opened style-lock references: art/frames/style_hero_neutral/f000.png, art/candidates/style_hero_attack_key.png, art/candidates/style_enemy_pursuer.png, art/candidates/style_terrain_patch_3x3.png, art/review-style-v3/style_env_mockup.png. The hunter art remains consistent with the supplied reference treatment. The other reference images provide style context, not renewed approval of their assets.

## Protocol limitation and gate disposition

This review read the allowed general contract, bible and machine contract before opening the images. The numbered descriptions were recorded before reading pack scope, measurements, derivation metadata or audits, but the machine contract had already exposed general clip intents. That differs from the strict ART_REVIEW step order. Consequently the visual PASS findings above are advisory and this file must not be used as the final independent acceptance gate. The smallest procedural correction is a fresh independent reviewer that opens and records all lineup/strip descriptions before reading the contract or any intent-bearing document. No artwork correction is identified by this inspection.

The 62 absent production clips, unfinished whip layers and engine playback/phone captures remain unapproved; this checkpoint cannot approve full production or release.

REVIEW: FAIL (0 visual clips; protocol ordering requires fresh review)
