# Continuous production-stage acceptance

V7 previously had isolated checkpoint, death, boss and exit assertions plus stage-view captures, without a continuous spawn-to-exit run. `game/tests/stage_playthrough.gd` now drives ordinary movement, jump and fresh whip presses through the production map and live encounters. It does not teleport the hero, alter HP, grant invulnerability, call damage directly or disable enemies. The shared regression runner includes it.

The run hits the tutorial effigy, traverses both opening return steps and the gap/ground-enemy encounter, activates the checkpoint, enters the arena, defeats the original eight-HP boss and crosses the unlocked exit with five HP. Trace records include positions, health, checkpoint/exit transitions and final encounter states. Bypassing an enemy is allowed; this is a completion path, not a claim that every enemy was killed. Separate existing regressions exercise every enemy, both boss attacks, damage/death/retry and animation branches.

Early controller policies failed: r01/r02 never released jump at the second return step; r03 jumped into a pursuer at the far side of the gap; r04 lacked upward-step detection on the high route. Those traces are retained. The final policy releases between jump presses, reads solid step geometry and clears the pursuer before crossing. These are test-controller changes; production gameplay is unchanged.

Final headless Godot 4.7.2 run: PASS, including checkpoint, effigy and exit assertions. This is deterministic automated engine evidence at 120 Hz, not physical touch validation, an unfamiliar-player study, or proof of the proposed three-to-five-minute first-player pacing.
