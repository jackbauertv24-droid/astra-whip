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
| 11 | Boss supported action clips | PARTIAL: idle+walk+hurt+turn23/70frames independent PASS; actualwaiting/walk/recoil and single150ms flip/300ms turn; seven other action clips remain previews |
| 12 | Full effects, props, terrain and UI inventory | Partial preview assets only |
| 13 | Texture atlas packing, exact pixel round trip, memory budget | Not completed |
| 14 | Phone-sized runtime captures, portrait/safe-area/input checks and timed clip reels | Basic touch controls; further validation pending |
| 15 | Physical iPhone performance and unfamiliar-player study | Not performed; requires external device/person access |

Production music/SFX remain explicitly deferred by the specification.

Projectile range follow-up: fixed separately after aiming. Spawn remains40u from the enemy root; expiry now measures640u from the actual muzzle. Both-facing regression22checks, old4failures→0; see `evidence/ranged-projectile-fix.md`.

Boss recovery-clock follow-up: nonlethal flinch now resumes the remaining1100/900ms recovery instead of granting an early new attack. Real-whip regression40checks,old12failures→0; art inventory remains23/70boss frames. See `evidence/boss-recovery-window-fix.md`.
