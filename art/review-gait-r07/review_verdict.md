# Independent gait review r07

## Blind visible-tile description (written before text/contract/metadata)

Lineup: left tile is a right-facing brown-haired man in a brown split long coat, cream sleeves, silver forearm guards, dark trousers and brown boots. He stands with both soles down, a coiled rope at the near hip. Right tile shows apparently the same man in a long stride, left-on-image boot behind, right-on-image boot forward, torso upright and arm forward.

Neutral strip: F0 shows the same right-facing man standing with hands near the hips, both boots grounded, brown coat tails hanging apart, and hair at the collar.

Walk strip, each tile: F0 has a broad stride, rear heel raised and front boot flat. F1 has almost the same broad stride with the rear boot drawn slightly inward. F2 has the right-on-image leg planted and left-on-image boot lifted behind; arms move toward the hips. F3 has the left-on-image boot planted under the body and the right-on-image boot lifted forward; coat tails flare around the legs. F4 has the left boot planted and right boot reaching forward close to ground. F5 has both boots spread on the ground, with the right boot forward. F6 has the left boot planted and right knee raised forward, right boot high off ground. F7 maintains that raised-forward-leg pose, advancing the right boot. F8 lowers the right boot toward the ground, left boot behind. F9 returns to a broad stride, rear heel raised and front boot flat. Across tiles the man retains brown hair, brown leather long coat, cream sleeves, metallic cuffs, rope at hip and dark trousers. Head height varies modestly. The strip appears to repeat the same visible leading-leg arrangement rather than showing a clearly alternating left/right step.

## Scope and evidence

Scope is exactly `style_hero_neutral` and `hero_walk`; the pack's other missing/derived clips are outside this review. Inspected the neutral native PNG, all ten native walk PNGs, lineup, both strips, and all ten onion pairs including the seam. Read the specified contract, bible, animation specification, review prompt, pack index and audit. Compared with the registered neutral and attack identity images; did not open previous review verdicts. Generation descriptions in the required index are not evidence of visual correctness.

## Identity, anatomy, and motion

Neutral is a complete standing human with both legs and boots, facing right, at the intended scale. Walk retains the same general hunter identity and physical scale; no torso-only substitutions, gross rescaling, missing limbs, clipped canvas edges, rectangular backgrounds, or detached debris are visible. The coat, mantle, metal bracers and hip coil retain their overall material identity. Neck/head attachment remains connected, although F6 moves the head and shoulders conspicuously forward compared with both neighbors.

The walk has recognizable contact and lifted-foot poses, but the support/swing sequence is not consistently trackable as two alternating legs. F2 has the screen-right boot supporting and screen-left boot airborne behind. F3 abruptly makes the screen-left boot the grounded support while putting the screen-right boot airborne ahead, without the rear airborne boot visibly completing its forward swing/contact. F4 advances the screen-right boot to a second forward contact. After F5, F6 raises that same forward boot backward into another forward-knee pose, while the grounded boot and upper body shift forward; F7 then shifts the upper body back. This reads as repeated rightward leg presentations and a hitch rather than a smooth alternating weight transfer. The problems are visible in the native frames and are not inferred from audit numbers.

Adjacent pairs: F0→F1 is a small contact-phase progression; F1→F2 draws the planted boot inward and lifts the rear boot; F2→F3 has the support/swing swap described above; F3→F4 plausibly lowers the forward boot but inherits the wrong support assignment; F4→F5 changes the coat/hip-coil presentation abruptly while preserving the same forward foot arrangement; F5→F6 reverses the forward boot into a raised pose and advances the grounded leg/body; F6→F7 restores the body position with a visible horizontal hitch; F7→F8 lowers the raised boot coherently; F8→F9 extends into contact; F9→F0 has a very small seam change, acceptable. The seam itself is not the failure.

## Audit FLAG adjudication

- **A-08, hero_walk f006, head width 1.077× reference:** **accepted as an isolated silhouette variation**. The human face, brow, hair and neck remain recognizable and connected; this single-frame difference does not alone demonstrate whole-head rescaling. Acceptance of this FLAG does not excuse the independently visible F5→F6→F7 body-position and leg-path hitch.

## Verdict

| Clip | Verdict | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| `style_hero_neutral` | PASS | — | Full standing figure matches the canonical reference at the intended scale. | None. |
| `hero_walk` | FAIL | `f003.png`, `f004.png`, `f006.png` | F3/F4 exchange support and swing before the trailing foot completes a forward step; F6 reverses the forward boot into another lift and creates a forward/backward body hitch against F5/F7. | Repaint these three in-betweens with explicit near/far leg identity: preserve the existing support leg through each passing phase, carry the airborne boot forward to its next contact, and place F6 head/shoulders/grounded boot between F5 and F7 without the horizontal detour. Keep coat/coil continuity against immediate neighbors. |

REVIEW: FAIL (1 clips)
