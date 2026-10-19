# Gameplay touch target sizing

Five gameplay buttons now retain at least 64 CSS pixels in each dimension and 16 CSS pixel labels after window, density and safe-area projection. The three right actions share a lower baseline, with eight CSS pixel gaps and inset margins. Width includes the longest label. Pause is above menu hitboxes so its whole rectangle responds on compact windows.

Before: 180 checks reported 44 failures. Enlarged targets passed; a subsequent corner-click regression exposed menu interception, retained in action-touch-targets-corner-before.log. Final action_touch_targets has 190 checks and zero failures, including source release, all-pairs overlap, safe bounds and pause corner clicks.

Chromium at 568×320 CSS pixels, density 2, with 44px side and 21px bottom safe insets: actual lower-edge touch resumes; final gameplay capture shows PAUSE and no menu. No browser errors. Before-topmost browser captures are retained separately. This is desktop emulation, not physical-device evidence. Painted UI assets and playfield/thumb studies remain unfinished.
