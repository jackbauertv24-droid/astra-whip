# Reachable phone menu controls — 2026-10-19

Existing menu buttons,toggle and sliders shrank below48CSS pixels on phones. They now retain at least64CSS pixels in height, with readable live labels/type. The menu lives in a viewport-bounded vertical ScrollContainer; all controls can be brought fully into view. Music and sound-effects sliders have clear labels without implementation-status tooltips.

Original baseline51checks reported33size/reach/container failures. Expanded final regression60checks passes at1280×720,852×393,667×375: control extents,full visible target,real GUI interactions,bounded panel/scroll area and pan gestures. Theme minimum-size updates settle before assigning scroll bounds,avoiding startup width overflow. Full gameplay1234assertions,all focused regressions,contract,25case art selftest and export pass.

A browser test caught a limit of the native pan proxy: pointer drags over child buttons were blocked despite passing pan gestures. Menu controls now pass events to the ScrollContainer; an8CSS-pixel drag threshold protects taps. Retained before-drag browser records show unchanged scroll views. Fresh Chromium touch swipes at device scales1and2 reach both volume controls; inspected screenshots show thumb changes and subsequent gameplay resume with0browser errors. The combined run completed its records but returned143during process teardown; isolated density1and2runs each exited0. Scripts,captures and all exits are retained.

This is desktop/browser evidence. Physical-device,painted UI inventory,safe-area and remaining art/atlas gates are still pending.
