# Independent review — boss death r03

Reviewer: fresh independent agent `/root/boss_death_review_r02`, 2026-10-19. Acceptance scope is `boss_death`; the other three clips are comparison references. No previous review verdicts or other review packs were read. The fifth style-lock image was opened directly at its registered path; its enclosing review pack was not read.

The lineup and every strip were opened first. Plain observations were saved to `blind_observations.md` and read back before opening metadata, intentions, contracts or audit. This verdict is based on the images, including the actual engine samples, rather than the derivation's assertions of approval.

| Clip | Result | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| boss_death | FAIL | f3, specifically f2→f3 | The planted, bent standing legs switch directly to a broad sideways-folded kneel while the hanging striking hand moves out to a new floor contact. This is a lower-body/hand pose pop rather than a short supported step; it is visible in the onion pair and both runtime facings at both resolutions. | Replace f3 with a genuine intermediate: lower one knee while retaining a recognizable planted boot, and move the striking hand partway toward its floor contact. Let existing f4 supply the completed kneel. Keep the twelve frames and their 90ms durations; preserve the fixed floor and existing upper-body identity. |
| boss_idle | PASS (comparison only) | — | Full standing anatomy, consistent crown/plate/shroud and scale; tiny breathing/cloth movement, grounded boots and unobtrusive seam. | None for this acceptance scope. |
| boss_walk | PASS (comparison only) | — | Full legs and boots remain present through the alternating strides; upper-body identity and physical scale provide a consistent baseline for death. | None for this acceptance scope. |
| boss_strike_recover | PASS (comparison only) | — | Stooped pose bends the knees and hips; it retains full-size head/armor and both boots. Recovery rises toward the shared neutral. Suitable identity/support reference for the lethal-entry fixture. | None for this acceptance scope. |

## Mandatory-clip assessment

**Identity and physical size.** The crowned hollow helmet, stacked shoulder plates, corroded steel, ragged olive shroud and oversized striking arm remain recognizable. This is a whole armored figure, including legs, rather than a stretched torso. The loaded standing poses bend rather than shrink. Kneeling, bowing and settled heights are appropriately lower, with broadly consistent helmet and shoulder-plate scale; the mandatory failure concerns the discontinuous arrival at the kneeling configuration, not the mere reduction of silhouette height or an automatic size threshold alone. Source poses face right; mirroring is plausible in the left-facing captures.

**Support and floor registration.** f0–f2 retain grounded boots while the knees load. f3–f4 show folded legs and a floor-bearing striking fist; the other arm hangs free. f5–f6 transfer the smaller hand to the folded leg while the large fist braces the forward weight. f7–f8 settle the body onto the folded legs/cloth and both low arms. None of these final poses needs an invisible support. The boots, folded shins, cloth, fists and ash stay on the same floor; the runtime actor does not drift or sink beneath the platform. The defect is the missing transition between the initial boot support and the already completed kneeling support at f3.

**Motion, all pairs.** f0→f1 and f1→f2 give readable progressive loading. f2→f3 fails as above: a nearly standing lower body becomes a completed lateral fold in one exposure, with a new distant hand contact and much wider ground footprint. f3→f4 is a small settling hold. f4→f5 is a larger but coherent forward bow: the folded support stays legible and the head travels forward/down. f5→f6 deepens the same supported bow. f6→f7 lowers the chest/head and settles onto the limbs; its forearm change follows the body folding toward the floor. f7→f8 holds. f8→f9, f9→f10 and f10→f11 change substance/opacity into ash rather than perform further locomotion. The coarse kneeling arrival is also readable as a jump in the 90ms runtime sequence, even though the overall sequence unmistakably reads as death.

**Dissolve and cleanup.** f9 introduces a pale ashen body silhouette and a small basal ash heap; f10 greatly weakens the body and strengthens the heap/flecks; f11 leaves ash alone. The pale shift is a visible material change, appropriate to the ashen treatment. It does not show a rectangular cutout, blood, dismemberment, conspicuous circular holes or stray opaque canvas borders. The body has already collapsed and settled before dissolution. All fixtures show a local mound at the original floor, an unlocked warm exit after the twelve samples, a reduced mound during the fade, and no boss/ash at cleanup. No premature exit unlock is shown during f0–f11.

