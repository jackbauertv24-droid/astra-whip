# Independent ranged action review r04

Reviewer: fresh agent /root/ranged_aim_review_r04, 2026-10-15. No art generated or edited. Scope is the two clips present in this pack, with outgoing fire and projectile graphics excluded from approval.

Blind observations were written to blind_observations_r04.md and their existence verified before reading intent, manifests, audit or contracts. The lineup and both strips were the only images viewed before that file was saved. No prior reviewer verdicts, blind files or builder history were opened.

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| ranged_idle | PASS | none | Whole hooded figure, funerary post and rooted base stay coherent; subtle chest/arm/cloth activity is visible with a quiet loop seam. | None required. |
| ranged_aim | PASS | none | One connected arm raises through six poses while its green angular charge becomes a clear diamond; hood/post/root registration and painted identity survive. Both runtime facings remain legible. | None required. |

## Identity, anatomy, registration and motion

All twelve individual native PNGs were opened, in addition to the lineup, strips and both onion sheets. The complete robe/root base reaches the ground line and the hood reaches the design-height line. This actor explicitly has no exposed legs; its ground-reaching cloth and roots are intentional, not a torso substituted for a full body. Source faces right; runtime left is a plausible mirror. Neither crouch nor whip rules apply to these clips.

The hood conceals the face, one pale arm emerges under its shoulder, and the stone post remains behind the robe. No duplicate hanging hand, disconnected forearm, missing body, rectangular matte, warm fragment or obvious cut edge appears in the delivered frames. The angular pale/green tips near the early charge are small effect wisps and fingers, not a second arm. At F1/F2 the wisps are less orderly than the final diamond, but stay near the moving hand and read as gathering charge rather than body debris.

Idle adjacent pairs F0→1,1→2,2→3,3→4,4→5 and seam F5→0 show small local breathing/sway without rooted-base sliding or silhouette scaling. Aim F0→1→2→3→4 lifts the same forearm in short connected steps; F4→5 holds the arm and completes the diamond growth. No pair shows limb teleportation or a body-size jump. The elbow contour is slightly soft under the local articulation but remains a believable connected bend at native size.

The idle-to-aim entry changes the elbow and wrist from a relaxed hang to a modestly bent charge pose; the hand stays near its prior low position and the whole body remains registered. This reads as the start of the same arm's deliberate raise. Runtime before-idle and F0 captures support the handoff in both facings. The tiny early halo is intentionally weak; by F3–F5 its outward extension and diamond shape provide a strong non-color-only tell. The final arm is forward/downward rather than mathematically horizontal; its muzzle is in the specified firing-height band, and the intended aiming action reads clearly.

## Style and sources

Opened all five registered art/style-lock.json images: neutral hero, attack key, pursuer, masonry patch and environment mockup. Also opened ranged-identity-r02/key.png and ranged-aim-key-r05/key.png. The new action retains the identity source's thin hooded silhouette, mossy drapery, pallid flesh, matte painted edges and funerary stone construction. The phosphor green is restricted to the distinct charge shape; no gore, whimsical treatment or material/style substitution is evident. Production captures confirm separation against the actual dark masonry.

## Runtime evidence and socket

Opened every PNG in evidence/ranged-aim-native and evidence/ranged-aim-phone: 16 captures per directory, 32 total, covering before-idle, F0–F5 and outgoing fire F0 for right and left. Both capture.json files were read. At native and phone viewport sizes the rooted silhouette and rising arm remain readable. Phone fingers and earliest halo lose fine detail, but the later diamond and extended arm still identify the warning. The phone output is an emulated viewport, not a physical-device run; both JSON files explicitly report physical_device:false.

Both records hold the actor root at (4608,432) throughout aim and report no projectile before fire. Source muzzle (208,155), relative to pivot (128,320), at 2 source px/u yields (+40,-82.5) u. Thus expected right birth is (4648,349.5) and left birth is (4568,349.5), exactly matching the recorded births in both capture sets. These lie at the final diamond/hand lane and within the brief's y−70..−95 band. Recorded fire elapsed0.05/frame1 matches the specified birth event. Aim elapsed duration0.908333 is one simulation tick beyond nominal900ms and does not indicate an art timing defect. The six samples follow150ms source frames (last sample0.758333).

The outgoing fire F0 captures visibly use a flat green placeholder. That is observed, not approved: this review does not grant approval to ranged_fire, ranged_recover, projectile_grave_shot or the remainder of the actor's coverage. Birth coordinates establish alignment only, not projectile-art quality.

## Derivation and audit disposition

Read tools/prepare-ranged-aim.mjs and ranged-aim-r03/derivation.json, along with the current pack index and ranged clip manifests. The disclosed D23 scripted fallback uses the idle painting outside a local arm corridor, an elbow-rooted articulation (55,40,25,12,0,0 degrees), a foreground forearm layer, and separate effect growth (0.25,0.4,0.55,0.7,0.85,1). These changes correspond to the visible action. There is no whole-actor rescale or per-frame recentering in that script; local effect growth is an intended tell, not body normalization. The foreground layer does not produce a visible extra arm. Both clips read as their declared actions, satisfying the separate visual requirement for derived clips. Scripted animation remains disclosed release quality debt under D23.

Current audit.md and audit.json report0 DEFECT,0 FLAG across these two clips; findings is empty. There are therefore no flagged frames to accept or reject. The index's other missing clips are outside this deliberately limited pack and remain unreviewed, not silently accepted.

Limitations: this is frame/onion and timed-runtime-still review, not a newly recorded continuous video or physical phone session. Source approval claims in the derivation were not substituted for independent visual inspection; prior verdict files were deliberately not read. Scope is limited to the twelve delivered idle/aim frames and the demonstrated incoming handoff/socket alignment. All required images and evidence in that scope opened successfully.

REVIEW: PASS
