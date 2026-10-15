# Public preview

The user authorized a change in priority on 2026-10-14: "just round up the work and push it to repo. relax constrain as the priority now is to get a product out."

This preview packages the implemented slice without claiming the remaining upstream production-art gates passed. The original contract and review evidence remain intact.

Implemented: deterministic movement and collision, coyote time/jump buffering, crouching, grounded/air attacks, damage/recoil/knockdown/death, checkpoint resets, three enemy types, two boss attacks, arena gates, victory, keyboard/touch controls, pause and focus handling.

The preview integrates painted hunter action frames, synchronized ground/crouch/air attack bodies with separate whip layers, pursuer calibration image, background and masonry. The pursuer has animated idle breathing, patrol/approach locomotion and a rear-up alert; its remaining actions use a static painted pose. Other enemies use engine silhouettes. The art is preview quality, not an approved full production inventory. Music/SFX production remains deferred.

Desktop automated gameplay validation and a single-threaded web export are recorded in evidence. Physical iPhone testing and an unfamiliar-player study have not been performed. No on-device performance, final atlas memory budget or complete animation compliance is claimed.

The full source, generated candidates, rejection evidence and contract tools are included so further work can resume from this checkpoint.

## Follow-up fix: get-up

Get-up now shows a supported floor-to-standing recovery and ends in a stable neutral pose. Its scoped audit and fresh independent motion review passed; timing and gameplay behavior are unchanged. See `evidence/getup-fix.md`. Other production-art/device gaps remain pending.

## Follow-up fix: turning

The repainted turning pose passed its fresh independent motion/identity review. Real input-driven engine captures confirmed the facing transition at 75 ms. See `evidence/turn-fix.md`.

## Follow-up fix 3: braking

Grounded braking compression passed fresh independent review r03. Only the middle frame changed; endpoints and timing remain intact. Gameplay, art tools, engine captures and browser smoke checks passed. See `evidence/brake-fix.md`.

## Follow-up fix 4: walking

Alternating walk motion, coat continuity and the distinct seam passed fresh independent review r19. Hero playback is tuned to travel speed; actual right-input captures verify all ten frames over 400 ms and 96 units of travel. Gameplay and art-tool checks passed. See `evidence/walk-fix.md`. Remaining production/device gaps are still tracked in `docs/FIX_QUEUE.md`.

## Follow-up fix 5: ground attack and whip

Eight painted attack body frames and a separate synchronized leather whip passed fresh independent review r02. Recovery folds gather visibly into the final coil. Actual-input desktop/phone captures verify all frames in both directions and exact mirrored socket registration. Gameplay, strict geometry audits, art-tool checks and web smoke passed. See `evidence/ground-attack-fix.md`.

## Follow-up fix 6: crouch attack

The articulated low attack and separate crouch whip passed fresh independent review r01. The weapon stays in the same near arm, the knees remain folded, and the low hitbox and 500 ms timing are unchanged. Desktop/phone captures verify all eight frames in both facings, crouched collision and exact socket registration. Ground regression, gameplay, art tools and browser smoke passed. See `evidence/crouch-attack-fix.md`.

## Follow-up fix 7: air attack

The airborne attack body and separate whip passed fresh independent review r01 with zero numeric defects or flags. Real-jump desktop/phone captures verify all eight synchronized frames in both directions. Active attacks land into the existing ground/crouch layers without restarting the clock or clearing hit IDs. Gameplay, strict weapon audits, art tools and browser jump/whip smoke passed. See `evidence/air-attack-fix.md`.

## Follow-up fix 8a: pursuer locomotion

The eight-frame patrol and approach gaits passed fresh independent review r02. Actual AI desktop/phone captures verify support-foot registration, both facings, unchanged movement speeds and matching43.2-unit strides. Mirroring now preserves the asymmetric ground pivot. This is a disclosed D23 scripted animation fallback from an independently accepted painted source key; retain it as quality debt. Seven pursuer actions remain pending. See `evidence/pursuer-walk-fix.md`.

## Follow-up fix 8b: pursuer idle

Six breathing frames passed fresh independent review r02, with fixed paws and a continuous900ms loop and natural patrol handoff. Native/phone captures, gameplay, contract, art tools and browser smoke passed. The declared scripted fallback retains the approved painted anatomy after a generated cycle failed endpoint continuity. Six pursuer actions remain pending. See `evidence/pursuer-idle-fix.md`.

## Follow-up fix 8c: pursuer alert

Four articulated rear-up frames passed fresh independent review r01, including the three expected height-change flags and visible phone-sized silhouette cue. Actual detection and300ms approach handoff, mirrored pivots, gameplay, contract, art tools and isolated browser smoke passed. The D23 scripted fallback retains its quality-debt disclosure; failed generation/normalization evidence is preserved. Five pursuer actions remain. See `evidence/pursuer-alert-fix.md`.