**Lethal transitions.** For each resolution, right-idle, right-strike_recover, left-idle and left-strike_recover were individually inspected. The first lethal exposure preserves the visible standing or stooped posture rather than snapping a stooped boss upright. The stooped f0→f1 continuation stays close to its loaded entry; standing entry proceeds to the loading pose. Both share the f2→f3 failure. The metadata records eight actual whip-hit HP decrements from production 8HP to zero in each fixture, a 1080ms unlock sampled at approximately 1.083s, fade at approximately 1.142s and removal at approximately 1.208s. Those state records agree with the visible exit and disappearance sequence. These are isolated harness captures, not a physical-phone or full-arena playthrough approval.

## Every audit FLAG

| Rule / frame | Adjudication | Visual reason |
|---|---|---|
| A-11, boss_death f3: size +13.8%, height change 9.1% | DEFECT | Onion f2→f3 and the raw/runtime images show a sudden replacement of the planted-leg arrangement by the broad completed kneel and new hand contact. The area jump accompanies this visible pose discontinuity. Replacing f3 with a support-preserving halfway pose is required. |
| A-11, boss_death f6: size change 6.3%, height change 7.8% | ACCEPT | The back/head bow farther forward over the established kneeling support. Shoulder, crown, hands and leg armor remain identifiable and at plausible physical size. Increased overlap changes visible area; no independent limb teleport or actor rescale is apparent in f5→f6. |
| A-11, boss_death f10: size change 9.0%, height change 8.3% | ACCEPT | This is the declared dissolve: weaker corpse silhouette plus ash gathering at the floor. Loss of connected ink is the intended substance change, not a character-size error. |
| A-11, boss_death f11: size change 44.8%, height change 38.3% | ACCEPT | The residual body disappears, leaving the small ash heap and a few rising flecks. Its floor position follows f10, and later runtime captures fade the heap out. Mass/height continuity is not required for the vanished body. |

## Style, derivation and coverage

All five registered style-lock images were opened: `art/frames/style_hero_neutral/f000.png`, `art/candidates/style_hero_attack_key.png`, `art/candidates/style_enemy_pursuer.png`, `art/candidates/style_terrain_patch_3x3.png`, and `art/review-style-v3/style_env_mockup.png`. Painted corroded armor, desaturated decay cloth, soft edges, upper form lighting and the quiet ash treatment fit these illustrations. Boss/hero scale and silhouettes remain readable in the actual phone-size samples. The death remains within the no-gore line.

The pack's original mandatory contract, local review contract, scope, clip durations/classes, derivation index and death derivation were read. The scripted loading, generated folded keys, registrations and erosion are disclosed. The derived mandatory sequence does read as collapse→settle→ash; that intent does not excuse the f3 motion discontinuity. No whip composite is supplied or required for this body-only death scope. The whip visible in lethal captures is context for the actual lethal hit, not a newly reviewed attack asset.

Coverage completed:

- `lineup_boss.png`, all four `strip_*.png` and all four `onion_*.png` opened. Every onion pair was inspected: death 11, idle 8 including seam, walk 8 including seam, recovery 5.
- Every delivered frame opened separately at original native pixel size: death f000–f011, idle f000–f007, walk f000–f007, recovery f000–f005; 34 raw PNGs total.
- Both capture manifests read; every referenced actual PNG opened through unscaled full-scene sheets in `inspection/`: `native-{0,1,2,3}-{0,1,2,3}.png` and `phone-{0,1,2,3}-{0,1,2,3}.png`. These preserve each complete image at its original 1280×720 or 698×393 size with labels added outside the image. Four fixtures × sixteen samples = 64 native and 64 phone samples, 128 total. Each fixture includes before, all twelve death frames, unlock, fade and cleanup. No sample was substituted with a source sprite.
- All four audit flags adjudicated above. No required image is missing or left unopened.

Approval is withheld for one mandatory clip. Correct f3 and use a fresh independent reviewer after rebuilding the pack and captures.

REVIEW: FAIL (1 clips)
