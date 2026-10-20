# Preview follow-up queue

Each completed fix gets its own validated commit and push, as requested by the user. Independent art approval is recorded separately from automated checks. Physical device and unfamiliar-player studies cannot be substituted with desktop emulation.

| Order | Gap | Status |
|---|---|---|
| 1 | Supported get-up motion with stable standing finish | DONE; independent r04 PASS, gameplay/tools checks and engine captures recorded |
| 2 | Turning head/neck-to-mantle join | DONE; independent r01 PASS, actual controller facing event validated at 75 ms |
| 3 | Braking weight transfer and rear-foot continuity | DONE; independent r03 PASS, grounded compression, unchanged endpoints/timing |
| 4 | Alternating walk support/swing and coat continuity | DONE; independent r19 PASS; real-input 400ms/96u loop and grounded handoff validated |
| 5 | Ground attack and separate whip geometry/socket/reach | DONE; independent r02 PASS; eight synchronized frames, mirrored sockets, gathering recovery loops and strict thickness checks |
| 6 | Crouch attack articulation | DONE; independent r01 PASS; articulated same-arm low attack, synchronized whip and unchanged crouch collision |
| 7 | Air attack articulation | DONE; independent r01 PASS; airborne body/whip sequence, mirrored sockets and active landing handoffs verified |
| 8 | Pursuer supported action clips | DONE: all9clips/46frames, fresh scoped reviews PASS and full runtime/capture inventory verified; hurt is the explicit conditional nonlethal branch |
| 9 | Swooper supported action clips | DONE: all7clips/36frames, fresh scoped reviews PASS and exact runtime/capture inventory verified; normal1HP death has visible falling/settling ash, hurt remains conditional |
| 10 | Ranged enemy supported action clips | DONE: all6body clips/31frames +3projectile frames independent PASS; exact runtime, full both-facing native/phone coverage, actual2HP hurt/death path, shot loop/flight/standing/crouch verified |
| 11 | Boss supported action clips | DONE: all11clips/70mandatory frames independent PASS, plus12supplemental recovery-hurt frames; death12frames includes pose-preserving lethal entry, supported kneel/fold and ash; actual8HP both-facing native/phone captures verified |
| 12 | Full effects, props, terrain and UI inventory | Hazard telegraph4/eruption6 and whip impact6 frames approved; defeat/checkpoint effects and full prop/terrain/background/UI inventory remain pending |
| 13 | Texture atlas packing, exact pixel round trip, memory budget | DONE for current351frames: lossless five-page runtime atlas,99.94MiB conservative inventory;126.56MiB measured art allocation; future inventory/device profiling remain |
| 14 | Phone-sized runtime captures, portrait/safe-area/input checks and timed clip reels | Pause/menu CSS targets,portrait and browser safe areas checked; timed source reels available; playfield thumb clearance, missing sequences and device validation pending |
| 15 | Physical iPhone performance and unfamiliar-player study | Not performed; requires external device/person access |

Production music/SFX remain explicitly deferred by the specification.

Projectile range follow-up: fixed separately after aiming. Spawn remains40u from the enemy root; expiry now measures640u from the actual muzzle. Both-facing regression22checks, old4failures→0; see `evidence/ranged-projectile-fix.md`.

Boss recovery-clock follow-up: nonlethal flinch now resumes the remaining1100/900ms recovery instead of granting an early new attack. Real-whip regression40checks,old12failures→0; art inventory remains23/70boss frames. See `evidence/boss-recovery-window-fix.md`.

Phone pause-target follow-up: pause/resume now retains64×64rendered pixels after viewport scaling and resize. Four-size16check GUI regression and actual browser lower-edge touch pass. Portrait/menu/safe-area/art/device gates remain pending. See evidence/pause-touch-target-fix.md.

Portrait follow-up: actual-window orientation detection, rotate prompt, cleared held input and explicit landscape resume pass18engine checks and two-size browser captures. Painted UI graphic, menu/safe-area and physical-device gates remain pending. See evidence/portrait-pause-fix.md.

Density follow-up: UI scaling now uses CSS pixels rather than backing pixels; real device-scale2/3 lower-edge touch passes after failing before. Rotate startup box and high-density text centering pass9engine checks and image-based242→6.5px offset check. Other menu/safe-area/device gates remain pending. See evidence/pause-density-fix.md.

Menu follow-up:64CSS-pixel buttons/toggle/sliders,readable labels and bounded touch-scroll menu pass60engine checks and density1/2actual swipe/adjust/resume browser captures. Safe-area,painted inventory and device gates remain pending. See evidence/menu-touch-targets-fix.md.

Safe-area follow-up:actual CSS insets and letterboxing/density projection now constrain HUD,pause,menu and grouped actions.150checks and two browser inset profiles pass; final shell has one viewport tag. Phone playfield clearance and painted UI/device gates remain pending. See evidence/safe-area-fix.md.

Gameplay action-target follow-up: all five controls now retain64CSS-pixel targets and16CSS-pixel labels, safe bounds and gaps; compact pause corner interception fixed.190engine checks and density2 compact browser touch/capture pass. See evidence/action-touch-targets-fix.md.

Touch-cancellation follow-up: canceled events clear all held sources and buffered edges, while ordinary releases preserve other fingers/keyboard.11checks,4before failures→0. See evidence/touch-cancellation-fix.md.

Pressed-feedback follow-up: gameplay buttons display the shared held state across keyboard/touch/drag/release/pause.25checks,12before failures→0; actual browser held/released captures retained. Painted UI inventory remains pending. See evidence/touch-feedback-fix.md.

Atlas follow-up:302RGBA roundtrips and1815export-runtime checks pass;550both-facing engine samples differ by only one channel value in one shader-edge pixel. Current measured art allocation105.22MiB; no physical-device claim. See evidence/atlas-fix.md.

Timed-reel follow-up:67contract/supplemental entries,58complete source sequences,9missing/62frames explicitlyNOT-TESTED;569browser checks cover timing,mirroring and actual phone downscale. Source viewer is not art approval or engine transition evidence. See art/reels/README.md and evidence/clip-reels-fix.md.

Boss hazard follow-up:18body+10painted-effect frames and3late hurt variants passed fresh r02review after r01caught invisible warnings. Natural alternation,allFXframes/bothfacings/native+phone,actualwhip punish and900ms recovery verified.333RGBA roundtrips,2001exported atlas checks and575updated reel checks pass. Death12frames and broader inventory/device/player gates remain. See evidence/boss-hazard-fix.md.

Boss death visibility: preserve full opacity throughout1080ms collapse/ash, then fade over the existing120ms cleanup. Regression136checks,30oldfailures→0; exported-PCK checks pass. Source death art remains pending. See evidence/boss-death-visibility-fix.md.
