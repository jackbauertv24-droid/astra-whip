# Independent art review — projectile grave shot r01

Reviewer: independent fresh agent `/root/projectile_grave_shot_review_r01`, 2026-10-16. No art was generated, processed, or changed by this reviewer. The first opened asset was the clip strip; the two-sentence observations for each of its three tiles were written to and read back from `blind_observations.md` before intent, contract, index, or audit inspection. This effect-only pack has no actor lineup.

| Clip | Verdict | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| `projectile_grave_shot` | PASS | None | None found in the three delivered frames or the current native/phone evidence | None required |

## Shape, style, and frame inspection

Opened all three native 64×64 frame PNGs in the pack, the original 192×64 production sheet, and the full strip. Each frame is an open four-point diamond with long vertical points, shorter lateral points, green painted wisps and pale highlights around a transparent center. F1 has a wider outward curl and thicker/brighter edge; F0 and F2 are quieter. The core remains visibly hollow rather than becoming a filled ball or bullet. There is no body, hand fragment, guide cross, magenta/cyan residue, box backing, clipped tip, or independent stray spark in the delivered cells.

Opened all five registered style-lock references: `art/frames/style_hero_neutral/f000.png`, `art/candidates/style_hero_attack_key.png`, `art/candidates/style_enemy_pursuer.png`, `art/candidates/style_terrain_patch_3x3.png`, and `art/review-style-v3/style_env_mockup.png`. The effect's softly painted green and pale bone highlights fit the muted painted figures and violet/slate/teal masonry; its high value is appropriately reserved for a threat. The restrained fringe does not create a bloom disc. Opened `art/frames/ranged_aim/f005.png` and `art/frames/ranged_fire/f001.png`: the outgoing diamond repeats the charge's pointed open silhouette and phosphor palette. The flight drawing has a more textured curling fringe, but it reads as the released form of the same spell.

Also viewed a temporary native-resolution contact sheet correctly composited by straight-alpha source-over onto slate, plus a luminance-only version on neutral grey. The hollow center and all four points remain visible without relying on hue. No black transparency backing was treated as painted content.

## Motion, canvas, and provenance

Opened the onion sheet and examined all pairs: F0→F1 expands the curling fringe about the same center, F1→F2 contracts it, and F2→F0 closes with closely matching points and footprint. No pair changes into a different object or jumps its anchor. The 80/80/80 ms repeating pulse is coherent; this is a steady flight loop, so a one-shot grow/peak/fade curve is inapplicable. The last-to-first seam has substantially less change than either pair surrounding the bright middle phase.

Contract values are 64×64, center anchor (32,32), three 80 ms frames, loop true, maximum extent 60 px. Independent inspection of the delivered PNGs measured ink bounds at alpha≥40 of F0 (6,6)–(56,56), F1 (5,2)–(58,57), and F2 (6,7)–(56,55): extents 51,56,51 px. Bounding centers are (31,31), (31.5,29.5), and (31,31), within the four-pixel center tolerance. All pixels in the two-pixel border ring have zero alpha. The asymmetrical wisps of F1 do not visibly shift its central aperture.

Read `tools/prepare-projectile-grave-shot.mjs`, `art/prompts/projectile-grave-shot.json`, and the sheet provenance. The generated source records a 2172×724 to 192×64 uniform area-filtered premultiplied-alpha resolution conversion, followed by equal 64×64 crops and removal only of alpha≤4 pixels; no corrective per-frame scale or translation is recorded. The prompt includes the guide and approved charge reference and specifies the three distinct painted phases. This is generated sheet art rather than a declared articulated/reversed animation. No source or production art edits were made during review.

## Current engine evidence — all 40 PNGs opened

Both `evidence/projectile-grave-shot-native/capture.json` and `evidence/projectile-grave-shot-phone/capture.json` were read. Every following filename was individually opened in BOTH directories (20 in each):

- Right: `before-aim-right.png`, `flight-right-0000-f0.png`, `flight-right-0080-f1.png`, `flight-right-0160-f2.png`, `flight-right-0240-f0.png`, `flight-right-0900-f2.png`, `flight-right-2275-f1.png`, `expired-right.png`, `crouch-clear-right.png`, `standing-hit-right.png`.
- Left: `before-aim-left.png`, `flight-left-0000-f0.png`, `flight-left-0080-f1.png`, `flight-left-0160-f2.png`, `flight-left-0240-f0.png`, `flight-left-0900-f2.png`, `flight-left-2275-f1.png`, `expired-left.png`, `crouch-clear-left.png`, `standing-hit-left.png`.

At native and actual phone capture size, both before-aim views show the diamond at the aiming hand; birth stays at that socket, and the 80/160/240 ms views show clean outward separation and the phase0/1/2/0 sequence. The hand's reduced release cue does not leave a second free projectile. The four-point open spark stays distinct at phone size against both bright teal distance and dark masonry, including the late-flight samples close to each screen edge. Fine wisps compress at phone size, but the pointed silhouette and dark aperture survive; no circular blob or rectangular halo appears. Left mirroring maintains the same shape, hand connection, lane height, and contrast as right.

The 900 ms and 2275 ms samples in each direction retain the same horizontal lane and recognisable diamond. Expired views have no residual projectile. The JSON records constant y=349.5, approximately 280 u/s, late distances about 637 u, and removal at 640 u. Right and left flight have matching phase ages. In both same-platform crouch fixtures the bent hunter lies below the shot and the visible shot continues beyond him; health remains 5 and one shot remains. In both standing fixtures the shot has disappeared at the upper-body lane and the hunter enters hurt_recoil with health4; the fixture records no horizontal displacement. The standing image catches the immediate recoil entry, so the JSON supplies the health/state distinction that a single still cannot prove by itself.

Inspected `game/tests/capture_projectile_grave_shot.gd`: free flight is born through the ranged foe's real fire-frame1 event and advanced by `World.step` at 1/120 s. Subsequent AI cycles are isolated once the actor returns to idle. Collision fixtures put the hunter on the firer's platform and use the real fire event, then step the world. These are meaningful socket/flight/clearance fixtures rather than arbitrary pasted placements.

## Flags and limitations

Audit reports 0 DEFECT and 0 FLAG; there are no flags to waive. The index lists other repository clips as missing because this pack intentionally contains only `projectile_grave_shot`; those other clips and their listed derivations are outside this clip verdict.

This review accepts the provided raster engine captures and fixture source, not an independently replayed engine session or physical handset run. Both JSON files explicitly report `physical_device:false`; native viewport is 1280×720 and phone viewport is 852×393 with the game content fitted inside it. Still sequences and onions establish phase continuity but do not measure subjective motion perception during live play. Flight fixtures place the normal target below the elevated firing platform to preserve long-distance visibility; the separate same-platform fixtures establish crouch clearance and standing consumption. A flat grey terrain/debug-looking vertical patch elsewhere in the left-facing scene is outside the projectile and does not track its canvas; it is not projectile alpha residue. No approval is extended to unrelated scene art.

REVIEW: PASS
