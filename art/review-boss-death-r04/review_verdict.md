# Independent visual review — boss death r04

Acceptance scope: `boss_death`. `boss_idle`, `boss_walk`, and `boss_strike_recover` are comparison references, not newly approved gameplay cycles. Independent reviewer: `/root/boss_death_review_r03`, 2026-10-20. I did not generate, process, or audit these assets. No prior verdict or other review pack was read; the one environment reference inside the style review directory was opened solely because it is an explicit style-lock image.

The lineup and every strip were opened first. Per-tile observations were saved to `blind_observations.md` and read back before index, scope, audit, contracts, or derivation/intent text. Descriptions were based on visible bodies and poses.

| Clip | Result | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| boss_death | PASS | — | Full crowned armored body loads onto bent knees, gains hand support, folds and settles before becoming local ash. Standing and stooped lethal entries preserve the contact pose in both facings. | None required. |
| boss_idle | PASS (comparison) | — | Same crowned head, shoulder plates, shroud, large gauntlets, visible plated legs and planted boots; subtle local motion does not alter stature. | None within this comparison scope. |
| boss_walk | PASS (comparison) | — | Identity and physical part sizes match the death opening; both legs remain visible through the alternating step poses. | None within this comparison scope. |
| boss_strike_recover | PASS (comparison) | — | Supported bent-knee stoop has the same helmet and armor size as neutral; provides a compatible lethal entry without an upright reset. | None within this comparison scope. |

## Identity, anatomy, support and motion

All standing lineup tiles carry a complete body from crown to boot soles and match the blue standing-height guide. Recovery is shorter through knee/hip articulation. The source faces right; mirrored runtime samples face left correctly. No missing torso, amputated limb, clipping edge, unwanted rectangle, or costume replacement appears. The muted olive cloth, corroded gray metal, restrained pale edges and painted texture belong with the five locked style references. No gore or warm decorative glow was introduced.

Death f0–2 retains the neutral body and bends its legs; f3 visibly places a knee down with the other foot still supporting. f4 provides the extended gauntlet contact on the floor and folds both legs, rather than lowering a floating torso. f5–6 continues the bow with a grounded hand and tucked legs; f7–8 rests as a low folded body with the crown near the forearm. The head and shoulder plates retain physical size while their overlap and orientation change. Cloth spreads behind the legs as the weight settles. The final low silhouette is a folded kneeling collapse, not a stretched horizontal copy or a miniature standing actor.

Every death onion pair f0→1 through f10→11 was inspected. f0→1 and f2→3 have the strongest pose changes, but the shoulders, crown, hips and supporting feet follow a readable downward path. f3→4 transfers support onto the hand; f4→5, f5→6 and f6→7 progressively close the torso over the legs. f7→8 holds the settled mass. f8→9 through f10→11 remove the body into ash at the same floor region. Reference onions were also checked in full: idle and walk include their last→first seams; recovery includes all five adjacent pairs. No additional blocking discontinuity was found for the scoped death.

## Audit FLAG adjudication

All four reported FLAGs were visually inspected at their named frames and corresponding onions, with runtime samples as a second check.

- A-11, f3 from f2, size +9.0%, height change 10.4%: accepted. The change introduces a knee-down pose and exposes front thigh/knee and forearm surfaces formerly overlapped in the stoop. Helmet and shoulder plate size remain credible. The fixed boot and new knee support make this read as a weight drop rather than whole-body enlargement.
- A-11, f6 from f5, size change 6.3%, height 7.8%: accepted. The torso folds forward and the nearer arm folds inward; cloth and thigh overlap increase. The floor hand remains registered and the head continues its bow. No scale pulse is evident in the scene samples.
- A-11, f10 from f9, size change 9.0%, height 8.3%: accepted. These are declared dissolve frames. The pale body remnant becomes faint while the smaller particulate heap becomes the dominant figure; shrinking ink is the intended disappearance, not a shrinking living body.
- A-11, f11 from f10, size change 44.8%, height 38.3%: accepted. The remaining body ghost disappears and leaves the compact ash pile with a few airborne grains. Its base remains on the floor; the large measured reduction corresponds to lost body silhouette. The exit/cleanup samples then fade the residue without replacing it with an unrelated effect.

## Runtime inspection

All 128 actual PNG samples referenced by the two capture manifests were opened, not merely the manifests. Each resolution supplies four fixtures: right/left × idle/strike_recover. Every fixture's 16 samples was examined: before, death f00–f11, unlock, fade, cleanup. Full scene sheets preserve every sample, and additional unscaled crops retain boss, hunter, floor and exit for native pixel inspection.

Both idle entries remain upright at lethal contact and then load downward. Both stooped recovery entries retain the stoop on f00, followed by a compatible loading pose on f01. In neither facing does the boss straighten to the neutral source f00 before collapsing. The mirrored silhouette and cloth trail change direction with facing while the floor line remains fixed.

The plated boots, knees, hand contacts and eventual ash heap stay registered to the same platform top. There is no visible floor sinking, hover, lateral teleport or abrupt physical size change. At phone size, the changing outline still reads from tall threat to kneeling/folded mass to residue; small internal plate details understandably become less distinct. The transition at f09 is visibly a pale ash treatment, then f10 reveals a faint ghost with residue, and f11 leaves ash alone. The brown exit stays closed during the body sequence, changes to the bright unlocked state after the last source frame, and remains unlocked as the ash fades and is removed. Cleanup samples show no residual boss body.

The manifests report production8HP and eight actual whip hits ending at0, 90ms frame spacing, unlock after1080ms, partial residue fade around1140ms and invisibility after1200ms. The images corroborate the visible sequence and exit state. These are isolated controller fixtures; this verdict does not certify full arena traversal, physical-device behavior, or unrelated combat cycles.

## Coverage

- Opened `lineup_boss.png` and all four `strip_*.png` before intent text.
- Opened every `onion_*.png`: death11 pairs, idle8 including seam, walk8 including seam, recovery5 pairs.
- Inspected all34 native source frames in this pack: death12, idle8, walk8, recovery6. Native RGBA frames were composited onto gray without resizing in `inspection/raw-*.png`.
- Opened all five exact image paths in `art/style-lock.json`: hero neutral, hero attack key, enemy pursuer, terrain patch, environment mockup.
- Opened all64 native1280×720 and all64 phone698×393 actual samples from the manifests. `inspection/captures-{native,phone}-*.png` preserves full samples; `inspection/detail-{native,phone}-*.png` preserves unscaled floor/actor/exit crops in manifest order,16 tiles per sheet.
- Read review protocol, art contract, bible, scoped review contract, scope, index, audit, and death derivation. Derived construction was judged by the resulting motion, not treated as approval.
- No scoped attack composite exists or is required for this body-only death. No required image was missing or unreadable. No blocking failure or required correction remains within the stated scope.

REVIEW: PASS
