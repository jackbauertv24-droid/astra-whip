# Implementation checkpoint

The implementation is in `game/`. Upstream specification SHA: `cf717cab22b39344820c11ef9aaf3a827336ce14`.

| Build gate | Status | Evidence |
|---|---|---|
| 1 Tools | PASS | `evidence/gate-1.md`; contract checker and negative self-tests |
| 2 Greybox | PASS | `evidence/gate-2.md`; actual Godot T-01…T-09 plus deliberately broken mutations |
| 3 Style calibration | PASS | `evidence/gate-3.md`; independent five-piece review and `art/style-lock.json` |
| 4 Hero and whip | IN PROGRESS | Partial audit and motion review in `art/review-hero-partial-r01/` |
| 5 Other production assets | NOT STARTED | Requires gate 4 |
| 6 Integration | NOT STARTED | Requires gate 5 |
| 7 Web publication | NOT STARTED | Requires integration gate |

The partial motion reviewer passed hero idle, start move, crouch entry, crouch idle and crouch exit. It rejected walk, stop move, turn, rise, apex, fall, hurt recoil and knockback. Those failures remain release blockers. Numeric acceptance alone did not approve those motions.

New isolated keys for turning, impact, rising, apex, falling and collapse passed a fresh key review (`art/review-hero-keys-r05/review_verdict.md`). Key approval does not approve clip timing or continuity. Additional attack and opposing-contact keys are being reviewed separately.

Rejected source sheets, derived experiments, original frames, prompt records, normalization factors and prior reviews are retained. All scripted/reused/reversed clips are labeled in `art/frames/derivations.json`. The generated whole-clip idle sheet failed the size contract; approved neutral-derived breathing subsequently passed numeric and independent motion review.

The game still renders greybox placeholders. No production-art integration, full hero/whip gate, deployed build, iPhone device test, unfamiliar-player study, or public repository has been claimed.

Physical iPhone 17 gates V5/V8 and unfamiliar-human gate V6 stay PENDING unless actually performed. The user requested no human interaction.
