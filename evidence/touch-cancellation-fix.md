# Touch cancellation clears the input layer

GAMEPLAY_RULES §3 requires focus loss, touch cancellation or pause to clear all held inputs. Previously a canceled finger released only its own source; a second finger and keyboard source stayed held, with buffered press edges intact.

The cancellation branch now clears Controls before returning. Ordinary touch release still affects only its own source. Eleven engine checks exercise keyboard plus two fingers, ordinary release, cancellation, buffered edges and fresh input afterward. Before: four failures. After: zero failures.

A separate stale-drag regression failed twice before guarding drags with the active-touch registry. Cancellation and pause clear that registry; only fresh touch-down registers a finger. Final eleven checks pass. The intermediate failing full-suite log is retained.
