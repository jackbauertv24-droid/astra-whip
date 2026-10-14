# Blind visual descriptions

Recorded after opening lineup and both strips, before reading contract, prompts, index or audit.

Lineup tile style neutral: right-facing brown-haired man with long brown coat, light undersleeves, dark trousers, brown boots and coiled whip at left hip. Upright stance, feet down, relaxed hands. Lineup tile walk: same recognizable man, wide stride with leftmost boot behind and rightmost boot ahead, coat tails spread.

Neutral strip F0: upright three-quarter right-facing adventurer, coherent leather clothing and boots, long divided coat, hanging hands and whip coil.

Walk strip F0: broad stride, rear boot left and forward boot right, slight forward arm extension. F1: virtually same broad stride and coat shape. F2: rear boot lifted and bent, forward boot flat beneath torso, coat left tail trailing. F3: planted leftmost boot with opposite boot tucked up behind/right; coat tail swings sharply right. F4: planted leftmost boot, opposite boot extended ahead/right; right coat tail billows. F5: comparable forward extension with advancing boot lower, coat still billowing. F6: forward right boot planted, rear bent leg partly hidden under tail; small dark loose mark below rear boot. F7: leftmost boot planted below torso and right boot lifted forward; body appears higher and rear coat tail extends left. F8: two boots apart, right boot raised slightly, long coat trailing left; leftmost boot looks irregular at ankle/heel. F9: broad stride returns, rear boot left and front boot right; forward coat panel narrower than F0.

## Scope and inspection

This fresh review covers only `style_hero_neutral` and `hero_walk`. All ten native walk PNGs, native neutral PNG, lineup, both strips and every onion pair including F9→F0 were opened. Contract, bible, review prompt, index and audit were read after the blind descriptions. The registered neutral identity reference was also opened; no prior review verdict or builder files were opened. Missing clips and unrelated derived clips listed in the index are outside this explicitly scoped review.

## Identity, scale and anatomy

Both clips show the same recognizable hunter facing right, with full head-to-boots anatomy at the expected standing scale. The neutral is a coherent planted pose matching the registered reference. Walk head size and face remain stable. Head/neck joins are visually continuous at native size: no obvious detached head, rectangle or neck gap. Mantle, light undersleeves, bracers and upper torso preserve identity, although the lower coat and leg arrangement do not preserve motion continuity in the named middle frames. No sprite is cut off by the canvas edge. Coiled whip remains adjacent to the hand/hip; attack grip/reach and effects are not applicable to these clips.

## Adjacent motion

F0→F1 is a small closing stride. F1→F2 brings the rear boot up toward passing with a plausible torso dip. F2→F3 abruptly reverses the coat's dominant hanging/trailing direction into a wide right-facing flap; the leg crossover is poorly explained by that coat occlusion. F3→F4 visibly expands the hip/coat silhouette and opens the leg arrangement in a single 80 ms step. The coat changes from a thin horizontal rightward flap to a broad, downward right panel, exposing substantially more trouser and boot mass; this is a redraw pop rather than a small continuous cloth step. F4→F5 lowers the forward boot plausibly. F5→F6 suddenly folds a rear boot into a nearly horizontal shape across the other calf while shortening the coat into a new hem arrangement. F6→F7 restores a long left-trailing tail and moves the support from the rightmost planted boot to the leftmost planted boot while lifting the other boot ahead; the intervening contact/passing progression is missing. F7→F8 changes modestly and F8→F9 opens toward contact. F9→F0 is a quiet seam; no visible loop-seam jump requires correction.

F6 also contains a small dark triangular dangling fragment below the rear boot's left edge, visible in the strip and native PNG. Its proximity can allow it through the automated figure grouping; visually it has no readable anatomical or costume role. The supported/swinging legs must be readable independently of this fragment and of coat occlusion.

## Verdict

| Clip | Verdict | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| `style_hero_neutral` | PASS | — | Full coherent standing hunter, consistent with identity reference. | None. |
| `hero_walk` | FAIL | F3, F4, F6 | Abrupt coat/hip volume and leg crossover changes at F2→F3→F4; folded overlapping boot, stray dark fragment and support/swing discontinuity at F5→F6→F7. | Replace F3/F4 with articulated passing-to-contact in-betweens preserving neighboring coat panel volume and visible boot paths. Replace F6 with a clear grounded support leg and separately readable swinging leg progressing from F5 toward F7; retain neighboring upper body and remove the dark boot fragment. |

## Audit FLAG adjudication

- **A-11 `hero_walk` F4, F3→F4: size +8.2%, height 0.0% — DEFECT.** The onion shows a broad new lower-coat/hip silhouette appearing at once, with a changed hem direction and exposed leg mass. Stable height and head do not make that clothing/body-volume pop acceptable.
- Accepted FLAGs: none.

The scripted derivation produces recognizable locomotion overall, but the named middle frames interrupt a believable alternating walk and therefore fail the intended-action review under §11.

REVIEW: FAIL (1 clips)
