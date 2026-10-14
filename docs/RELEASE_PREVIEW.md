# Public preview

The user authorized a change in priority on 2026-10-14: "just round up the work and push it to repo. relax constrain as the priority now is to get a product out."

This preview packages the implemented slice without claiming the remaining upstream production-art gates passed. The original contract and review evidence remain intact.

Implemented: deterministic movement and collision, coyote time/jump buffering, crouching, grounded/air attacks, damage/recoil/knockdown/death, checkpoint resets, three enemy types, two boss attacks, arena gates, victory, keyboard/touch controls, pause and focus handling.

The preview integrates the painted hunter frames, selected attack keys, pursuer calibration image, background and masonry. Incomplete crouching/air attacks use held body poses with an engine-drawn whip. The pursuer uses a static painted pose; other enemies use engine silhouettes. Some hero transitions failed independent motion review. The art is preview quality, not an approved full production inventory. Music/SFX production remains deferred.

Desktop automated gameplay validation and a single-threaded web export are recorded in evidence. Physical iPhone testing and an unfamiliar-player study have not been performed. No on-device performance, final atlas memory budget or complete animation compliance is claimed.

The full source, generated candidates, rejection evidence and contract tools are included so further work can resume from this checkpoint.

## Follow-up fix: get-up

Get-up now shows a supported floor-to-standing recovery and ends in a stable neutral pose. Its scoped audit and fresh independent motion review passed; timing and gameplay behavior are unchanged. See `evidence/getup-fix.md`. Other production-art/device gaps remain pending.

## Follow-up fix: turning

The repainted turning pose passed its fresh independent motion/identity review. Real input-driven engine captures confirmed the facing transition at 75 ms. See `evidence/turn-fix.md`.
