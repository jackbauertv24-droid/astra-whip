# Independent animation review — swooper dive r01

Scope: new `swooper_dive`, with unchanged `swooper_cruise` and `swooper_dive_telegraph` as identity/motion/handoff references. This is a partial pack; its 61 missing inventory clips are outside this review. Recovery artwork is pending, outside scope, and **not approved** by this verdict. No builder verdict was supplied or used.

Blind evidence is saved in `blind_observations.md`: every lineup/strip was opened before metadata, contracts, intent or audit. Every individual native frame (8 cruise, 4 telegraph, 4 dive) and all three onions were inspected, including cruise f007→f000. Read prompts/ART_REVIEW.md, ART_CONTRACT, ART_BIBLE, the swooper ASSET_BRIEFS entries, contract clip/actor entries, pack clips/derivations and audit. Visually inspected both painted source keys and all five paths registered in art/style-lock.json. Inspected preparation scripts/rig declarations and every before-tell, dive-frame and recovery-entry capture in both evidence/swooper-dive-native and evidence/swooper-dive-phone, plus both completed capture.json files.

| Clip | Verdict | Failing frames | Defect / smallest correction |
|---|---|---|---|
| swooper_cruise | PASS | — | Complete consistent wraith; both outer wings flex relative to the fixed central body. Slow restrained wingbeat is visible, with a continuous f007→f000 return. No correction required. |
| swooper_dive_telegraph | PASS | — | Full narrow folded silhouette is present from f000 through f003. Small membrane/hood/cloth action supports a held warning pose. No correction required. |
| swooper_dive | PASS | — | Same folded creature pitches into a rightward dart over 240 ms, retaining hood/body scale and wing/cloth attachment. Rapid f001→f002 pitch is readable and purposeful. No correction required. |

## Identity, scale, style and facing

All delivered frames retain the shrouded hood, central binding/torso, bony folded or spread wing structures and long shredded lower cloth. This is a legless airborne creature by design, not an incomplete humanoid. There are no visibly missing anatomical pieces, clipped tips, stray substantial debris, opaque plates, or unexplained costume swaps. The hood cavity faces right; cruise is more frontal in its wings but the hood remains directed right. Both mirrored engine directions remain plausible.

Folded wings reduce envelope and visible area relative to cruise without making the hood/body a smaller creature. Dive's shortened vertical extent is a rotation of the same long cloth body. The painted material treatment—muted bone-grey edges, weathered cloth and dark cavities—sits coherently beside the registered pursuer/hunter and masonry references. No bright signal decoration, gore, pixel-art treatment or conspicuous style mismatch is visible.

## Motion and continuity

Cruise f000→f001, f001→f002, f002→f003 and f003→f004 progressively draw the wing tips inward/downward while preserving the shoulder joins; f004→f005→f006→f007 reverses the outer flex. The final f007→f000 increment completes that path without teleporting a limb. The body/tail are comparatively fixed, and this remains a modest scripted wingbeat, but the wing articulation itself is visible: it is not a whole drawing translated up and down.

Telegraph f000→f001→f002→f003 stays deliberately folded. Onion differences are small and localized, principally the lower cloth edge and hood/membrane tension. A held 600 ms tell need not beat its wings; its broad-to-narrow distinction from cruise is strong. This review does not mistake the quiver for a large flap.

Dive f000→f001 pitches the same folded body farther right; f001→f002 turns it sharply into the low-pass posture; f002→f003 keeps the attack angle while cloth/strut contours flex. The final pair is close, as observed blind, but not identical. The action's dominant motion is whole-body pitch; the independently changing wing strut and cloth curvature add enough local response for this very short tucked attack. It reads as a committed diving creature, rather than a cruise picture rigidly floating sideways. It is not a looping locomotion wingbeat, and should not be reused as one.

The telegraph f003→dive f000 handoff preserves the same painted folded identity, with a roughly 20-degree initial pitch rather than a replacement silhouette. The before-tell and initial attack captures show no body-center recentering jump. Source implementation rotates about [192,128] and applies localized deformations; no global scaling is introduced. Apparent extremity motion around that body center is expected. The subsequent 40→80-degree step is abrupt, but at 60 ms per frame and with the accompanying descent it reads as the attack acceleration, not a changed body.

## Audit adjudication

- **A-11 FLAG, dive f001 (f000→f001): size 1.6%, height 28.1% — accepted.** Onion inspection shows a continuous pitch about the torso with conserved hood/body dimensions; vertical extent falls because the long silhouette rotates toward horizontal. No shrinking or limb teleportation is visible.
- **A-11 FLAG, dive f002 (f001→f002): size 0.6%, height 21.9% — accepted.** This is the largest angular change, but the same folded struts, hood and cloth remain attached. Height is an unsuitable scale proxy for this rotated attack; the rapid turn matches the short attack timing and engine descent.

There are no other reported audit flags or automated defects in this scoped pack. Numerical passage alone was not used to approve motion.

## Derivations and engine evidence

All three clips explicitly declare `scripted_fallback` source/method/reason. Visually, the broad painted key matches cruise and the folded painted key matches telegraph/dive; none invents a replacement face or central body. The scripts implement the declared separate outer-wing deformation for cruise, localized folded anticipation for telegraph, and center pitch plus independent strut/cloth deformation for dive. Each reads as its declared action and is acceptable under ART_CONTRACT §11; the declared scripted fallback quality debt must remain in the release handoff.

Both capture.json files identify engine captures, **not physical-device tests**. Native 1280×720 and phone-labelled viewport captures show the natural folded tell immediately before both rightward and leftward attacks, then all four frames. Reported elapsed samples 0, 0.0667, 0.125 and 0.1833 seconds, approximately 0.2417-second attack duration, 300 u/s horizontal movement and 64 u low-pass altitude agree with a rapid 240 ms low attack. The visible screen progression agrees: descend rapidly, pitch toward horizontal, then travel through the low band. At the supplied phone display size, fine membrane action becomes subtle, but the pale narrow silhouette, direction of travel and steep-to-flat posture change remain readable against the masonry. Neither mirrored direction visibly clips or flips identity.

The inspected recovery-entry captures visibly switch to a simple unpainted placeholder. That is a real outgoing visual discontinuity for the eventual complete enemy sequence. It belongs to the pending recovery artwork and is **not approved or waived** here; a complete swooper/release acceptance must replace and independently review recovery and its dive→recovery handoff. This scoped PASS approves the active dive and unchanged reference clips only.

Whip composites, effect progression and grounded foot/crouch rules are not applicable to these three legless flying clips.

REVIEW: PASS
