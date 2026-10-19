# Pause/resume touch target — 2026-10-19

The original60unit-high button became32.75rendered pixels at852×393 and31.25px at667×375, below SPEC §6's48CSS-pixel minimum. It was18.42px high at393×852. The control now uses inverse viewport scaling to retain at least64×64rendered pixels, including live window resizing. Its right anchor remains inside the logical content viewport.

Graphical before/after regression:16checks,4failures before→0after, at1280×720,852×393,667×375 and393×852. Both pause and resume are activated through real GUI hit testing at the enlarged lower edge. Default headless gameplay/regressions also pass. This verifies the pause control,not the portrait prompt or other menu targets.

Chromium156 touch emulation at852×393/deviceScaleFactor1 dispatches touch at724,70: below the old button bottom and inside the enlarged control. Inspected resumed/paused screenshots show gameplay→menu transitions and the correct PAUSE/RESUME label;0browser errors. This is desktop browser evidence,not physical-device testing. Reproducible browser script retained next to the screenshots.
