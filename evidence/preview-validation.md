# Preview validation

- Upstream spec pinned at cf717cab22b39344820c11ef9aaf3a827336ce14.
- Godot 4.7.2 Compatibility renderer, 120Hz physics, single-threaded Web export.
- Gameplay T-01…T-09 PASS: 1,213 assertions, zero failures; 229 surface-origin samples.
- Contract checker PASS: 64 clips / 356 frames / 64 briefs cross-checked.
- Art-tools negative self-tests PASS: 25 defect cases, zero problems; see art-tools-selftest-r07.log.
- Final art inventory/animation gates NOT PASSED; preview release explicitly authorized by user.
- Physical iPhone performance and unfamiliar-player study NOT TESTED.
- Single-threaded release export completed without script errors.
- Headless Chromium 156 web startup smoke test: no JavaScript/runtime console errors; menu and gameplay screenshots are retained.
