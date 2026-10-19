# Public preview

The user authorized a change in priority on 2026-10-14: "just round up the work and push it to repo. relax constrain as the priority now is to get a product out."

This preview packages the implemented slice without claiming the remaining upstream production-art gates passed. The original contract and review evidence remain intact.

Implemented: deterministic movement and collision, coyote time/jump buffering, crouching, grounded/air attacks, damage/recoil/knockdown/death, checkpoint resets, three enemy types, two boss attacks, arena gates, victory, keyboard/touch controls, pause and focus handling.

The preview integrates painted hunter action frames, synchronized ground/crouch/air attack bodies with separate whip layers, all nine pursuer and seven swooper action clips, background and masonry. The pursuer has all nine required action clips; the nonlethal hurt branch is conditional, while normal one-HP hits enter the complete collapse/ash sequence. The swooper has all36 required frames, including a normal one-HP falling collapse and readable ash settle; conditional hurt uses an explicit test-only2HP fixture. The ranged enemy has a painted rooted idle; its remaining actions and the boss use engine silhouettes. The art is preview quality, not an approved full production inventory. Music/SFX production remains deferred.

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

## Follow-up fix 8d: pursuer lunge sequence

Windup, execution and recovery passed fresh independent r02 review after a terminal support-foot slide was corrected in lunge F2 alone. Actual AI captures verify350/240/600ms phases,260u/s movement, terminal catch registration, stationary recovery and the approach handoff in both directions. The new contact checker fails on the retained earlier candidate and passes the corrected target paths and native/phone capture records. Gameplay, contract, art tools and browser regression passed. The scripted fallback quality-debt disclosure remains. Hurt and death are still pending. See `evidence/pursuer-lunge-fix.md`.

## Follow-up fix 8e: pursuer hurt

Three articulated recoil frames passed fresh independent r02 review with stationary supports and an exact approach return. A two-HP test-only instance exercises the actual nonlethal hit handler and windup interruption; normal production one-HP hits are separately verified to enter death. Production durability and damage are unchanged. Native/phone captures, gameplay, contract, art tools and browser regression passed. Scripted fallback quality debt remains disclosed; death is still pending. See `evidence/pursuer-hurt-fix.md`.

## Follow-up fix 8f: pursuer death and complete actor inventory

Six collapse/ash frames passed fresh independent r01 review, including both numeric flags. Actual normal one-HP death captures verify complete grounded collapse, final hold, cleanup and no dead contact damage in both facings. The complete pursuer inventory now passes: nine clips, 46 frames, exact runtime files, scoped approvals and all frames in both-facing native/phone captures. Gameplay, contract, art tools and browser regression passed. Scripted-animation quality debt and external physical-device/player studies remain explicitly disclosed. See `evidence/pursuer-death-fix.md` and `evidence/pursuer-inventory.json`.

## Follow-up fix 9: complete swooper action set

All seven clips and36frames have fresh scoped independent PASS verdicts and actual native/phone frame coverage in both facings. The final death revision preserves the accepted collapse keys, keeps falling ash readable through ground arrival and fades before cleanup. Retained failed source/motion reviews show the corrections. Exact runtime delivery and conditional hurt disclosure are checked by `tools/check-swooper-inventory.mjs`. Reused/local mesh/erosion frames remain D23 quality debt; this is not physical-device or complete-production-inventory approval. See `evidence/swooper-death-fix.md`.

## Follow-up fix 10a: ranged rooted idle

Six150ms frames passed a fresh independent review, with local chest/arm/cloth motion, a fixed stone post/base and continuous900ms wrap. Actual stage captures cover both facings/native/phone, and runtime bytes, gameplay, art tools, export and browser smoke pass. The corrected identity frees the future aiming arm and keeps the hood topmost. This D23 local rig remains quality debt. Remaining ranged actions/projectile and physical-device gates stay pending. See `evidence/ranged-idle-fix.md`.

## Follow-up fix 10b: ranged aim

Six150ms aiming frames passed fresh independent r04 review after preserving the idle painting across the stationary hood/post/robe/base. Actual native/phone captures verify the900ms warning in both facings, fixed root, no early shot and unchanged muzzle. The growing painted diamond provides a shape cue. Retained failed source/rig/repaint evidence and a failing-before/passing-after identity regression document the corrections. Gameplay, art tools, export and browser smoke pass. D23 rig debt, later ranged clips/projectile and external device/player gates remain pending. See `evidence/ranged-aim-fix.md`.

