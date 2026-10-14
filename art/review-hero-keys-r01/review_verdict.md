# Independent hero key-pose review

## Blind lineup observations (before reading scope or measurements)

1. Standing right-facing human adventurer; brown hair, brown shoulder cape/long split coat, pale sleeves, metal forearm guards, gray trousers and tall brown boots. Coiled rope/whip hangs beside the near hand. Two legs and feet visible; relaxed upright silhouette.
2. Right-facing walking/striding version of the same adventurer, one foot ahead and one behind. Near arm hangs with coil, farther arm swings forward. Full body appears intact and close to tile 1 size.
3. Deep right-facing crouch with hips lowered over folded legs; both knees/boots overlap. Hands near knees, coil held at near knee. Head and torso retain adult scale; reduced height reads as bending.
4. Airborne right-facing leap with forward knee lifted and rear lower leg angled down/back. One arm reaches forward while the near hand retains the coil. Cape tails stream behind. Full anatomy appears present, though rear leg overlaps coat and forward boot.
5. Fallen/reclining adventurer, head at left and feet at right, upper body propped on an elbow. One knee raised, another leg extended. Head is turned toward screen right. Coil sits beside abdomen/hip; figure looks full-sized rather than miniaturized.
6. Wide stance with rightward torso/facing; near arm bent up and back holding a short horizontal brown handle, other hand near waist. Reads as weapon wind-up. The visible coil appears to hang from waist rather than clearly continue from raised handle.
7. Wide rightward attack stance, farther arm extends horizontally right with a small brown weapon handle in the fist; near hand rests around waist. Forward limb reads as an extended arm and grip but weapon beyond handle is absent from this lineup.
8. Deep right-facing crouch with farther arm extending right holding a horizontal brown handle; near arm bends down around a coil at knee. Full crouched anatomy reads similarly to tile 3, but whether coil and forward handle represent one connected weapon is unclear.

## Scope and evidence

This is an isolated key-pose reference gate only. I read scope.md and measurements.json after recording the blind observations above, and opened all eight individual key PNGs. I also inspected lineup_hero_guides.png after the blind descriptions: standing and walking approach the blue line, both crouches reach the yellow line through folding, and each tile meets the red baseline as expected for its pose. I compared the figures with the neutral and attack reference images identified through ART_BIBLE's implementation style-lock register. The body poses, rather than the unfinished separate whip rope, are being reviewed. There are no animation strips, onion skins, complete attack composites, socket measurements, or engine playback captures in this pack; none are approved by this verdict.

## Per-key verdict

| Tile / key | Verdict | May be used as derivation reference? | Findings and smallest correction |
|---|---|---|---|
| 1 / neutral | PASS | Yes, for body pose/identity | Matches the registered neutral reference. Full head, torso, two arms, two legs and boots; upright adult proportions, right facing, near fist overlapping a compact coil. No required pose correction. |
| 2 / walk | FAIL | No, pending edge correction | Body identity, full anatomy, stride scale and right facing pass. A conspicuous saturated red notch sits beneath the chin at the neck edge in key_2.png, outside the warm brown/bone costume treatment. Clean that small fringe without changing the silhouette or rescaling the body. |
| 3 / crouch | PASS | Yes, for body pose/identity | Deep hip/knee folding is visible, with the thighs overlapping the lower legs and boots. Head size remains consistent; this is bending rather than shrinking. Both arms remain present and the coil overlaps the near glove. Rightward face is clear. No required pose correction. |
| 4 / air | PASS | Yes, for body pose/identity | Recognizably the same adult figure. Forward thigh rises, rear leg folds down/back, both boot forms remain readable despite overlap. The reaching arm and coil-bearing arm are distinct. The head and torso are not miniaturized. Faces right. No required pose correction. |
| 5 / down | PASS | Yes, for body pose/identity | Reads as resting on hip/elbow after a knockdown, with one raised knee and two distinct boots. Head, torso and limbs retain plausible adult scale. Head turns right toward the target despite the reclining torso; this is appropriate for this pose. Coil remains beside hand/hip. No required pose correction. |
| 6 / windup | PASS | Yes, for isolated body pose/grip | Full body and broad stance are readable; raised fist wraps the short horizontal grip. Identity and right facing match. The top-band head proxy includes the raised hand and is not a true skull measurement. No required isolated pose correction. The complete rope connection and transition to the strike need separate review. |
| 7 / strike | FAIL | No, pending edge correction | Body anatomy, planted lunge, identity and rightward aim pass. Extended glove visibly wraps the short handle. A bright saturated red horizontal edge remains between the neck/shoulder and upper extended arm in key_7.png. It is also visible in the registered attack reference, but inherited defects are still defects. Remove that red fringe locally; do not alter scale or pose. |
| 8 / crouch-strike | PASS | Yes, for isolated body pose/grip | Full crouched body remains readable at the neutral head scale; hips/knees bend instead of the actor shrinking. The forward glove encloses the horizontal handle and the face aims right. No required isolated pose correction. The near-hand coil and separate attack rope must be reconciled in the completed composite. |

## Scale, anatomy, and accepted limitations

The supplied height/size measurements support the visual assessment. Relative to neutral S=115.139, walk is approximately 1.005, crouch 0.880, air 0.985, down 1.044, windup 1.079, strike 1.077, and crouch-strike 0.926. These fall within the relevant pose bands. Windup is near the strike size ceiling; retain its current scale rather than enlarging it during derivation. All reported foot lines are y=448. Standing neutral is 224 px high, walk 222 px, and both crouches 142 px; the crouches achieve this height through visible joint folding.

Neutral/walk/crouch head widths of 39/40/38 px support consistent scale. The raised-arm windup width of 68 px is not evidence of an enlarged head because its top band contains the raised glove/handle, and strike poses skip this proxy. Air and impact also skip the proxy. Direct visual inspection finds no missing lower body or stretched torso. Fine leather tooling is too small in this pack to certify every motif stroke, but the main mantle, vest, linen sleeve, plated bracer, coat and boot construction remain recognizable across all keys.

The incomplete whip rope is an accepted scope limitation, not an approved weapon. The grips in keys 6–8 are visible enough to place a socket, but no W-01/W-04/W-05 compliance or physical rope continuity can be inferred from these images. The apparent change from raised near arm in windup to extended far arm in strike particularly requires checking during the later motion/composite gate; isolated poses do not establish a believable arm transition. Minor warm edge pixels on leather/boots were not treated as anatomical defects; the clearly saturated red areas in keys 2 and 7 need cleanup before they propagate into derived assets.

No audit FLAG list is supplied. The table adjudicates the measured pose properties and visual findings only. Animation, derived-clip quality, gameplay-facing continuity, complete whip behavior, and release readiness remain unapproved.

REVIEW: FAIL (2 keys; isolated key-pose scope only)
