# Independent review — static UI controls r01

Reviewer: /root/ui_controls_review_r01. I did not create, extract, edit or audit these assets. Scope is six static UI assets, twelve normal/pressed frames. This is not approval of actor/VFX animation, traversal, physical devices, or other UI inventory. The original animation contract is unchanged.

## Protocol and evidence

Individually opened lineup and all six strips first; wrote `blind_observations.md` and read it back before opening index, intent, audit, metadata or contracts. Then read ART_CONTRACT, ART_REVIEW, ART_BIBLE, ART_DIRECTION, ASSET_BRIEFS and ASSET_SPEC, the machine animation contract, supplied review contract/scope, all six derivation records and audit. Individually opened all twelve raw frame PNGs and all five style-lock references. Individually opened every one of the nineteen engine PNGs listed below and all four final browser PNGs; read both capture JSON files and browser harness. Builder pass labels were not used as visual proof.

## Asset findings

| Asset | Result | Failing frames | Visual finding | Smallest correction |
|---|---|---|---|---|
| ui_btn_left | PASS | — | Clear left arrow, complete stone plate, stable scale; pressed amber inset is obvious. LEFT reads at compact phone size. | None |
| ui_btn_right | PASS | — | Clear right arrow matching left's weight and material; pressed state distinct without losing the arrow. RIGHT remains legible. | None |
| ui_btn_jump | PASS | — | Upward arrow has clear shaft/head silhouette; normal and pressed share consistent footprint. JUMP reads cleanly below it. | None |
| ui_btn_whip | PASS | — | Coiled whip and short handle survive phone scaling; pressed rim is distinct. WHIP does not obscure the identifying coil. | None |
| ui_btn_crouch | PASS | — | Bent head/torso/knees silhouette reads as a crouching figure, rather than an arbitrary mark. CROUCH is the widest label and extends beyond the painted plate at compact size, but remains whole, high contrast, uncropped and separated from adjacent controls. | None |
| ui_btn_pause | PASS | — | Two clear ivory bars; normal/pressed change is visible. Live PAUSE, RESUME and disabled PAUSED words remain readable. Menu-to-gameplay browser captures show the live resume affordance operating at its lower edge. | None |

## Cross-asset and alpha findings

All twelve raw states have the same painted matte slate/violet material, worn beveled frame, bone icon color and broad form lighting. They fit the approved terrain/environment references and avoid photorealistic, whimsical or pixel-art styling. Amber is reserved here for an active interactable state. No lettering is baked into the textures. No visible hard rectangle, clipping, loose debris or halo was seen.

Independent source-pixel inspection using the PNG decoder found 128×128 canvases throughout and all four corner alphas zero. At alpha≥40 the inclusive bounds are x14..114 and y15..112 across the set, leaving at least13px exterior margin. Normal/pressed differences of at most one source pixel in plate bounds are visually negligible and do not produce a control that changes size. The documented whole-sheet conversion and integer registration are acceptable for static UI; the delivered states do not show per-state deformation. The clipped alpha≤8 residue noted in derivations is not visible in raw or engine views and is acceptable.

The gray normal versus amber pressed rim remains immediately distinguishable in all individual pressed captures, compact all-held and density2 all-held. Icons retain clear light/dark contrast; neither the crouch figure nor fine whip line disappears at the compact target.

## Runtime inspection

Individually inspected: native-normal; native-pressed-left/right/crouch/jump/whip/pause; phone-normal; phone-pressed-left/right/crouch/jump/whip/pause; compact-normal; compact-all-held; density2-normal; density2-all-held; portrait-disabled (all under evidence/ui-controls-captures).

The supplied compact captures and browser viewport correspond to the minimum64CSS targets with16CSS live labels. Text is readable at that display size. The translucent exterior gives the controls comfortable spacing even though their painted plate occupies less than the touch rectangle. The compact CROUCH word overhang is readable and does not collide with JUMP. Controls sit inside the phone edges; the browser's44CSS left/right and21CSS bottom safe-area scenario keeps the control row and pause/resume affordance clear of the excluded margins. Menu and gameplay words remain usable; the pressed whip image in the held browser view returns to normal after release.

Individually inspected evidence/ui-controls-browser-2-menu.png, -gameplay.png, -held.png and -whip.png. The matching JSON reports a568×320CSS viewport, device scale2, safe insets44/44/21, resume touch at(484,68), and no browser errors. The menu RESUME word changes to PAUSE after the recorded touch; the held whip rim is amber and the release capture is gray again. These images establish presentation and the demonstrated resume/hold/release transition; they do not establish actor attack animation.

The portrait-disabled capture hides all five gameplay touch controls and shows the rotate/game-paused prompt. A dim disabled PAUSED indicator remains visible at top right and does not compete with or overlap the prompt. This agrees with the inspected portrait visibility logic and is acceptable.

## Audit flags and limits

Supplied audit has zero DEFECT and zero FLAG; there are no audit flags left unadjudicated. Blind concerns about small whip details, crouch recognition, alpha margins, label readability and pressed distinction were resolved by the individual raw/runtime views above. No missing PNGs or browser JSON. No onion/composite timing review applies to these two static UI states; this verdict grants no exemption to timed actor/VFX requirements.

REVIEW: PASS
