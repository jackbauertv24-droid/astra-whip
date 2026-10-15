# Pursuer idle breathing

Scope: pursuer_idle only. Six unique frames retain the canonical150ms timings,900ms loop and actual idle→patrol AI transition. Runtime gameplay code is unchanged; complete clip assets load through the existing renderer.

## Preserved failure and replacement

The painted draft failed independent review r01 at F0→F1 and F5→F0, including the actual patrol handoff. Generated chest/forelimb volume and cloth construction differed from the calibrated source. Candidate raw images, prompts, one-time baseline registrations, original native/phone captures, full failed review and pre-fix frame archive are retained. The failed painted requests also omitted their G-01 layout guide, as marked in provenance; none of those generated pixels is used in the replacement.

The replacement is a declared ART_CONTRACT §11/D23 scripted fallback from independently approved patrol F0. tools/prepare-pursuer-idle.mjs preserves that painted anatomy and uses local chest/neck breathing, a maximum3px head lift and subpixel beard/rag follow-through. Legs, paws and root remain fixed. No whole-body scaling, rotation or translation is used. Six phase samples and the source approval are recorded in production-candidates/pursuer-idle-fallback-r03/derivation.json. The complete breathing envelope was rebuilt from one fixed illustration because the rejected volume change affected the five generated poses around the neutral key.

Scripted idle animation remains disclosed quality debt. Remaining pursuer actions are not implicitly approved by this review; current inventory is tracked in docs/FIX_QUEUE.md.

## Validation

The actual-AI harness captures all six idle frames in both directions, verifies root x stays1050 and the ground pivot matches the physical origin, then records the natural patrol handoff at900ms. Native and phone-sized captures are evidence/pursuer-idle-engine-r02 and evidence/pursuer-idle-phone-r02. Phone-sized desktop rendering does not substitute for physical iPhone testing.

The scope check verifies only idle metadata changed and all6 source/runtime/review PNGs are byte-identical and unique. Gameplay, contract, art-tool negative fixtures and browser boot/input/error results are recorded under evidence/pursuer-idle-*. The browser smoke is a general patrol/input regression; idle motion is proved by the native AI captures and independent review.

Independent visual acceptance: REVIEW: PASS for idle, recorded in art/review-pursuer-idle-r02/review_verdict.md. All1213 gameplay assertions, all25 art-tool negative fixtures and the64-clip/356-frame contract cross-check passed; browser smoke reported no errors.
