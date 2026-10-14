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

## Motion revision r06

The current 19-clip set reports zero numeric defects in `art/review-hero-motion-r06/audit.md`. It is not approved for production. A fresh independent reviewer is inspecting 18 non-walk clips in `art/review-secondary-motion-r06/`; the result is pending. The gait r05 review rejected F3/F4/F6 for coat/hip discontinuity, support/swing continuity and a boot fragment. New painted in-betweens are candidates, not accepted motion. Turning uses an explicitly declared compact approved neutral portrait on an approved twisting body. Braking now draws both planted boots inward, bends the knees and leans back from an approved contact pose instead of using a crouch-height frame.

Tools were rechecked: contract checker PASS and self-test PASS, 25 negative cases, zero problems (`evidence/art-tools-selftest-r06.log`, 41.5 seconds). No later build gate or publication is approved or complete.

## Published preview priority override

On 2026-10-14 the user explicitly instructed the builder to round up and push the product, relaxing the former gate order. The resulting public preview integrates selected painted art and working gameplay without claiming the strict gates 4–7 passed. The non-walk r06 reviewer passed 15 clips and failed braking, turning and get-up; gait r07 failed F3/F4/F6. Later candidates were not granted a final full production approval. A fresh isolated-key reviewer encountered an account usage limit; no approval was inferred.

See `docs/RELEASE_PREVIEW.md` for the actual shipped scope. The current gameplay verification passed all T-01 through T-09: 1,213 assertions, zero failures, with 229 reachable standing samples (`evidence/release-preview-tests.log`). Prior mutation proofs remain in `evidence/`. Physical iPhone and unfamiliar-player tests remain unperformed.
