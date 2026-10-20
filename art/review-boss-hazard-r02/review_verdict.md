# Independent ART_CONTRACT §9 review — boss hazard r02

Reviewer: fresh independent agent /root/boss_hazard_review_r02, 2026-10-19. Acceptance scope is the five mandatory hazard clips and supplemental boss_hurt_hazard_late; six other boss clips are support references. No earlier reviewer verdict, earlier blind observations, or builder conversation was read. Production files were not edited.

## Evidence and order

First opened lineup_boss.png and all twelve strip PNGs, including both effects. Saved blind_observations.md and read the saved file before opening intent, audit, contract or provenance. Then inspected all twelve onion sheets (including idle/walk loop seams), all 59 individual delivered frame PNGs, ART_REVIEW.md, docs/ART_CONTRACT.md, docs/ART_BIBLE.md, the pack contract/scope/index/audit, the original contract hazard entries and relevant ASSET_BRIEFS entries. All five references from art/style-lock.json were opened: hero neutral, hero attack key, pursuer, masonry patch and environment mockup. Also inspected boss identity key, registered generated hand key, both painted VFX source sheets and derivation records.

Both completed capture.json files were read. Each contains eight records: complete right and left cycles plus stooped, rising and hazard_late punish branches in each facing, 104 samples per resolution. Every sample was visually inspected in full-scene review-only sheets reviewer_native_*.png and reviewer_phone_*.png, assembled without cropping or scaling source images. Sheet tiles follow JSON sample order, row-major, six samples maximum per sheet; suffix is starting sample index. Selected original full captures were also opened directly. Native capture size is 1280×720; phone is 698×393. These are engine window captures, not physical-device evidence (physical_device:false).

## Per-clip verdict

| Clip | Verdict | Failing frames | Finding and smallest correction |
|---|---|---|---|
| boss_hazard_windup | PASS | — | F0–7 retain crown, hollow helmet, layered shoulder plates, ragged olive shroud, both plated legs and fixed soles. F1 lifts the fist, F2 opens fingers, F3–7 reach and hold. Wrist/cuff/forearm join remains attached. At phone size the forward arm visibly separates from the torso and differs from idle; no correction required. |
| boss_hazard_execute | PASS | — | F0–3 lower the open hand, turn the forearm downward, then close beside the knee as the supported torso stoops. Helmet retains its size and identity. Three adjacent onion pairs show an articulated downward progression without a detached hand or foot slide; no correction required. |
| boss_hazard_recover | PASS | — | F0–5 hold low then return to upright, with connected bent legs and planted soles rather than whole-body shrinking. Cloth sweeps slightly on F1–2. Final neutral joins walk F0 without a scale jump; no correction required. |
| vfx_hazard_telegraph | PASS | — | F0–3 sustain a complete broad cracked ember oval, brighten and develop small sparks. Footprint stays in place and is conspicuous against the cool masonry in both facings and at phone size. The dark mineral border supports rather than obscures the luminous boundary. No rectangle or displaced floor anchor; no correction required. |
| vfx_hazard_eruption | PASS | — | F0–5 retain the complete warning gutter while internal fire rises to F2 and subsides. The outer danger-zone extent remains visible throughout, including F4–5. Peak remains a low floor threat, visually far below the jumping hero. No sideways shift at warning→eruption or eruption phase changes; no correction required. |
| boss_hurt_hazard_late | PASS | — | F0–2 release a partial stoop toward exact upright neutral. Native and phone punish_hazard_late branches in both facings preserve head, foot and arm attachment before the hit, during the short interruption and on return to recover/walk. No premature upright pop; no correction required. |
| boss_idle (support) | PASS | — | Full body and stable head; restrained breath/shroud motion with clean F7→F0 seam. Support finding only; no correction required. |
| boss_walk (support) | PASS | — | Alternating articulated plated legs remain attached under the shroud. Narrow overlapping feet at F4–5 are readable as passing legs; F7→F0 continues the gait. Support finding only; no correction required. |
| boss_hurt (support) | PASS | — | Small brief recoil preserves neutral identity, scale and soles. Support finding only; no correction required. |
| boss_hurt_stooped (support) | PASS | — | Keeps low supported posture during early punish interruption; shown returning into continuing recovery in both facings. Support finding only; no correction required. |
| boss_hurt_rising (support) | PASS | — | Partial rise continues across the short interruption without substituting an unrelated upright pose. Both runtime punish_rising branches retain support. Support finding only; no correction required. |
| boss_hurt_half_stoop (support) | PASS | — | Half-stoop releases toward neutral across F0–2, retaining original head and plated lower body. Support finding only; no correction required. |

## Motion, signaling and seams

Source sprites face right; engine mirrors preserve plausible form lighting and the same identity. The boss is a complete oversized armored revenant in every frame, consistent with the painterly corroded materials and restrained decay treatment of the five style references. No torso-only substitutions, enlarged helmet, shortened legs, clipping, opaque cutout rectangle or distracting loose fragments were found.

Windup F7→execute F0 is the same held reach; execute F3→recover F0 is the same low closed-gauntlet posture. Recover F5→walk F0 returns to neutral without a misplaced boot. The strongest motion is the arm; the body is intentionally restrained and the several held windup frames are close to duplicates. This reads as a sustained cast, although the scripted articulation has less organic shoulder/cloth follow-through than fully painted animation. That is visible quality debt, not a continuity or signaling failure.

In cycle-right/left-hazard_windup-f00-fx00.png through f07-fx03.png the ring is already readable at first warning and remains visible for the full tell. The arm reach is a distinct additional silhouette event. The matching execute samples cover every body/effect combination captured, including the F1/FX2 peak and late F3/FX5 gutter. The ring is the only bright warm floor signal in the shown stage area; hunter clothing is warmer than scenery but does not resemble the floor marker. Eruption F0 starts from the warning's full-width gutter, fire grows inside it, and the gutter persists until the end of the damaging phase. The disappearance on recovery communicates the end of danger. Phone samples retain the oval as a clear roughly boot-level signal; sparks and fingers lose detail at this scale, while zone boundaries, arm reach and stoop remain legible. The stage does not occlude the tell.

All six punish branches per resolution were inspected through their before/hit/continuation samples. The stooped branch retains the low posture, rising retains its intermediate posture, and hazard_late releases toward neutral on the shorter remaining recovery. No handoff produces a different head, suddenly straightened legs, floating soles or detached gauntlet. This supports synchronization visually; it is not a claim of physical-phone or unrestricted gameplay testing.

## Provenance and automated flags

Audit reports 0 DEFECT and 0 FLAG; there are no FLAG adjudications to accept. These numbers did not determine the visual verdict. The generated registered full-body key differs in stance from delivered art, and the derivation explicitly extracts its hand while retaining the existing supported body. Inspection of delivered F2–7 windup and F0–2 execute confirms the resulting open palm belongs to the same gauntlet rather than floating beside it. The declared local rig and fixed soles explain the restrained body motion; scripted fallback debt remains disclosed. The VFX use painted sheets with shared bounded uniform normalization and base registration; reuse of the final warning gutter in eruption is visible and successfully preserves the zone boundary. No hidden global actor rescale or unacknowledged replacement character was visually apparent.

No blocking visual defect found in the requested acceptance scope.

REVIEW: PASS
