# Independent review v3

## Blind image descriptions (recorded before reading contract or scope)

1. A man stands facing right in three-quarter/profile view, arms down, feet apart and planted, long brown coat hanging behind his knees.
2. He steps to the right in a long walking stride: front boot planted ahead, rear heel lifted, hands low and separated.
3. He crouches very low, knees deeply folded, torso tipped forward, one hand beside the front knee and the other near his hip.
4. He appears airborne traveling right, one thigh lifted and knee bent forward, the other lower leg tucked back, coat tails streaming left; one arm reaches forward for balance.
5. He lies reclined on the ground, supported on a rear elbow, head raised to the right, one knee bent up and the other leg extended along the ground.
6. He stands braced with spread feet, one hand raised behind/above his shoulder holding a short handle, elbow bent, other hand against his waist. Reads as winding up a strike or throw.
7. He leans into a wide forward stance and reaches/punches his handle-holding arm horizontally right, opposite hand drawn back to the waist.
8. He holds a deep crouch with his handle-holding arm extended horizontally right and the other hand near his knee.

Blind idle strip: Eight nearly identical standing poses, facing right, feet planted throughout. There is very small head/upper-body height or contour change, and slight coat/arm changes, consistent with a subdued breathing idle. No visible step, large limb movement, or pose change. The strip alone does not make the precise animation timing perceptible.

## Scope and evidence

This verdict covers eight isolated body keys as derivation references, plus the eight-frame hero_idle clip. It does not approve the unprovided locomotion/attack clips, whip rope, composites, gameplay integration, or the full animation set. No prior review_verdict file was read. The numbered images were opened and the descriptions above recorded before reading the permitted contract, bible, scope, measurements, index or audit. Subsequently inspected both permitted style references, the idle lineup and the idle onion sheet.

## Per-key verdict

| Key / intended pose | Result | Reference approved | Defect or supporting finding | Smallest correction |
|---|---|---|---|---|
| 1 / neutral | PASS | Yes | Full body and both boots; matches the neutral reference; relaxed right-facing stand. | None. |
| 2 / walking contact | PASS | Yes | Both articulated legs and a readable contact stride; same mantle, vest, hair and boots. | None. |
| 3 / deep crouch | PASS | Yes | Deep knee and hip folding accounts for the reduced height; head retains standing scale. | None. |
| 4 / airborne rise | PASS | Yes | Separated bent legs and trailing coat clearly read as an airborne pose, with the full body present. | None. |
| 5 / knocked down on hip | FAIL | No | Body acting is convincing, but a conspicuous saturated red/yellow edge patch appears at the upper outline of the right-side bent sleeve/shoulder, beside the raised knee. It reads as cutout contamination, not linen or leather. | Clean/repaint that small edge patch in the surrounding sleeve/coat colors or transparency; retain pose and scale. |
| 6 / attack windup | PASS | Yes | Braced lower body and raised bent arm read as preparation; the short grip is visibly in the hand. | None. |
| 7 / extended standing strike | PASS | Yes | Complete body, forward weight and extended shoulder/arm read correctly; hand visibly encloses the short grip. | None. |
| 8 / extended crouching strike | FAIL | No | Crouch and grip read correctly, but a bright red line/patch remains along the upper shoulder-to-extended-sleeve edge. This is foreign to the costume palette and resembles the edge artifact visible in the supplied attack reference. | Remove/repaint the small red fringe using local sleeve/shoulder color and correct alpha. Keep the anatomy and grip. |

These failures concern visible edge contamination, not missing anatomy or pose intent. The supplied attack reference also shows a stronger red shoulder artifact; inheriting that artifact does not make it part of the hunter design. No claim is made about its exact keying origin or RGB value.

## Identity, anatomy and scale

All eight bodies remain recognizably the same hunter: warm-brown leather vest and coat, shoulder mantle, pale shirt, tied dark hair, metal bracers and tall boots. All face right. No head, foot or hand is cut off by a canvas boundary. Both legs are anatomically present in every key, including the bent/overlapping crouch and reclined poses; none is a stretched torso.

The supplied measurements support the visual scale assessment. Relative to neutral S=115.139, the seven other size ratios are approximately 1.005, 0.880, 0.985, 1.044, 1.079, 1.077 and 0.926, inside their respective pose-class bands. All reported foot lines are y=448. Neutral/walk heights are 224/222 px; crouch and crouch-strike are 142 px; the remaining envelopes agree with their classes. Crouch head width is 38 px versus neutral 39 px, and the visual bent-limb anatomy supports the numerical finding. Windup's 68 px top-band width measures the raised hand/arm region and is not a giant head; the strike class correctly skips that proxy. Walking's boot ratio alone exceeds 0.60, but its leg dip is below 0.50 and both boots/legs are visibly present, so A-07 does not fail.

## Idle clip verdict

| Clip | Result | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| hero_idle | PASS | None | Frames 0–7 preserve the complete standing body, fixed feet, face and costume. Small upper-body breathing displacement reads as subdued idle movement. | None required. |

Frame descriptions: F0 stands relaxed with arms down and both feet grounded. F1 retains that same full-body stance with a tiny upper-body change. F2 remains grounded with the head/shoulder contour near the small breathing extreme. F3 retains the complete silhouette and pose. F4 continues the same planted stance as the upper-body displacement returns. F5 shows the same hunter with no new limb or costume arrangement. F6 retains the planted feet and natural upright anatomy. F7 remains in the same stance close to the loop's start. No frame shows missing limbs, a hard rectangle or canvas clipping.

Onion pairs 0→1, 1→2, 2→3, 3→4, 4→5, 5→6, 6→7 and 7→0 all retain one nearly coincident body. None jumps, changes scale, teleports a limb or swaps costume. The lineup aligns the idle with the neutral standing height and ground guide. The displayed eight 125 ms frames and looping flag agree with the contract. The audit reports 0 DEFECT and 0 FLAG; there are no flags to accept or reject.

The declared scripted fallback is acceptable under ART_CONTRACT §11: it reads as a quiet breathing idle. It is restrained, with little independent cloth/hair action; retain its required quality-debt disclosure in the release handoff. This review does not infer full animation coverage from that approval.

## Required correction set

Clean only the visible bright edge contamination in keys 5 and 8, rebuild the affected key review evidence, and submit those changes to a fresh independent reviewer. No anatomy redesign or scale normalization is requested. The two failures below count isolated reference items, not completed animation clips.

REVIEW: FAIL (2 reference keys; 0 clips)
