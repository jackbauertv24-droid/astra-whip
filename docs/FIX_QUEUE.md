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
| 12 | Full effects, props, terrain and UI inventory | All briefed effects and4stage props/5frames approved; terrain14tiles approved;all4background panels approved;all13UIassets/19frames approved |
| 13 | Texture atlas packing, exact pixel round trip, memory budget | DONE for current405packed +4standalone background frames: lossless five-page atlas,114.94MiB conservative inventory;127.06MiB measured art allocation; physical-device profiling remains |
| 14 | Phone-sized runtime captures, portrait/safe-area/input checks and timed clip reels | Pause/menu CSS targets,portrait and browser safe areas checked; timed source reels available; opening lower-return/ground-fallback framing and retry validated356checks +fresh r02review PASS; complete painted inventory validated; physical-device validation pending |
| 15 | Physical iPhone performance and unfamiliar-player study | Not performed; requires external device/person access |

Production music/SFX remain explicitly deferred by the specification.

Current delivery: all 409 runtime frames are canonical and integrated; fresh complete review r02 passes every clip/static asset and all 70 supplied integration views, with 35 flags individually adjudicated. Continuous production-input spawn→effigy→checkpoint→boss→exit and same-step damage-priority validation pass, and are included in the shared runner. Physical V5/V8 and unfamiliar-player V6 remain unperformed. The public cold-load proxy passes the 30 MiB payload hypothesis at 28.324 MiB but misses the proposed 12-second load hypothesis at 17.474 seconds; no device performance claim is made.

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

Painted controls follow-up: six normal/pressed controls independently approved,306source/export checks,52freeze-control failures,19engine and4browser captures.400RGBA roundtrips and752renderer samples are exact. See evidence/ui-controls-fix.md.

Checkpoint HUD follow-up: off/on icons independently approved at32x24CSS;232source/export checks, actual capture/pit retry/completion reset and21engine +4browser views.402RGBA roundtrips and756renderer samples exact. See evidence/ui-checkpoint-fix.md.

Completion UI follow-up: shared completion menu visibility fixed, gameplay controls hidden during menu to prevent overlap; retry/victory icons independently approved.75source/export checks,21engine +5browser views;404RGBA roundtrips/760renderer samples exact. See evidence/ui-completion-fix.md.

Rotate UI follow-up: final briefed UI asset independently approved.91source/export checks,9engine +6browser views, density1/3actual browser orientation and explicit resume;405RGBA roundtrips/762renderer samples exact. All13UIassets/19frames now approved. See evidence/ui-rotate-fix.md.

Painted sampling follow-up: all explicit background/effect/UI/exit nearest overrides corrected to linear, viewport default linear without mip sampling, exit tint no longer snaps texels.124source/export checks,762source/packed samples within unchanged one-pixel/one-channel-value tolerance, exit2states exact, fresh18engine/8browser scoped review PASS. Final whole-product complete-pack review remains pending. See evidence/linear-sampling-fix.md.

Canonical delivery follow-up: final aggregate review found12supplemental boss-reaction frames absent from art/frames despite shipping in runtime. Exact scoped-reviewed/runtime bytes plus timing/derivation metadata restored.409frame inventory now matches, expanded68clip audit0DEFECT/34FLAG and tools selftest pass. Complete pack r01 stays rejected; fresh r02 required. See evidence/canonical-context-fix.md.

Lossless payload follow-up: maximum WebP lossless encoder effort plus reproducible cache invalidation shrinks the PCK by 1,982,704 bytes. All nine decoded texture hashes remain identical; exported GPU atlas 2,433 checks and sampling 124 checks pass. Public cold trace and local/deployed SHA match are retained. See evidence/lossless-payload-fix.md.

Continuous stage follow-up: production-input automation completes the effigy, lower returns, mixed gap/pursuer, checkpoint, original eight-HP boss and exit with five HP. No teleports, direct damage calls, HP changes or disabled encounters. Earlier controller failures retained; external player/touch gates remain separate. See evidence/stage-playthrough-fix.md.

Damage priority follow-up: all incoming contacts/projectiles now resolve before outgoing whip damage, removing encounter-list order from same-step interruption.64checks,8baseline failures→0; main1,241assertions and continuous stage completion pass. See evidence/damage-priority-fix.md.

Complete acceptance record follow-up: fresh independent r02 REVIEW: PASS after blind inspection, all motion/composites/static repeats, 68 timed source entries with every frame index observed and all 70 integration images. All 35 flags have individual accepted reasons; derivation methods remain disclosed. Build/art/automated integration gates are complete; external device/player acceptance and the missed cold-load readiness hypothesis remain open.
