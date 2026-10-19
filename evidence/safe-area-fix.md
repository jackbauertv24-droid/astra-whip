# Web safe-area layout — 2026-10-19

CSS body padding did not constrain the Godot canvas: the browser probe reported nonzero padding but a full852×393canvas. UI layout now reads actual CSS safe-area insets,accounts for canvas position/backing density and letterboxing,and anchors HUD,pause,menu and grouped touch controls inside the safe rectangle. Group movement preserves control separation; touches use the relocated rectangles.

A custom shell derived from the installed Godot4.7.2template provides one viewport-fit=cover declaration and removes ineffective body padding. Template source hash/modifications are retained. No gameplay geometry or input timing changes.

Baseline120checks reported25unsafe-bound failures. Final expanded150checks pass across four window/inset arrangements plus a2×backing-resolution case:chrome bounds,64CSS pause target,all action bounds,upper-edge touch/release and no button overlap. Full gameplay1234assertions,all focused regressions,contract and25case art-tool selftest pass.

Chromium2×density emulates44/0/44/21and100/24/100/32insets. Inspected menu/gameplay screenshots use red test-only unsafe bands; HUD/controls remain inside clear areas. Metrics confirm reported CSS insets,single viewport tag and zero body padding. Release smoke exits0with no browser errors or diagnostic output.

A temporary logging-only build confirms the new whip upper-edge touch enters actual attack_ground and is live at0.191667s on touch release. Screenshot round trips missed the short active phase; no frame-timing/performance claim is inferred. Logging source/hash,raw trace and a check that logging was the only source difference are retained. Final release restores the uninstrumented source.

Physical-device validation remains pending. Play-plane clearance above thumb controls and remaining painted UI inventory remain separate work.
