# Independent acceptance review — air attack r01

Reviewer: /root/air_attack_review_r01. Scope is exclusively `hero_attack_air`, `whip_attack_air`, and `style_hero_neutral`. I did not generate, process, or audit these frames. I first opened every lineup and strip and saved `blind_observations.md` before reading the contract, audit, index, or metadata. No prior verdict or builder notes were consulted.

| Clip | Verdict | Failing frames | Finding | Smallest required correction |
|---|---|---|---|---|
| hero_attack_air | PASS | None | Full adult body and consistent hunter identity throughout; same near arm carries the weapon from hip to backswing, extension, recoil, and gather. Airborne bent legs and trailing coat adjust coherently. | None |
| whip_attack_air | PASS | None | Continuous tapered leather line meets the glove in every composite frame; compact rest coils, complete active reach, and ordered recovery loops. | None |
| style_hero_neutral | PASS | None | Full head-to-boot figure, adult proportions, consistent approved face/hair/costume and standing height; right facing. | None |

## Evidence inspected

All 17 native snapshot PNGs were opened individually: hero F0–F7, whip F0–F7, and neutral F0. Also opened lineup_hero, all three strips, both onion sheets, the eight-frame composite, airborne-reference.png and weapon-arm-reference.png. Read prompts/ART_REVIEW.md, docs/ART_CONTRACT.md, docs/ART_BIBLE.md, docs/ANIMATION_SPEC.md, art/style-lock.json, contract/art_contract.json, pack index, both audits, sockets, occlusion metadata and derivations. Opened all five registered style references: neutral, attack key, pursuer, terrain patch and environment mockup. Those references were used for consistency, not reapproved as new production work.

Opened every right-F0–F7 and left-F0–F7 image in both evidence/air-attack-engine-r01 and evidence/air-attack-phone-r01: 32 real-jump captures, plus both capture.json records. Also opened both landing PNGs and evidence/air-landing-engine/capture.json. All required files were present and readable.

## Identity, anatomy, and motion

Neutral and attack show the same long-haired adult hunter, pale sleeves, dark bracers, layered brown leather coat and boots. The airborne silhouette is lower through knee/hip folding, with neither missing lower body nor uniform shrinking. Both legs remain distinguishable through the coat; the boots retain their volume. All source images face right. Mirrored engine captures preserve the same articulated silhouette and hand registration. No clipping, rectangle, detached debris, key-color halo, or anatomical collapse was visible.

All adjacent pairs were judged at the declared sequence timing of 75/75/50/50/62.5/62.5/62.5/62.5 ms (500 ms total):

| Pair | Body and weapon assessment |
|---|---|
| F0→F1 | Hip-held weapon arm rises into backswing while the other hand gathers at torso; coil releases behind the raised fist. Knee tuck and cape remain spatially coherent. |
| F1→F2 | The largest arm/weapon displacement is the deliberate fast strike: same near shoulder and sleeve extend forward, other hand stays at waist. It reads as an attack snap at 75 ms rather than an arm swap. Whip unfolds from rear arc into forward reach. |
| F2→F3 | Controlled extension hold with slight wrist, coat and leg adjustment; lash wave travels subtly downward. No size or identity jump. |
| F3→F4 | Clear recoil from extension to low forward hand, with the forward lash rolling into an open recovery loop. This large move is appropriate immediately after the 50 ms active key; body remains intact. |
| F4→F5 | Near fist stays low, free arm opens for balance, and the loop contracts toward the body. Cloth and knees stay airborne rather than becoming a standing lower body. |
| F5→F6 | Weapon fist draws back to hip as the loop tightens; free arm and coat settle toward ready. No disconnection or arm ownership change. |
| F6→F7 | Small final adjustment into the ready tuck; compact gathered lash returns to the F0 shape. |

The lower body is intentionally a restrained airborne tuck, but it is not an entirely frozen sliding cutout: knee/boot angles, overlap, and trailing coat contour adjust around the stronger upper-body attack. The seven distinct painted keys plus reused final ready key read as a complete airborne attack. The weapon-arm reference confirms the near-arm extension rather than requiring a switch to the opposite hand.

## Grip and whip

The cyan-cross composites show the grip seated beneath the glove in all eight frames, including the low hip phases where the coat naturally occludes the coil. There is no floating weapon beside an empty hand. F1's root exits behind the raised fist and F2–F3's root exits ahead of the closed fist. The active lash spans the yellow hitbox and reaches beyond its far edge; its open S curve reads as flexible leather, without glow or a rigid rod. F4's broad recovery loop contracts through F5, F6 and F7 rather than disappearing. F0/F7 coils are small relative to the adult figure. Root and tip visibly taper.

The regular audit has 0 DEFECT and 0 FLAG. The supplemental strict audit also has 0 DEFECT and 0 FLAG using documented 10 px root / 4 px tip limits. The machine contract's separate 12 px / 5 px values were not silently amended. There are no FLAG findings requiring acceptance. The strict audit's contact distances are zero for every weapon frame; active endpoints x600 and x610 exceed pivot256 +336. Its reported socket-to-tip distances increase 54.571→154.780→279.460→289.126 then decrease 204.247→116.730→67.268→54.571, matching the visually observed unfolding and gathering.

The scoped derivations are explicit: body reuses painted airborne keys with a final ready reuse, and whip uses a labelled raster fallback. Both read as their intended action under §11. Other derived clips listed in the shared index and missing clips outside this three-clip snapshot are outside this acceptance scope.

## Engine and phone proof

Both facings show all eight synchronized body/weapon phases at desktop and actual phone size. The warm hunter silhouette remains legible against cold masonry; thin whip becomes finer at phone size but its active reach and recovery remain visible. Neither facing has a detached root or missing body part. The capture records show a real trajectory: upward velocity starts near −573.33, passes through −66.67, then becomes +26.67 and +133.33 while the strike clock advances normally. Every sample is airborne, active only on F2–F3, and mirrored socket error is 0 against tolerance 0.001.

The landing proof shows the active air strike selecting the existing grounded or crouched layer on contact. In each case combat time advances from 0.175 to 0.183333 seconds, remains on active frame2, and reports hit_id_preserved=true. The existing ground/crouch drawings are transition references and are outside this new art acceptance.

Before final acceptance I verified all three logs end in PASS:
- evidence/air-attack-capture-r01.log: eight synchronized attack frames in both facings.
- evidence/air-attack-phone-r01.log: eight synchronized attack frames in both facings.
- evidence/air-landing-engine.log: active landing preserves clock and hit-ID into ground/crouch layers.

REVIEW: PASS
