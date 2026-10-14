# Blind visual observations

Recorded before reading any contract, metadata, audit, prompts, or reference text.

Lineup, style-neutral tile: right-facing brown-haired man in long brown split coat, light rolled sleeves, forearm guards, belt and coiled whip at left hip. Upright torso and compact planted stance. Both boots on red baseline; forward boot points right. Head has a clear face profile and ordinary neck join. Coat splits around legs; no obvious detached debris.

Lineup, stop-move tile: same identifiable man, torso upright/slightly pitched forward, legs spread in a long step. Left/rear boot is heel-raised with toe near baseline; right/front boot is on baseline. Right arm swings outward. Coat tails trail left. Face/shoulder slightly lower than neutral, with visually comparable head and boot scale.

Stop strip F0: wide rightward stride, leading boot out right, rear leg extended left and rear heel elevated. Coiled whip hangs at rear hip. Coat tail trails diagonally left. Reads as an advancing stride rather than an obvious active braking lean.
Stop strip F1: rear leg advances markedly toward pelvis while front leg also draws inward. Rear boot becomes a narrow steeply angled, toe-down shape with toe on ground, heel lifted. Torso/head stay nearly unchanged from F0. Front arm lowers slightly. Coat tail becomes more vertical. Rear leg and boot appear somewhat smaller/narrower than in F0.
Stop strip F2: upright neutral stance, rear boot flat and noticeably broader than F1's angled rear boot, front foot flat and closer in. Arms settle at sides, coat panels hang. The rear knee/boot arrangement expands sideways relative to F1 while becoming planted. The face appears similar but head is slightly higher.

Style-neutral strip F0: upright planted compact stance, right-facing profile, long split brown coat, large rolled light sleeves and wrist guards, coiled hip whip. Rear boot straight below body; front boot ahead to right. Coherent limbs and no obvious extra hands, feet, or debris.

# Independent acceptance review

Scope is only `hero_stop_move` and `style_hero_neutral`. All four native frames, both strips, lineup, the two onion pairs, runtime F0/F1/F2 and phone-sized F1 capture were opened. Registered style-lock images were inspected; earlier review verdicts and builder source/history were not consulted. The 62 other missing clips and out-of-scope derivations are not judged here.

## Identity, anatomy and presentation

All frames are full-body, face right, meet the shared ground line, and retain a recognisable hunter identity: dark tied-back hair, compact right-facing face, brown mantle/vest/split coat, rolled light sleeves, wrist guards, belt and small hip whip coil. No missing head, elongated neck, detached limbs, hard background rectangle, canvas clipping or obvious debris is visible. Head size stays believable; the small upward head shift into F2 is ordinary settling. Neutral F0 matches the registered neutral reference visually. Its separate thighs, calves and complete boots form a supported stance. No attack or effect is in scope, so active whip reach/grip composites are not applicable.

The stop clip's upper-body scale remains stable, but its F1 lower body is visibly compressed: the rear shin/boot narrows and the front boot's toe reach also retracts. This is local anatomy/boot deformation, not whole-character shrinkage. The rear F1 boot is especially steep and narrow compared with both neighbours. Turning a foot toward the viewer could shorten its projection, but here the calf, cuff and boot all compress together without a corresponding hip/knee turn, then expand back into the side-view planted stance.

## Every adjacent pair and braking intent

- **F0 → F1: FAIL.** Rear foot moves forward from the trailing toe contact into a near-vertical toe-down contact under the coat, while the front foot simultaneously retracts from the forward contact. The torso and pelvis scarcely change. Both contacts draw inward with no visible swing clearance and no convincing transfer of load onto an anchored braking foot. The rear heel remains raised, rather than supplying a full planted support. At 50 ms this reads as the lower legs narrowing under a mostly held upper body. Coat-tail movement itself is plausible; it cannot supply the missing support action.
- **F1 → F2: FAIL.** Rear boot suddenly broadens/lengthens into the flat neutral boot as its heel plants; front boot also regains its full toe projection. The arm and coat settle plausibly, and the slight head lift is acceptable, but the rear foot's change reads as a shape expansion rather than rotation of one constant-sized boot. There is no intermediate supported brake/compression pose before upright neutral.

F0 is a valid incoming stride/contact pose and F2 is a valid settled neutral endpoint. The action as a whole reads as a rapid stride closing into stand, with weak braking intent: no clear planted lead-foot resistance, knee/hip loading or torso counterbalance. The runtime captures reproduce these poses; at phone size the contracted F1 rear lower leg remains a thin peg. Static frozen captures establish in-engine appearance, not an independently observed real-time playback.

## Per-clip verdict

| Clip | Verdict | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| `hero_stop_move` | FAIL | F1 (`f001.png`); pairs F0→F1 and F1→F2 | Both contacts slide inward with a held torso; F1 rear calf/boot visibly compresses and expands into F2, leaving no convincing loaded braking support. | Replace F1 with one articulated braking key: retain a clear anchored lead-foot sole, bend the loaded knee/hip with a small torso counterbalance, preserve both calf/boot dimensions, and give the rear foot a believable constant-sized recovery/plant path into F2. Retain valid F0/F2 endpoints. |
| `style_hero_neutral` | PASS | — | Complete stable planted hunter matching the registered reference; coherent anatomy, head/neck and costume. | None. |

## Audit flags

`audit.md` and `audit.json` report 0 DEFECT and 0 FLAG. No flags require acceptance. The visual failures above concern support and local limb/boot continuity that global ink/height checks do not establish.

REVIEW: FAIL (1 clips)
