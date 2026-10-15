# Pursuer alert rear-up

Scope: pursuer_alert only. Four75ms frames retain the300ms tell and unchanged patrol-detection/approach AI. No gameplay or renderer behavior changes are required.

## Rejections and permitted derivation

The first generated early-rise entry was175px tall instead of126px; its required0.72 corrective scale was rejected by G-03. Regeneration was151px tall, still requiring an out-of-range0.83444scale. Both raw deliveries, guide-bearing prompts and failure logs remain. The separately generated return candidate was within bounded normalization but is unused.

The replacement is a disclosed ART_CONTRACT §11/D23 articulated fallback, derived from the independently approved painted static key already used in locomotion. tools/prepare-pursuer-alert.mjs separates the same painted bone pieces, rears the torso about the hips to18degrees, lifts the two connected forelimbs and places the far hindfoot into support while retaining the planted near hindpaw. It lowers back into the approved approach entry. This is jointed body motion, without whole-body scaling or translation. Source and target joints, support contacts and torso rotation are retained in production-candidates/pursuer-alert-fallback-r03/rig.json.

Scripted animation remains disclosed quality debt. This review does not complete the other pursuer actions.

## Validation

The actual-AI harness advances patrol, brings a visible hunter into detection range, records all four alert frames and the natural approach handoff after300ms in both directions. It checks stationary alert root and mirrored ground registration. Desktop and phone-sized captures are evidence/pursuer-alert-engine-r01 and evidence/pursuer-alert-phone-r01; both logs end PASS. These are desktop renders at phone size, not physical-device evidence.

The scope check verifies unrelated clip metadata is unchanged, all4 source/runtime/review PNGs are byte-identical, and the last alert frame equals approach F0 pixel-for-pixel. All target bone lengths stay connected within0.01source pixel. Gameplay, contract, art-tool negative fixtures, general browser boot/input smoke and export hash are recorded under evidence/pursuer-alert-*. All1213 gameplay assertions and25 negative fixtures passed. The first browser startup probe timed out after60seconds while native/tool checks were also running; an isolated rerun completed with no browser errors. The passing browser JSON and capture come only from that isolated rerun.

The audit reports0defects and three height-change FLAGS across the rear-up and lowering. Fresh independent review r01 accepted all three as supported articulation with stable physical size and issued REVIEW: PASS for alert; see art/review-pursuer-alert-r01/review_verdict.md.
