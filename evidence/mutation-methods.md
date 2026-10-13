# Deliberate failure cases

`tools/test-game.sh --mutations` re-runs the real headless engine suite with one
`ASTRA_MUTATION` switch per run. Production/default execution has no mutation.
Each run must exit nonzero and report a failure in the corresponding test group;
a parser crash or an unrelated failed assertion does not count.

| Test | Deliberate defect |
|---|---|
| T-01 | Keep the standing collision shape on crouch entry. |
| T-02 | Count one-way slabs as solid ceilings in standing clearance. |
| T-03 | Disable grounded horizontal movement, creating trapped traversal samples. |
| T-04 | Reduce jump launch speed to 60% of the specified value. |
| T-05 | Delay the active whip window until after its specified end. |
| T-06 | Route nonlethal damage to idle instead of the required reaction. |
| T-07 | Restore only 1 HP on restart instead of 5. |
| T-08 | Resolve opposing directions to right instead of neutral. |
| T-09 | Remove the actual crouch-enter animation resource. |

Some mutations also break dependent assertions in other groups. That is retained
in the full logs. Tests inspect collision shapes, positions, state transitions,
combat registries, and actual AnimatedSprite2D frames, rather than screenshots.

T-03 samples 229 reachable standing origins at 32-unit intervals. Exit vestibule
samples use the boss-defeated world state (the only state making them reachable).
Reaching completion counts as escape as required by the no-trap rule.

T-09 verifies the greybox state/clip binding and engine frame durations. It does
not attest to artwork, natural gameplay reachability of every enemy animation,
or the independent visual review; those are later gates.
