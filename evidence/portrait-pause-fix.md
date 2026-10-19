# Portrait pause and rotate prompt — 2026-10-19

The old orientation test used the1280×720 logical game viewport, which stays landscape under letterboxing. Window rotation therefore neither paused gameplay nor showed a prompt. Detection now uses actual window dimensions, including resize events. Portrait clears held input, remains paused even through Escape/resume, hides the landscape menu/touch controls and displays live rotate/pause text. Landscape return restores the paused menu and requires explicit resume.

Before/after regression:18checks,12failures→0 at393×852 and375×667, with852×393returns. Default gameplay, prior16check pause-target regression and all focused checks pass. Contract/tools/export pass. Chromium156/deviceScaleFactor1 confirms both orientations, prompt visibility, held-input transition, paused return and explicit touch resume. Both portrait PNGs are byte-identical after Escape, confirming that attempt leaves the prompt/view unchanged. Screenshots inspected at original size;0browser errors.

This is desktop browser/native evidence,not a physical-device test. The required painted UI rotate graphic and broader UI inventory remain separately pending; the prompt wording is live UI text.
