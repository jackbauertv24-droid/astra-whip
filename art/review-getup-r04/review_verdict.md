# Independent art review r04

## Blind visual descriptions (recorded before contract or metadata)

Lineup tile STYLE_NEUTRAL: a brown-haired, light-skinned man faces right in three-quarter profile, standing upright in a long brown leather coat, light rolled sleeves, dark trousers, gloves and boots. A coiled whip hangs at his waist. His head reaches the blue line and both boots meet the red floor.

Lineup tile GET_UP: the same apparent man reclines near the floor facing right, supported by his left forearm, with one raised bent knee and extended boots. The long coat pools beneath his hips; his right hand is near the belt.

Get-up strip F0: reclined sideways, head upright, left forearm bearing weight, right hand near waist, one knee raised, boots extended right.

Get-up strip F1: torso lifted into a seated pose, left palm flat behind him, one knee raised with boot drawn inward, other leg folded along the floor.

Get-up strip F2: torso tilted forward in a low half-kneel, left palm on floor, forward boot planted and forward knee raised, rear leg tucked underneath.

Get-up strip F3: deeper forward lean over planted front foot, rear knee remains low, right hand reaches the floor on the forward side while left hand rises toward waist/thigh.

Get-up strip F4: half-kneeling rise with torso and hips higher, front boot planted, rear leg bent behind, right hand lifted just above floor, coat trailing behind hips.

Get-up strip F5: fully upright right-facing standing pose, arms resting at sides, two boots planted, long coat hanging freely.

Neutral strip F0: upright man facing right, dark brown hair, brown long coat and harness, cream sleeves, metal forearm protection, gloves, charcoal trousers, brown boots and waist whip. Head at blue guide, boots on red guide.

## Scope and reference comparison

Reviewed only `hero_get_up` F0–F5 and `style_hero_neutral` F0. Opened the lineup, both strips, every supplied onion pair, and all seven native PNGs. Compared with the registered hero neutral and attack reference images from `art/style-lock.json`; no earlier review or generation records were consulted. The unrelated missing clips and unrelated derivation entries in the pack index are outside this requested review.

The neutral has a complete head-to-boot body at the blue standing-height guide, with separately readable trouser legs and boots. The get-up poses preserve the warm face, tied-back brown hair, shoulder mantle, linen sleeves, plated bracers, brown layered leather, long coat skirts and small waist coil. All face right. Head and boot dimensions remain recognisably physical parts of the same man; the low poses fold his limbs rather than scale down a standing figure. Faces remain joined to shoulders by compact, continuous neck/collar anatomy. No missing limbs, detached body pieces, canvas clipping, hard background rectangles or visible debris are apparent in the native images.

## Adjacent motion and support

- F0→F1: the supporting forearm extends to a planted palm as his torso rolls upright. The extended boot retracts and the other leg folds underneath the seated hips. The large silhouette narrowing is leg draw-in and overlapping coat/limbs, not whole-body shrinkage; the head and bracer remain consistent.
- F1→F2: the planted hand continues to support him while the torso leans over the bent forward knee. His seated rear leg tucks beneath the pelvis into a low kneel; front sole remains at floor level. The modest horizontal hand/boot adjustments read as repositioning into a load-bearing recovery stance.
- F2→F3: the forward foot and folded rear knee keep the pelvis supported while the forward-side hand reaches down to floor contact. The opposite supporting arm bends upward toward thigh/waist. This is a plausible transfer of hand support around a grounded half-kneel, with attached elbows/wrists and no unsupported upward body leap.
- F3→F4: torso and hips rise over the planted forward boot while the rear knee lifts and rear foot remains low behind the coat. The grounded hand releases upward along the same arm path. The back boot is partially obscured by cloth, but the bent trailing leg remains coherent; the forward thigh/knee/ankle carry the ascent.
- F4→F5: the front knee extends, the rear foot comes forward under the hips and the torso straightens into the neutral stance. This is the largest vertical step, but it follows the loaded half-kneel and ends with two planted boots. Head movement is back over the support base, rather than a scale increase; coat skirts unfold downward and arms settle continuously.

At six 75 ms poses this is a brisk, clearly directed recovery. It reads as pushing and gathering the body up from the floor, with a visible palm/foot/knee support sequence. There is no backward-fall interpretation or held floating intermediate body.

## Per-clip verdict

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| `hero_get_up` | PASS | — | Supported recline-to-sit-to-half-kneel-to-stand recovery; stable identity, limb scale and costume through all five adjacent pairs. | None. |
| `style_hero_neutral` | PASS | — | Full-body right-facing standing reference with normal anatomy, compact neck, floor contact and correct standing-height silhouette. | None. |

## Audit FLAG adjudication

- **A-11 `hero_get_up` F1, F0→F1, size 15.2%, height 9.5%: ACCEPTED.** The wide reclined legs retract beneath the seated body, and cloth/thigh/torso overlap replaces the extended silhouette. Head and bracer dimensions visibly stay consistent. The palm replaces the forearm as support and the pelvis stays low: the ink-area change corresponds to legitimate occlusion and folding.
- **A-11 `hero_get_up` F3, F2→F3, size 6.1%, height 7.7%: ACCEPTED.** The torso tips forward, the arms exchange supporting roles, and coat cloth spreads behind the grounded kneeling leg. Front boot/rear knee provide support throughout; the right palm visibly reaches floor level. No rigid anatomical part expands to explain the small threshold exceedance.

No attacks or effects are in scope, so attack composites and effect progression are not applicable. The reused get-up poses were judged by their visible recovery action under §11, without accepting their derivation as proof of quality.

REVIEW: PASS
