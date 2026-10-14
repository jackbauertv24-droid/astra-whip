# Independent brake r03 review

## Blind observations (recorded before reading contracts or metadata)

Lineup, left tile: recognizable realistic brown-haired adventurer facing right; leather shoulder cape and long coat, pale sleeves, wrist guards, coiled rope at left hip, two boots. Upright neutral pose; boots share ground line, body is complete and proportionate.

Lineup, right tile: same apparent adventurer, wider fore/aft leg separation, rear heel lifted and forward boot flat. Upper body and head remain upright; arms slightly more spread. Coat follows stride. Full anatomy remains readable.

Stop strip F0: extended stride with rear boot lifted and forward boot on ground. Two arms and two legs appear intact; long coat has plausible trailing panels. Face, hair, clothing and rope match lineup.

Stop strip F1: narrower stance, both boots apparently grounded, right-facing forward leg still ahead. Body appears slightly lower and compact with bent knees. Rear foot advances toward center while forward foot shifts inward slightly; rope arm stays low and other arm moves inward.

Stop strip F2: upright narrow resting stance closely matching neutral. Both boots grounded. Legs straighten, arms settle and coat closes. The sequence reads as a brief stride gathering into rest; at the printed 50 ms per pose, the transition may be abrupt and merits playback inspection.

Neutral strip F0: upright right-facing adventurer with relaxed arms, two visible gloved hands, coil at near hip, long coat and two planted boots. Silhouette and design consistent with the other tiles. No obvious missing part, extra limb or marked identity change.

## Scoped inspection and verdict

Scope is only `hero_stop_move` and `style_hero_neutral`; the other 62 absent clips and unrelated derivation entries are outside this review. Read `prompts/ART_REVIEW.md`, `docs/ART_CONTRACT.md`, `docs/ART_BIBLE.md`, `art/style-lock.json`, the two contract clip entries, the review index and scoped audit after the blind observations. Opened all four delivered native PNGs, the approved neutral reference, both onion pairs, and all six actual engine screenshots (`evidence/brake-engine-r03/f000.png` through `f002.png`, and the matching three phone-size captures).

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| `hero_stop_move` | PASS | — | Same complete hunter gathers a wide stride into a grounded knee compression and then an upright resting stance across three 50 ms frames. | None required. |
| `style_hero_neutral` | PASS | — | Complete, proportionate right-facing resting hunter matches the approved identity reference. | None required. |

Identity and anatomy: face/hair, mantle, leather vest and coat, pale sleeves, wrist guards, hip coil and boots remain recognizably the same construction. All frames contain head, torso, both arms/hands and two full legs/boots. No torso substitution, clipped limb, detached coil, debris or hard extraction rectangle is visible. Frame 1 lowers the head/body slightly while bending the knees; the head and limbs retain their scale. This reads as compression rather than a resized standing figure. The neutral frame and stopping endpoint match the style-lock reference.

Motion and support: F0→F1 draws the trailing boot forward onto the floor while shortening the stance and lowering the hips; the forward boot remains at substantially the same contact location. F1→F2 straightens the body over the retained rear support and gathers the forward foot inward. Its small positional change reads as the final recovery gather in this short three-pose stop, rather than a whole-body foot slide or an unsupported jump. The onion sheets show one consistent body, with a small head dip and recovery and compatible arm/coat settling; no pair changes limb length or silhouette scale abruptly. At the declared 150 ms total duration this reads as a brisk stop with a compression beat, not another sustained walk cycle.

Engine evidence: all three poses remain grounded on the same masonry top edge. At the phone display size the wide stance, compressed middle and upright endpoint are distinguishable, the full silhouette remains legible, and the transition preserves one character and support. These are discrete actual-engine captures of the contracted poses; no video was supplied, so timing judgment uses their ordered sequence together with the 50/50/50 ms contract and onion sheets.

Audit adjudication: scoped audit reports 0 DEFECT and 0 FLAG. There are no FLAGs to accept or reject. No attacks or effects are in scope; the resting hip coil is visibly carried by the near hand/hip rather than floating.

REVIEW: PASS