## Follow-up fix 10c: projectile range origin

Projectile expiry now measures640u from its muzzle, correcting the previous600u actual flight caused by the40u spawn offset. Both-facing actual-engine checks fail before the change and pass afterward; warning/shot timing, speed, collision band and crouch dodge remain intact. This separate code fix adds no projectile-art approval. See `evidence/ranged-projectile-fix.md`.

## Follow-up fix 10d: ranged firing

Three50/50/100ms frames passed fresh independent review after a local hand correction removed embedded charge paint. The action reuses the exact aim endpoint, contracts the painted diamond at release and adds a small connected recoil. Engine captures validate both facings/sizes, fixed registration and frame1shot. Byte/identity checks, failing-before/passing-after final-charge regression, gameplay/tools/export and browser smoke pass. D23 debt and remaining recovery/hurt/death/projectile/device gates stay pending. See `evidence/ranged-fire-fix.md`.

## Follow-up fix 10e: ranged recovery

Seven100ms recovery frames passed fresh independent review, returning the clean firing arm to idle with exact accepted endpoint reuse. Actual native/phone captures verify every frame, both facings,700ms timing, fixed root and no extra shot. Byte/identity checks, gameplay/tools/export and browser smoke pass. D23 debt and remaining hurt/death/projectile/device gates stay pending. See `evidence/ranged-recover-fix.md`.

## Follow-up fix 10f: ranged hurt

Three60ms protective-flinch frames passed fresh independent review. Actual whip input interrupts aiming on the production2HP enemy, shows hurt at1HP without firing, returns to idle and enters death on the second hit. Native/phone captures cover both facings; fixed post/base, delivery bytes, gameplay/tools/export and isolated browser smoke pass. D23 debt, death/projectile art and external-device gates remain pending. See `evidence/ranged-hurt-fix.md`.

## Follow-up fix 10g: ranged death and complete body inventory

Six80ms death frames passed fresh independent review, including the dissolve-size flag, after a painted halfway slump replaced a stretched bridge and grounded painted ash replaced a faint blur. Actual two-whip production2HP captures verify both facings/sizes, allframes, late fade/cleanup and no dead contact. All6body clips/31frames now pass exact runtime/approval/capture inventory. Gameplay, tools, export, browser smoke and the failing-before/passing-after ash-opacity tripwire pass. D23 debt and separate projectile/device/player gates remain pending. See `evidence/ranged-death-fix.md` and `evidence/ranged-inventory.json`.

## Follow-up fix 10h: painted projectile and complete ranged inventory

Three directly generated64pxdiamond frames passed fresh independent review, including phone readability and240msloop seam. Shots now render from contract timings/center pivot and per-shot age, replacing the flat polygon when allframes load. Actual both-facing/native/phone captures verify birth,loop,long flight,expiry,standing non-displacing hit and crouch dodge;28new clock/resource checks and existing gameplay/regressions/tools/export/browser smoke pass. All34ranged body/projectile frames now have scoped approval and exact runtime/capture inventory. Body D23 debt and external device/player gates remain. See `evidence/projectile-grave-shot-fix.md` and `evidence/ranged-complete-inventory.json`.

## Follow-up fix 11a: boss walk reference

Eight80ms painted walk frames passed fresh independent review. Actual boss AI captures verify70u/s,640ms loop,bothfacings/native+phone,pivot and original palette. Old silhouette dispatch fails the new fixture; corrected runtime passes. Generated oversized sheet and earlier sole/fixture errors are retained. Contract/tools/gameplay/focused regressions,export and browser boot/input smoke pass. D23 articulated fallback remains quality debt; ten other boss actions, remaining inventory and external device/player gates stay pending. See `evidence/boss-walk-fix.md` and `evidence/boss-walk-inventory.json`.

## Follow-up fix 11b: boss waiting idle

Eight125ms idle frames passed fresh independent review. Inactive-arena code now advances animation without running boss behavior; the new26check regression fails16checks on the old branch and passes after correction. Both-facing native/phone captures verify1s wrap,fixed root,production8HP and actual activation→walk. Tools/gameplay/focused regressions/export/browser smoke pass. Phone PNGs are698×393 despite852×393viewport metadata; exact-width/device validation remains pending. D23 debt,nine remaining boss clips and broader inventory/device/player gates stay disclosed. See `evidence/boss-idle-fix.md`.

## Follow-up fix 11c: boss brief hurt

