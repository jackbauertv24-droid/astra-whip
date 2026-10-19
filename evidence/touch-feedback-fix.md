# Gameplay button pressed feedback

Gameplay buttons use the shared Controls held state for their pressed appearance, updated each display frame without emitting button signals. Keyboard and multiple touch sources share the same appearance; releasing one source preserves feedback while another remains held. Pause, cancellation and completion remove the pressed appearance.

The 25-check regression fails 12 checks before and passes after, covering all five buttons, multiple sources, pause/resume and actual touch/drag/cancel events. A compact density-2 Chromium capture shows the held LEFT button darkened; 10,410 of 10,660 sampled pixels change by more than 12 channel values after release. This supports runtime feedback only, not approval of the still-pending painted UI inventory. Browser errors: none. Full engine suite, contract check and 25-case defect selftest pass.
