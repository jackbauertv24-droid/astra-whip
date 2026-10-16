# Independent scoped visual review: boss idle r01

Scope: `boss_idle`, with `boss_walk` as the identity, support and outgoing-action reference. This is not release-wide approval. Reviewer did not create these assets and made no art or code edits. Only review records were written.

Protocol: opened only lineup_boss.png, strip_boss_idle.png and strip_boss_walk.png first. Saved per-tile plain observations to blind_observations.md and read that saved file before contracts, intents, audit or derivations. Subsequently read ART_CONTRACT, ART_BIBLE, the boss ASSET_BRIEFS section, machine contract, scoped audit JSON/Markdown, scoped clip/derivation records and both preparation scripts. No previous reviewer verdict file or builder notes were opened. The pack index contains unrelated derivation inventory; that inventory is not evidence for this scoped decision.

Inspected both complete native eight-frame sets, both onion sheets including F7→F0, lineup, strips, identity construction key, and all five actual reference images registered by art/style-lock.json: hero neutral, attack key, pursuer, terrain patch and environment mockup. Native frames were explicitly alpha-composited onto opaque gray using the PNG alpha channel, with original source pixel density retained in cropped sheets. Low-alpha RGB was never treated as opaque paint. Inspected all 20 current PNGs in each of evidence/boss-idle-native and evidence/boss-idle-phone: both facings' F00–F07, both wrap F00 captures and both after-walk captures. Runtime boss regions were examined at their original pixel resolution, with full scene views also checked for display scale and ground context. Read both capture.json files.

## boss_idle — PASS

Identity and anatomy: F0–F7 retain the crowned concealed helmet, heavy layered shoulder plates, narrow shrouded torso, two connected plated legs and two boots, smaller rear fist and oversized forward striking gauntlet. No torso-only substitution, limb loss, costume replacement, head-size change or isolated hovering hand is visible. Right-facing source and mirrored left-facing runtime figure agree. The construction key and walk F0 carry the same identity; the idle does not introduce a size jump.

Support: both boots remain planted on the same ground line across all idle frames and both facings. Pelvis and lower legs sustain the stance as the upper torso moves. There is no walking-in-place foot slide, progressive translation, heel lift, or cloth masquerading as a missing leg. Runtime records keep position [6240,560] for every idle sample. The full figure remains visibly grounded at native and phone capture scales.

Motion: F0→F4 slowly raises the upper body by approximately two source pixels; F4→F0 releases it. The helmet retains its shape and follows the chest rather than scaling. The shroud's tiny lateral response stays attached through the belt/hip region. Inspecting every adjacent pair and wrap shows no cloth teleport, duplicated armor edge, detached fragment or visible neck/waist cut. The F7→F0 change is comparable to neighboring changes. Motion is deliberately restrained, especially at phone scale; this reads as a heavy waiting warden with quiet breathing, not a separate attack tell. Scripted local deformation remains quality debt under §11, but the delivered result reads as the intended stationary action.

Size and materials: scoped audit reports zero DEFECT and zero FLAG, so no flagged exception needs waiver. Idle heights are 352–354 source pixels against design 352; foot line is 512 throughout; head width is 53 throughout. Size S is 202.598–204.110 against reference 197.384, inside the standing band. Inspection agrees with those measurements: no swelling or shrinking plate mass. Muted olive cloth, corroded slate iron, worn pale edges and concealed face fit the five style references and the warden brief. There is no bright decorative ember, gore, baked ground plane or opaque rectangle. Background contrast is modest around cloth and the tree, but crown, shoulders, gauntlet and separated boots remain identifiable in both phone facings.

Timing and runtime: contract and scoped manifest both specify eight 125 ms samples, looping, totaling 1000 ms. Both runtime capture records show F0 at elapsed 0, F1 at approximately .1333, F2 .2583, F3 .375, F4 .500, F5 .625, F6 .7583, F7 .8833, and wrapped F0 at 1.0083 seconds. This is consistent with the actual one-second idle cycle sampled on renderer ticks. Both wrap images visually return to the initial support and identity without a position reset. Recorded production HP is 8; idle captures explicitly hold the arena inactive.

Handoff: activation records the outgoing state as walk for both facings. Both after-walk PNGs retain the same scale, feet-to-ground registration, torso and costume. Idle F0 equals the walk neutral pose visually, and the relaxed end of the idle returns toward that pose, making the supplied outgoing stills consistent with a coherent handoff. No visible size pop or ground jump appears between supplied idle and outgoing poses.

## boss_walk — PASS as scoped reference

All eight source frames and their adjacent/wrap overlays retain the same crowned armored body. Two articulated legs alternately pass beneath the shroud, with one boot maintaining ground support while the other rises and advances. Shoulder/helmet shape and oversized gauntlet stay consistent; cloth masks the hips without replacing the legs. Heights 348–352, head width 53 and foot line 512 are consistent with the identity and contract. No new blocking visual defect is apparent in this reference set. This judgment covers the reference's identity, continuity and idle-to-walk compatibility, not a fresh measured locomotion-speed or whole-encounter acceptance.

## Limitations and nonblocking evidence issues

The supplied runtime evidence is a sequence of still samples with timestamps, not a viewed continuous video or newly executed interactive playback. The temporal judgment combines ordered native frames/onions, declared durations and sampled runtime chronology; it does not certify sub-frame renderer behavior. The two outgoing stills establish arrival in walk, not every instant of the transition or every possible idle-phase interruption. No attack, turn, hurt, hazard or death is approved here.

Both capture manifests explicitly say physical_device=false. Native PNGs are 1280×720. Phone PNGs are actually 698×393, whereas capture.json reports viewport (852,393). Therefore these images establish readability at the delivered 698×393 emulated image size, not physical-device behavior or a verified 852-pixel output width. This metadata mismatch does not reveal a sprite defect but should be corrected or explained in the capture harness before claiming that specific output resolution.

No blocking finding in the reviewed boss_idle clip or its scoped walk reference.

REVIEW: PASS