Three70/70/60ms recoil frames passed fresh independent review, with supported legs,connected upper release and exact neutral endpoint. Actual whip reduces production8HP→7HP,returns to walk after200ms; a separate explicit live-strike fixture takes another real hit without interruption. Bothfacings/native/actual698×393phone captures,tools/gameplay/focused regressions,export/browser smoke pass. D23 motion debt and phone-width metadata limitation remain; eight other boss actions and broader inventory/device/player gates are pending. See `evidence/boss-hurt-fix.md`.

## Follow-up fix 11d: boss telegraphed turn

Four75ms frames passed fresh independent review through actual both-direction captures. Painted frontal inward-arm midpoint plus neutral endpoint reuse supply chest/hip rotation and a continuous gauntlet path across the existing150ms facing flip. Natural walk mismatch enters turn; fixedroot/pivot/8HP and300ms walk return pass. Failed generation/normalization/head/mass audits remain retained. Tools/gameplay/focused regressions/export/browser smoke pass. Phone evidence is content-sized desktop capture,not physical-device/exact-window validation. Seven other boss clips,broader inventory and external-device/player gates remain pending. See `evidence/boss-turn-fix.md`.

## Follow-up fix 11e: boss recovery clock

Nonlethal flinch preserves the remaining strike/hazard recovery and counts time spent hurt, preventing an early next attack. Both-facing engine regression fails12checks before and passes40after: actual two500ms whip commitments fit the1100ms strike window; explicit hazard-recovery fixture preserves900ms. Gameplay/tools/focused regressions,export/browser smoke pass. Unreviewed strike artwork is excluded from this shippedPCK and remains a separate pending fix. No new art/device/player approval. See `evidence/boss-recovery-window-fix.md`.

## Follow-up fix 11f: complete boss strike cycle

Seven windup, four execution and six recovery frames passed fresh isolated independent review after correcting weak recovery acting and a discontinuous arm/body handoff. Nine supplemental hurt frames preserve the supported posture during punish hits. Actual both-facing/native/phone captures cover every frame, two full500ms whips and late hurt;1234gameplay assertions plus focused contact/context/recovery checks, contract/tools, export and browser smoke pass. Before/after geometry regression rejects the retained arm/body jumps. Boss art now40/70mandatory frames; hazard/death, broader inventory and external device/player gates remain pending. D23 quality debt stays disclosed. See evidence/boss-strike-fix.md.

## Follow-up fix: phone pause touch target

Pause/resume now retains at least64×64rendered pixels after viewport scaling. Four-size GUI regression fails4checks before and passes16after; browser phone emulation confirms a touch below the old edge resumes and pauses. Gameplay/tools/export pass; portrait handling and other UI/device gates remain pending. See evidence/pause-touch-target-fix.md.

## Follow-up fix: portrait pause and rotate prompt

Actual window rotation now pauses gameplay,clears input and shows live rotate/pause text. Portrait cannot resume; landscape return waits for an explicit action. Regression18checks,old12failures→0; two browser portrait sizes and unchanged-after-Escape PNGs verify behavior. Gameplay/tools/export/browser pass. Painted UI inventory,safe-area and physical-device gates remain pending. See evidence/portrait-pause-fix.md.

## Follow-up fix: CSS density and rotate startup layout

Pause targets and rotate typography now account for the backing-to-CSS canvas ratio. Browser device scales2/3 reproduce lower-edge touch failure before and resume correctly after. The fixed two-line prompt also avoids a cached wrap-height startup overflow;9new layout checks and real high-density image centering pass. Native pause/orientation,tools/export pass. Menu/safe-area/art/device gates remain pending. See evidence/pause-density-fix.md.

## Follow-up fix: reachable phone menu targets

Menu controls retain64CSS-pixel heights and readable labels inside a bounded vertical scroll area. Pointer events reach the scroller,so real touch swipes expose both volume controls without activating buttons. Expanded60check GUI regression,full gameplay/tools/export and isolated density1/2browser runs pass. Physical-device,safe-area and painted inventory gates remain pending. See evidence/menu-touch-targets-fix.md.

## Follow-up fix: web safe-area layout

HUD,pause,menu and grouped touch controls now stay inside reported safe-area bounds after density/letterbox conversion. A single-viewport custom shell replaces ineffective body padding. Expanded150check regression,full gameplay/tools/export and browser inset emulation pass. Logging-only evidence verifies relocated whip input; final release has no probe logging. Physical devices,thumb-clear playfield framing and painted inventory remain pending. See evidence/safe-area-fix.md.
