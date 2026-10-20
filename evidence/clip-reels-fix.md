# Timed clip evidence

ANIMATION_SPEC completeness evidence requires timed reels at intended cadence and phone display size. Added a local source-art viewer for every67contract/supplemental entry.58source sequences are complete;9sequences containing62frames remain missing and explicitly NOT-TESTED. Reels are not art approval or proof of engine transitions.

Playback uses each frame duration, with runtime hero walk and pursuer approach cadence derived from the authoritative GDScript constants. Contract clock mode remains available. Non-looping clips hold their final frame; static neutral reference duration is not applicable. Controls support facing, replay/pause, stepping, scrubbing and source/native-game/phone/compact scale. Body and whip are composited with the authored pivot and hand occlusion. Optional pivot/socket overlays do not modify assets.

A controlled-RAF Chromium harness passes569checks across67entries: every frame midpoint at runtime cadence, loop/final-hold behavior, missing labels, exact50ms boundary, exact mirrored body/whip pixels and phone scaling. Desktop and698×393CSS viewport captures are retained. Browser errors:zero. This is not a physical-device study or independent visual verdict.

The initial inventory's actor-directory mapping incorrectly marked whip and style frames missing. That mapping was corrected before acceptance. Earlier phone preview scaling omitted viewport downscaling; its browser result and screenshot remain as before-phone-scale evidence. Final scale includes source0.5×393/720 and is checked numerically and visually.

Reproduce with `node tools/build-clip-reels.mjs` and `node tools/serve-reels.mjs`. The retained browser harness requires Playwright; this run used the installed /tmp/astra-browser environment. Contract check and25-case defect selftest pass. Product export is unchanged by this evidence-only fix.
