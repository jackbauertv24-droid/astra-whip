# Independent scoped art review — gait r14

Scope: `hero_walk` and `style_hero_neutral` only. Unrelated absent clips are outside this gate. No prior verdicts or builder verdict were consulted, and no art was modified.

Procedural disclosure: the reviewer accidentally read a truncated portion of ART_CONTRACT before the blind image pass. The lineup and both strips were then inspected and every tile described in `blind_observations.md` before reading scoped intent, index, derivation metadata or audit. This is an order deviation from the strict blind protocol; it is disclosed rather than silently representing the review as perfectly ordered.

| Clip | Verdict | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| style_hero_neutral | PASS | — | Complete grounded human, stable reference proportions, recognizable face/hair/costume, right-facing, small held coil. | None. |
| hero_walk | FAIL | F6–F7, chiefly F6→F7 | The foreground support boot moves sharply backward across the ground during the weight-bearing interval, with an accompanying abrupt change from the compact frontal chest/coat at F6 to the broader side-oriented chest and long foreground skirt at F7. This reads as a pose splice and foot skate rather than continuous supported travel. | Reauthor the F6/F7 support-leg and torso/foreground-skirt transition against F5 and F8, keeping the same boot grounded along a continuous travel-compensating path and maintaining shoulder/coat overlap. Retain the lifted far recovery boot and alternating leg identities. Review the revised full loop in moving engine captures. |

Inspected evidence: shared lineup; both native strips; all eleven individual native PNGs; all ten onion pairs including F9→F0; audit JSON/Markdown; scoped clip durations and scripted/painted derivation metadata; ART_REVIEW, ART_CONTRACT, ART_BIBLE, ANIMATION_SPEC and style-lock register; all ten desktop and ten phone engine PNGs plus both capture.json files. The style-lock neutral reference is the visible neutral tile/native frame; no historical reviewer output was opened.

Anatomy and identity: every scoped frame contains a complete head-to-boots figure and two readable legs. The hair/portrait, pale sleeves, brown mantle, belt, bracers, knee boots and coiled whip retain the same broad character identity. F6 has a more frontal and compact chest/arm arrangement than its neighbors; the concern is its transition, not a missing limb. No torso-only substitute, global size shrink, clipping, detached coil, blank frame or conspicuous debris is visible. Audit heights are 218–224 px for walk against the 224 px reference; head widths are 39–40 px against 39 px. Physical scale is acceptable independently of the motion defect.

Leg depth and action: the foreground brown boot/overlying coat panel is trailing in F0–F2, swings forward in F3–F4, and becomes the forward support in F5–F6. The darker far leg supports the first half and recovers behind in F6 before swinging forward at F7–F8. Alternation is present and the lifted far boot at F6 reads as a bent recovery leg. The declared derived clip therefore contains an actual articulated walk, but its support continuity fails at the named transition. All ten files have distinct SHA-256 hashes; F0/F1 and F9/F0 contain small real pose differences rather than literal held copies. Distinct bytes alone are not the motion acceptance basis.

Onion-pair assessment:

- F0→F1: short narrowing stride, coherent body and cloth.
- F1→F2: trailing leg lifts and forward leg supports; mild body bob, coherent.
- F2→F3: near leg swings forward over the far support; substantial forward swing is readable, with some additional support-foot slide in engine placement.
- F3→F4: forward swing descends toward contact; coat follows near thigh without reversing depth.
- F4→F5: forward contact settles, coherent near/far overlap.
- F5→F6: far boot lifts behind while near boot supports; chest rotates/compacts more abruptly than desirable and sets up the failing next pair.
- F6→F7: FAIL. Grounded foreground boot jumps backward and shoulder/arm/skirt arrangement changes suddenly.
- F7→F8: far boot descends, near support moves rearward; coherent local progression.
- F8→F9: late swing returns toward spread contact, recognizable continuity.
- F9→F0: small closing adjustment; no distinct seam pop.

Moving-engine check: capture metadata records 240 u/s, playback rate 2, 0.4 s per cycle, and 96 u total cycle travel. F6 is at t=0.241667 s, x=736; F7 is at t=0.283333 s, x=746. Thus the hero travels +10 u during this interval. On native alpha≥40 boot ink in rows 443–448, F6 has one grounded footprint spanning source x259–307 and F7 one spanning x214–252. The grounded toe shifts −55 source px, or −27.5 u at the declared 2 px/u density. Including root travel, that same support toe shifts approximately −17.5 u in world space over one frame interval. This corroborates the visible backward skate; it is not explained by the actor moving forward. Toe-edge measurement is an approximate footprint proxy, but the shift is large and the single grounded boot's identity is visually traceable. Both desktop and phone capture sequences show the support transition; the phone presentation reduces fine costume detail without repairing the weight-transfer jump. Exact fine facial features are naturally not resolvable at that display scale, but the full human silhouette and movement remain readable.

FLAG adjudication: A-11 `hero_walk` F7, size change 6.9% from F6, height change 1.4%: **DEFECT, rejected**. A silhouette-area increase could in principle come from rotation or opened cloth, but here the native and onion images show a sudden torso/skirt change coincident with the unsupported contact shift. The numeric flag correctly identifies a visibly discontinuous pair. No FLAG is accepted.

REVIEW: FAIL (1 clips)
