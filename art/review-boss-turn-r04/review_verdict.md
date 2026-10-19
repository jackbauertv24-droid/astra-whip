Independent scoped visual review — boss_turn r04

Scope and protocol

This reviewer did not produce or edit the art/code. First opened only lineup_boss.png and the three strip images. Saved plain per-tile observations to blind_observations.md and read that saved file back before reading intents, index, audit, contracts or derivations. Did not read aborted reviewer notes, earlier review verdicts or builder verdicts. This is approval of boss_turn with idle/walk reference continuity only, not release-wide approval.

Evidence inspected

Reviewed all 20 native frame PNGs (eight idle, eight walk, four turn) in alpha-composited, unscaled figure contact crops, the lineup/three strips and all three onion sheets including idle/walk last-to-first seams. Composites use actual alpha blending against gray; transparent RGB was not mistaken for visible matte. Read ART_CONTRACT, ART_BIBLE including its implementation style-lock register, boss ASSET_BRIEFS, machine boss actor/turn contract, scoped audit JSON/Markdown and metrics, current derivation records, prepare-boss-turn.mjs, r07 normalized generated source key and normalization record. Viewed every one of the five images listed in art/style-lock.json. No Python was used.

Inspected all 12 PNGs in each of evidence/boss-turn-native and evidence/boss-turn-phone: before-walk, turn f00–f03, outgoing walk f00 for both directions. Viewed native boss crops and full phone capture contact sheets, then native-pixel phone boss crops. Read both capture.json files and the capture harness. These are current runtime captures, rather than a source strip interpreted as runtime.

Per-clip findings

boss_idle — PASS as reference. Full crowned head, neck, armored chest, two attached arms, hips, two plated legs and boots remain present throughout f000–f007. Shroud occludes parts of thighs without substituting cloth for legs. Small inhale/cloth movement is restrained but visible in the native comparison. Head, armor identity and oversized gauntlet stay stable. Soles remain planted; f007→f000 has no conspicuous size or position seam. The palette, worn matte plate and ragged olive cloth fit the painted gothic style lock. Local scripted breathing remains declared quality debt; no new blocking issue in this scope.

boss_walk — PASS as reference. f000–f003 advances one bent knee/boot; f004 exchanges support under the shroud; f005–f007 advances the opposite leg. Shroud overlap at f003–f005 makes the leg joins less readable than unobscured knees, but connected plated lower legs and boots remain intelligible. This is a stiff warden gait with limited upper-body response, rather than a missing-body or shrink animation. The f007→f000 seam continues the alternating step without a scale reset. Identity and relative standing height remain consistent with idle. This scoped review does not reapprove locomotion speed or the entire walking behavior.

boss_turn — PASS. Source f000/f003 are the accepted neutral endpoint; source f001/f002 reuse one generated frontal key. The source strip alone therefore looks like an inward pose and return, and the identical midpoint pair is not evidence of two distinct source angles. Actual runtime uses incoming facing for f000/f001, switches facing at f002, and uses outgoing facing for f002/f003. I judged that actual sequence in both directions.

The frontal key changes the shoulder overlap, chest plate presentation, belt/hip symmetry, both knee/boot directions and shroud distribution together. Rotation is supported through chest and hips, rather than a head-only turn pasted on an unchanged body. It keeps two boots grounded while the stance opens toward the viewer. The resulting four keys read as incoming three-quarter → frontal/inward-arm → opposite frontal/inward-arm → outgoing three-quarter. The change of orientation is readable at the supplied phone pixels.

The asymmetric gauntlet is the most demanding continuity point. It moves from a hanging outer silhouette toward the belly, crosses to the opposite side in the mirrored frontal midpoint, then opens outward to the outgoing hanging silhouette. The forearm remains attached through the shoulder/elbow construction. Although the central 75 ms sample boundary is stepped, the gauntlet positions follow the turn across the body instead of jumping from one distant outer silhouette directly to the other. The head similarly progresses from the incoming offset to central frontal alignment and then the outgoing offset; it does not independently teleport or visibly change helmet size. Frontal chest/cloth detail is somewhat broader and warmer than the side key, but remains consistent with the same crown, neck shroud, corroded plate, segmented legs and single oversized striking arm. No blocking identity replacement or anatomy defect is visible.

Turn size and handoffs

Metrics agree with visual inspection: endpoint height 352, midpoint 353; head width 53 versus 52; S 202.598 versus 213.145 (about 5.2% adjacent change). The midpoint's greater area corresponds to the exposed frontal chest/legs, not uniform actor enlargement. Its foot is one pixel lower, within the contract tolerance. No clipping, detached substantial debris, chroma matte or rectangular alpha background is visible. Audit reports zero DEFECT and zero FLAG; no flags require waiver. This does not turn the audit into visual acceptance: the actual orientation and arm path above supply the visual adjudication.

Before-walk→turn f000 and turn f003→outgoing walk f000 reuse the same neutral support in the matching facing. Both runtime sequences show stable root/ground registration and no entrance/exit size pop. The turn is not a loop, so f003→f000 is not its production seam. Idle/walk looping seams were checked separately.

Timing/runtime adjudication

Both capture records report exactly one facing flip at 150 ms, four 75 ms turn frames, a 300 ms turn and natural outgoing walk entry, with fixed position and production 8 HP. Captured f003 occurs at approximately 233 ms because simulation samples are discrete; this does not contradict the 225–300 ms frame interval. The screenshots show the expected reflected body at the event in both directions, matching capture metadata. PNG IHDR measurements confirm all twelve phone PNGs are 698×393, while all twelve native PNGs are 1280×720. The phone capture.json viewport field says 852×393; that is metadata, not the delivered PNG width. At the actual 698×393 image size the boss remains a legible large armored threat; the broad frontal cue and changing gauntlet silhouette survive reduction. The staged inward-arm frontal cue provides a usable short turn telegraph.

Limits

This is a four-key, deliberately stepped 300 ms turn, not smoothly interpolated rotation. The duplicate source midpoint relies on the existing runtime flip; displaying the source frames without that flip would not earn this verdict. Review uses stills, adjacent onions and verified timing/capture code, not a physical-device playback observation. Both capture.json files explicitly say physical_device false. The phone viewport metadata differs from its 698×393 PNG dimensions, so this verdict describes the delivered 698×393 pixels and does not certify an 852×393 framebuffer or its display scaling. It approves no unprovided browser/device performance, attack tells, boss death, other clips or release-wide completeness. Declared neutral reuse and scripted reference animation quality debt remain recorded under D23; they do not hide a blocker in this scoped action.

REVIEW: PASS
