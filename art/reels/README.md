# Timed source-art reels

From the repository root:

```sh
node tools/build-clip-reels.mjs
node tools/serve-reels.mjs
```

Open http://127.0.0.1:8081/art/reels/. The server binds only to localhost. `REEL_PORT` overrides its port.

Choose a clip, facing and display scale. Gameplay cadence derives from ActorVisual and Rules; Contract clock shows the unscaled contract durations. Pause, replay, step or scrub. Non-looping clips hold their final frame. The neutral reference has no applicable duration. Pivot and hand socket overlays are optional.

Phone and compact scales include both the runtime 0.5 source scale and the 720-unit viewport downscale. Native source and native game scales are separate options. The source-art viewer does not recreate the stage camera, prove a state transition, replace an engine capture, or grant visual approval.

The inventory currently has68entries,64complete sequences and4missing sequences containing34frames. Missing paint is explicitly NOT-TESTED. New assets require rebuilding the inventory; this file's counts are a dated snapshot, not an acceptance gate.
