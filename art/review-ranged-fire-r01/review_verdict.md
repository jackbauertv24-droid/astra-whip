# Independent ranged fire review r02

Blind descriptions were saved and read back in blind_observations_r02.md before reading intent, index, audit or contracts. No prior reviewer verdicts or builder/rejection histories were opened. The derivation's required source/reason fields were read as provenance, not accepted as a verdict.

| Clip | Result | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| ranged_idle | PASS | — | Complete rooted robe/post/base identity, single continuous pale arm, subtle breathing/sway; six native frames and all adjacent onions including 5→0 are coherent. | None. |
| ranged_aim | PASS | — | Same full-height figure and one arm, progressively lifting at the elbow into a level hand lane; attached green shape grows over six 150 ms tiles. No independent limb or identity jump. | None. |
| ranged_fire | FAIL | 1–2, especially 2 | The charge contracts at frame 1 but rebounds into a conspicuous persistent green hollow polygon around the recoiling fingers in frame 2, which lasts 100 ms. This reads as a retained charge attached to the hand rather than the declared contraction/fade release. The supposedly effect-free body-source already contains this bright green polygon; frame 2 moves it with the foreground arm after the separate charge layer is removed. | Clean only the residual charge paint from the body-source hand neighborhood while retaining finger anatomy, then rederive fire frames 1–2 with a monotonic charge contraction/fade; preserve frame 0 and the fixed body. New independent review required. |

## Visual and motion findings

All 15 individual 256×352 native frame PNGs, the lineup, three strips and three onions were opened. All five style-lock references from art/style-lock.json were opened, along with ranged-identity-r02/key.png, ranged-aim-key-r05/key.png and ranged-aim-r03/body-source.png and charge-source.png. The painting retains the muted olive/brown decay palette, pale elongated arm, pointed shadowed hood, layered robe and stone/post construction consistent with the source identity and gothic painted style. No torso truncation, second arm, hard image rectangle or clipped silhouette was found. The robe legitimately reaches the ground without declared legs. All source tiles face right. Hood/post/base remain registered; the small idle hood motion is coherent rather than a resize.

Aim frame 5 and fire frame 0 visually coincide: no incoming hand, charge, hood or baseline pop. The fire 0→1 change is chiefly the smaller/dimmer separate halo over 50 ms. Fire 1→2 retracts and raises the same forearm a small believable amount, with the hood/post/base fixed, over the final 100 ms. The local recoil itself passes. The failure is the remaining charge polygon: on correct alpha-over-grey composition, frame 2 still has a bright angular hollow halo extending outside the fingers and its visible hollow interior is larger than the contracted frame-1 cue. It is plainly visible at native scale and as a luminous hand shape in both runtime facings. Removing a separate charge layer does not remove charge pixels already embedded in the body layer.

## D23 derivation

Read tools/prepare-ranged-fire.mjs and ranged-fire-r01/derivation.json. This is explicitly scripted_fallback: exact aim endpoint reuse at frame 0, separate effect scale/opacity 0.65/0.6 at frame 1, then local −6° forearm rotation and (−6,−1) pixel translation at frame 2. There is no whole-actor scale or recentering. The foreground occlusion preserves a connected single arm; no double elbow or detached hand was found. Scripted animation quality debt remains disclosed. The records' zero charge scale/opacity at frame 2 describe only the separate effect layer and do not match the visible residual charge in the body-source.

## Runtime evidence

Opened all 20 PNGs in evidence/ranged-fire-native and evidence/ranged-fire-phone, including both before-aim and outgoing-recover captures, plus both capture.json files. Native viewport is 1280×720; phone fixture records 852×393 (rendered game image has the expected letterboxing). Both facings retain stable body position and base contact. The source green halo and pale hand remain recognizable on the phone render, though the 6 px source recoil is subtle at that size. No facing-specific anatomical error or new clipping was found.

Both JSONs record no projectile on fire frame 0, one on frame 1 at about 58.3 ms, and one on frame 2 at about 108.3 ms; duration is about 208.3 ms because the harness samples on a simulation tick. This is consistent with the required frame-1 spawn and 50/50/100 ms source timing. The frame-1 spawn neighborhood is adjacent to the extended hand in both facings; the recoil occurs afterward, so no gross disconnected spawn offset is apparent. The projectile itself is too small/subdued in these stills for subpixel socket certification. This is a limitation, not a claim of precise measured alignment.

## Audit and scope

Read prompts/ART_REVIEW.md, docs/ART_CONTRACT.md, docs/ART_BIBLE.md, docs/ASSET_BRIEFS.md, contract/art_contract.json, pack index.md, audit.md and audit.json. Audit reports 3 clips, zero DEFECT and zero FLAG; there are no FLAG dispositions to accept. The visual charge defect is outside its current automated coverage. Only the three delivered ranged clips are judged here; the index's unrelated missing inventory does not turn this subset review into a full-game acceptance.

Outgoing ranged_recover and projectile appearance are explicitly excluded from acceptance. Their captures were opened to inspect the boundary only; the visible placeholder recover is not approved. Runtime screenshots are simulator fixtures (physical_device:false), not physical-device or continuous-video evidence. Still-frame/onion inspection supports continuity but does not certify perceived timing on hardware. No artwork was edited.

REVIEW: FAIL (1 clips)

Archive note: the reviewed captures were preserved unchanged in evidence/ranged-fire-r01-native and evidence/ranged-fire-r01-phone when the correction began.
