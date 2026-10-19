# Independent ART_CONTRACT §9 review — boss strike r02

Scope: boss_strike_windup, boss_strike_execute, boss_strike_recover. Idle, walk and hurt are contextual references only. No hazard, death or release approval. Fresh reviewer did not create the art or read earlier verdicts or builder notes.

Protocol and evidence: first opened only lineup_boss.png and the six strip images, saved plain per-tile descriptions in blind_observations.md, and read that saved file before reading intents, audit, manifests or contracts. Subsequently inspected all 36 native tiles using true-alpha-over-grey contact sheets, all six onion sheets including idle/walk loop seams, ART_CONTRACT, ART_BIBLE, boss ASSET_BRIEFS, machine contract, scoped audit and derivation/source construction. Opened all five images named by art/style-lock.json. Inspected every one of the 64 current PNGs in each of evidence/boss-strike-native and evidence/boss-strike-phone, covering both facings, full cycle and both actual two-whip punish branches. Lossless crop sheets and their filename order are retained in inspection/. Wider crops include both actors and the complete moving arm; full-scene native and actual 698×393 phone captures were also opened for scene/UI context. Crops preserve source pixels; they are not upscaled phone substitutes. Read capture.json, capture_boss_strike.gd and relevant foe state/hit logic. The supplied capture harness was inspected rather than rerun.

The frozen pack's three strike clips are byte-identical to current art/frames copies. Production construction is boss-strike-r03 despite the review-pack revision r02 name. The current prepare script and r03 execute derivation agree on fixed clavicle (215,233), original 79.06px upper arm, approximately68.54px forearm and29.27px hand segment, with articulated execute and a4–5 degree recovery bow. No art/code was changed by this review.

## Shared visual findings

Full anatomy is present throughout: crowned closed helmet, neck/shroud, corroded shoulder/chest plate, two separate plated legs and boots, small rear arm and deliberately oversized striking arm. Figure scale, head size, cloth identity and foot origin stay stable. Painted metal and ragged olive cloth fit the five style-lock references' treatment and the revenant description. The shoulder-to-arm transition is narrow and cloth-heavy in windup F2–F6, but remains physically connected to the same clavicle; it does not visibly lengthen bones. No isolated old forearm, extra hanging fist, detached fragments, clipping or opaque keyed rectangle is visible. Source assembly explicitly removes disconnected old-arm components and retains the shoulder cap behind the moving limb. No gore or new warm enemy accents.

The helmet remains a closed masked silhouette in both facings; a human facial expression is neither present nor required. The hero's human face and warm costume remain identifiable in the supplied phone scenes. Small face detail is naturally limited at this display size. The tree/architecture shares some dark lines with the boss, but the raised fist and arm still change the silhouette conspicuously in both facings.

## boss_strike_windup — PASS

F0–F3 progressively rotate the oversized arm from thigh-level through forward and upward extensions. F4–F6 hold the fist above the helmet without whole-body growth, boot movement or limb disconnection. The arm is unusually long by design; native tiles and source fixed-length segments support a consistent oversized limb rather than per-frame stretching. The held pose is readable in actual phone pixels and materially different from idle. The supplied geometric record reports472px at F4–F6 against352px neutral (1.341×), a stable300ms hold. This matches the visible approximately one-third silhouette increase.

The seven100ms samples sum to700ms. Both captured full cycles enter execute at700ms. Idle/walk neutral into F0 is coherent. F4→F5→F6 is intentionally held, not a missing action. Failing frames: none.

## boss_strike_execute — PASS

F0 bends the elbow forward, F1 drives the fist outward/downward, F2 releases toward the side, and F3 settles to the low arm with a small body bow. The windup F6→execute F0 boundary is a very fast large downward arc; it reads as the deliberate release of the held attack rather than identity replacement. A slower attack would need more transitional drawing, but the50ms execute samples make the abruptness appropriate here. The elbow bends with preserved segment lengths, fist remains joined at the wrist and no old neutral arm remains underneath it.

F0–F1 are visibly the forward danger poses; their path plausibly occupies the approximately100u forward strike neighborhood. The paint does not suggest a much longer attack than the implemented lane. This is a visual reach judgment, not a claim that the entire150u-tall rectangular gameplay zone is literally covered by fist ink at once. The four50ms frames total200ms; the implementation makes only the first100ms live. The capture's208.33ms execute duration is one120Hz step beyond nominal, consistent with its sampling boundary. At145u spacing the hero remains unhit and beyond the forward fist in both facings. No critical anatomy/scale pop at execute F2→F3. Failing frames: none.

## boss_strike_recover — FAIL

Failing frames: F0–F4, especially the long F0–F3 holds. F5 is a correct neutral endpoint but does not rescue the preceding action.

The intended supported, exhausted recovery does not read. Blind description independently identified these as upright standing poses with the fist hanging. Native tiles reveal only a small forward rotation; the chest/head remain close to the ordinary neutral stance, boots and knees retain the same upright support, and there is no convincing heavy-arm load, brace, lowered center of mass or labored release. At actual phone size the4–5 degree bow is too subtle to distinguish the first800ms from a standing rest. The long opportunity to punish is mechanically present but its exhausted visual state is not communicated. This fails §9 and §11's requirement that a derived clip read as its intended action; zero audit findings cannot approve that missing acting.

Execute F3→recover F0 is a clean matching pose. Recover F0→F1→F2→F3→F4 progresses without an anatomical break, and recover F5→walk F0 returns cleanly to the shared neutral. Thus this is an action-read failure, not a foot-line/identity/seam defect. The six durations200/200/200/200/150/150 total1100ms, and captured1108.33ms recovery is within one120Hz step. A fix should make exhaustion clear through visibly supported torso/hip/knee/arm acting at phone size while retaining grounded feet, body-part dimensions and coherent entry/hurt/resumption/exit transitions.

## Actual two-hit punish and resumption

Both directions use real hero whip inputs after a naturally completed tell/execute, not directly assigned hurt frames. In both capture.json branches boss HP goes8→7→6, two500ms hero commitments finish, each hit supplies all three hurt frames, hero HP stays5, and the original recovery deadline leads to walk at1108.33ms. First hurt starts at approximately158ms and second at667ms after recovery entry. Resume samples return to recovery at approximately367ms and875ms. The harness and foe code preserve elapsed recovery time across hurt; the evidence is consistent with those clocks.

Visually the two small flinches and their returns are coherent in both native and phone images; helmet, plate and feet do not change identity or root. However, these transitions currently resume the same near-neutral standing recovery, so they inherit the recovery-read failure. A stronger replacement recovery must be re-reviewed through these actual interruptions; passing the present shallow transitions does not pre-approve later ones.

## Audit adjudication and limits

Scoped audit: six clips,0 DEFECT,0 FLAG; no flags to waive. Idle breathing, walk loop wrap and hurt references show stable identity/root and no blocking continuity problem for the scoped strike. They receive no separate new approval here. Mechanical timing, held tell, coverage and HP evidence are accepted as supplied and code-consistent. This is still-image/onion/sequence review with declared durations, not a newly watched real-time recording or physical-device test. Phone images are current engine captures marked physical_device:false. No collision mutation/contact test was rerun, and no exact per-pixel hitbox overlay is present in these128 captures. Full release, hazards, death, unrelated art and performance are outside scope.

Overall: the warning and strike meet the scoped visual gate; the recovery's supported exhaustion is insufficiently readable and blocks acceptance of the three-clip action set.

REVIEW: FAIL
