# Independent review — whip impact r01

Reviewer: /root/whip_impact_review_r01, 2026-10-20. Acceptance scope: `vfx_whip_impact` only. Existing actors, whip, effigy and scenery are context.

| Clip | Result | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| vfx_whip_impact | PASS | None | None found | None required |

## Blind review and coverage

Opened `lineup_vfx.png`, then `strip_vfx_whip_impact.png`; saved per-tile observations in `blind_observations.md` and read that saved file before reading scope, index, audit, intent or contracts. The pink/mint marks noted in the blind pass are preview registration crosses; the unmarked raw art is bone/old-bone colored.

Inspected all six native 192×192 raw frames `frames/vfx_whip_impact/f000.png` through `f005.png`, and every pair on `onion_vfx_whip_impact.png`: 0→1, 1→2, 2→3, 3→4, 4→5. Read the review protocol, art contract including allowed derivations, art bible, scoped review contract, index/derivation listing, scope and both audit files. The generated-sheet registration reads as a contact burst rather than a transformed actor action; no reversal/fallback action ambiguity applies.

Opened all five style-lock images: `art/frames/style_hero_neutral/f000.png`, `art/candidates/style_hero_attack_key.png`, `art/candidates/style_enemy_pursuer.png`, `art/candidates/style_terrain_patch_3x3.png`, and the explicitly authorized image `art/review-style-v3/style_env_mockup.png`. No previous verdict was read.

Read both capture manifests. Decoded every referenced actual PNG and inspected its contact neighborhood at unchanged pixel scale, using `native-0.png`…`native-9.png` and `phone-0.png`…`phone-9.png`. Each tile is a direct 220×200 crop from its actual sample, with no resizing; the before/expiry tiles use the same contact crop center as the active phases. `inspection_inventory.json` enumerates all 176 actual sample paths (88 native + 88 phone). Full screenshots additionally opened for native right-air peak, phone reduced left-ground, and phone right-effigy peak to check wider context. No required sample was missing or unreadable.

| Fixture, both capture resolutions | Right | Left | Inspected samples per facing per resolution |
|---|---|---|---|
| Boss ground contact | PASS | PASS | before, F0–F5, reduced F2, paused F3, expiry (10) |
| Boss crouch contact | PASS | PASS | before, F0–F5, paused F3, expiry (9) |
| Boss air contact | PASS | PASS | before, F0–F5, paused F3, expiry (9) |
| Circular grazing swooper contact | PASS | PASS | before, F0–F5, expiry (8) |
| Effigy destruction contact | PASS | PASS | before, F0–F5, expiry (8) |

These are ten fixtures at each resolution, including all supplied pause/reduced variants. They are controller captures, not physical-device or full traversal evidence; this verdict does not extend beyond the supplied scope.

## Findings

**Anchor and continuity:** The same central strike point persists through all five onion pairs. Rays spread from a compact central glint, with the upward diagonal ray retaining a coherent direction through expansion/contraction. Different flecks are a sparse burst, not target-sized debris. Independent alpha≥40 bounds give centers (96,96.5), (96,96.5), (96.5,96), (96,96), (96.5,96), (96.5,96), within 0.5 px of the declared anchor. Contact positions stay fixed in the captures, including air samples as the hunter moves away. Ground, crouch and air bursts occur at their respective target heights; mirrored contacts stay on the appropriate side.

**Growth and fade:** Larger ink dimensions are 30,64,128,91,51,33 px: one peak at F2, below the 180 px limit. F0→F1→F2 reads as one quick expansion, then F3→F4→F5 contracts and loses prominence. F5 has only a dim remnant at actual scale; disappearance does not leave a visibly abrupt large patch. The 40/40/40/50/50/60 ms contract totals 280 ms. Manifest samples show phases at ages 0, 41.7, 83.3, 125, 175 and 225 ms; expiry at 283.3 ms has zero bursts, and the images show no remaining impact. This is consistent with frame-quantized playback of the declared timing.

**Palette and style:** Raw frames use restrained cream/bone highlights and muted brown flecks, consistent with the worn materials and bone highlights of the five approved references. There is no phosphor projectile color, candy-colored magic aura, sustained energy whip or gore. The bright material occupies a small contact patch briefly; thin uneven painted rays fit the illustration treatment. Preview crosses are not baked into source or actual-contact captures.

**Actual-contact readability:** F1–F3 provide a distinct local hit glint on the boss's armor, on the grazing target and at the removed effigy's former position. At phone size F0/F5 are intentionally faint bookends; F2 supplies the clear event peak. It remains locally distinguishable against both dark architecture and target material. Swooper pose change/death and effigy disappearance do not relocate the burst. The sparse rays never cover enough of a target to hide its identity or silhouette. Crouch bursts remain above the walkable edge; air bursts do not spill a fog sheet over the landing surface. Effigy hits near the platform end leave its top edge and gap readable.

**Reduced effects and pause:** Both reduced ground peaks remain a small identifiable bone glint on actual contact at native and phone sizes, with lower prominence and no large masking flare. Every supplied boss pause image retains the same F3 burst shape/location as its adjacent unpaused F3 image; the recorded effect age and attack time remain at 125 ms/275 ms. This supports the supplied frozen-clock evidence, without claiming a still image independently measures elapsed pause duration.

**Edges and extraction:** Raw frames and actual captures show no rectangular matte, cut-off ray, colored key fringe or border residue. Independent scan found zero alpha on the two-pixel border ring and zero visible exact magenta key pixels in all six frames. Low-alpha painted scatter seen against black is part of the localized effect; it does not become a rectangle in the real backgrounds.

## Audit adjudication

`audit.md` and `audit.json` report 0 DEFECT, 0 FLAG, with an empty findings list. There are no individual findings to waive. Visual inspection and the separate anchor/extent/border checks agree with that scoped result. No failures or required corrections were found.

REVIEW: PASS
