# CSS density and portrait prompt layout — 2026-10-19

The pause target fix initially counted backing pixels. Chromium at852×393uses1704×786backing pixels at device scale2 and2556×1179 at scale3; the button could therefore remain below SPEC §6's48CSS-pixel minimum. The UI scale helper now divides viewport backing scale by the canvas backing-to-CSS ratio, preserving the64CSS-pixel target. Rotate typography uses that same conversion.

Real browser before/after: at scales2and3,the identicalCSS touch724,70 leaves the old paused screenshot byte-identical but resumes gameplay after correction. Both after screenshots were inspected:menu absent,PAUSE label visible. Console/page errors are empty. Native pause16checks and portrait18checks remain passing. No physical-device result is claimed.

The density test also exposed Label's cached wrapped minimum height during startup. Fixed two-line rotate text now has no auto-wrap and is centered in the full viewport after font sizing. New startup fixture9checks,6failures→0across1280×720,393×852,375×667. Actual device-scale3portrait ink center offset242→6.5backing pixels (30pxfixture tolerance); retained image-based before/after checker fails then passes. Current web export and25case art-tool selftest pass.

Remaining menu targets,safe-area/art inventory and device/player validation are separate pending work.
