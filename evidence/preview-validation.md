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
- Public repository: https://github.com/jackbauertv24-droid/astra-whip
- Pages deployment workflow 38571468172 completed successfully.
- Deployed `index.pck` returned HTTP 200 and SHA-256 matched the local build: `636d85911d23ebb09f606707552e5b0cab25d605fd16a4ec90893c5fc6b8f41c`.
- Live Pages URL also passed the Chromium startup/movement/whip smoke test with zero console/runtime errors.
