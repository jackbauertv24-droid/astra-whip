# Independent effect review — vfx_enemy_defeat r01

Reviewer: fresh independent agent `/root/enemy_defeat_review_r01`; review date 2026-10-20. Scope is this effect only. Existing actors, their death poses, and scenery are contextual evidence, not newly approved assets.

## Blind record and inspected material

Opened lineup_vfx.png, then strip_vfx_enemy_defeat.png. Saved per-tile observations to blind_observations.md and read that saved file before index, audit, scope, intent, contracts, or provenance. No previous verdict or builder notes were read. Inspected all eight individual raw frame PNGs, every onion pair (F0–F1 through F6–F7), and all five image paths in art/style-lock.json, including the authorized environment mockup.

Decoded and inspected all 192 actual sample PNGs: 96 native 1280×720 and 96 phone-layout 698×393 samples. inspection_coverage.json lists every file and unchanged-scale crop; inspection-native-0…7.png and inspection-phone-0…7.png retain the inspected contact crops. Each row is chronological in capture-manifest order. These cover pursuer, swooper, ranged and boss, both facings, before, F0–F7, reduced, paused and expired. Crops preserve the effect area and platform context; they do not rescale the actual captured pixels.

Final capture refresh: decoded all 192 final PNGs again; SHA-256 comparison found 11 changed native PNGs (left ranged F7 and left boss F0–F7, reduced, paused), which were visually reinspected in refreshed native sheets 6 and 7. All other PNGs matched the already inspected images. Coverage and inspection_hashes.json describe the final captures. Final death-state clocks place expiry at 566.67 ms in all 16 fixture/view combinations, just after the 560 ms clip duration, with burst_count=0.

## Per-clip verdict

| Clip | Result | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| vfx_enemy_defeat | PASS | None | None observed | None required |

## Visual findings

The effect is a dry, matte, gray-brown ash scatter with curling smoke-like wisps. It fits the restrained, painted decay treatment of the five style references; no blood, wounds, organs, severed pieces, luminous magic, pixel-art treatment, or hard rectangle appears. The loose chips are intentional ash satellites, not extraction debris.

F0–F1 establish small material near the center; F2 expands; F3 is the clear peak; F4–F7 progressively contract and thin. The seven onion pairs show curls evolving around the same center rather than a whole plume teleporting. Individual flakes rearrange as dispersed particles, which is acceptable for ash. F3–F4 changes the upper curl's lean, but the central plume remains connected in the same locality; it does not read as a registration jump. F7 is sparse enough that expiry is quiet rather than an abrupt removal of the peak.

At alpha≥40 the frame extents are 83, 118, 191, 239, 216, 181, 141, 91 px: one growth peak, then continuous contraction, under the 250 px maximum. Ink bounding-box centers are (128,128), (128.5,128), (128.5,128), (128,128), (128.5,128.5), (128.5,128), (128.5,128), (128,128). All are within the 4 px anchor allowance. All eight frames have zero nontransparent pixels in the 2 px border ring. The source contract and scoped review contract agree on 256×256, center (128,128), eight 70 ms frames, 560 ms total, and nonlooping playback.

Native and actual phone-layout crops show the burst reading most clearly around F2–F5. Its first and final flecks are intentionally quiet; this is acceptable beside the ongoing death action. Ash overlaps the dying enemy without replacing it with an opaque cloud. Pursuer remains legible beneath the plume; ranged's hood and robe remain readable; the falling swooper separates from its fixed death-origin plume; the larger boss remains the dominant silhouette, with subdued ash on its torso. Both left and right contexts preserve that behavior. The hunter stays visible, the platform's continuous top edge remains discernible through the sparse lower particles, and the effect introduces no tell-like bright shape or obstruction. These isolated fixtures do not demonstrate simultaneous neighboring attack tells.

Reduced variants visibly suppress the plume while retaining the death action. Paused variants retain the F4 plume and position of the matching normal sample; pause interface changes mean full-image equality is not expected. Every before/expired sample shows no lingering burst; manifests report zero bursts there and one during the effect. The capture evidence is an isolated actual-whip lethal fixture preserving production HP (1, 1, 2, 8), including sequential hit outcomes for ranged and boss. It is desktop/native and phone-layout rendering, explicitly not physical-device evidence.

## Derived clip and audit adjudication

The declared generated-sheet derivation reads as the intended ash-dissolution defeat action. Registration translations do not visibly distort or resize the plume. Character anatomy, facing-right source rules, crouch mechanics, and whip-grip composites do not apply to this effect-only asset.

The supplied audit.json and audit.md contain 0 DEFECT and 0 FLAG. There are no flagged frames to accept or reject. Independent inspection agrees with V-01, V-02 and V-03; V-04 is not applicable to this local world-space burst.

REVIEW: PASS
