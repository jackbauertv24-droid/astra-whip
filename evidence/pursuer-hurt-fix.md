# Pursuer hit recoil

Scope: pursuer_hurt, three60ms frames and unchanged180ms handler transition. No production HP, damage, AI or renderer code changes.

The approved painted cutout source supplies connected legs, torso and head. The short asymmetric reaction retracts the head/chest, folds the near forearm inward and returns to the approved approach entry while the far forepaw/near hindpaw support stays fixed. Source bone lengths remain unchanged within0.01pixel. This continues the actor's declared D23 fallback after direct actor art generation failed earlier motion/density constraints; retain scripted animation as quality debt.

Independent r01 visual review passed. A subsequent one-pixel torso adjustment in F0 removed a0.6817source-pixel mismatch in the far forearm's target joint chain; the original accepted PNGs and script remain in production-candidates/pursuer-hurt-r01, review-pursuer-hurt-r01 and rejected/pursuer-hurt-joint-r01. F1 and F2 are unchanged. Fresh r02 review is required for the final revision.

The actual take_hit handler is exercised from windup with a two-HP test-only instance, which becomes one HP and enters hurt. The harness records all3frames and the natural approach handoff, checks a stationary root and mirrored ground origin, and measures the180ms transition within a120Hz step. It separately verifies a normal one-HP pursuer goes directly to death after a hit. This is conditional nonlethal-branch coverage, not a claim that a production one-HP pursuer normally survives a hit. No production durability was changed to make the test pass.

Native and phone-sized records are evidence/pursuer-hurt-engine-r02 and evidence/pursuer-hurt-phone-r02,8PNGs each plus capture.json. Phone-sized desktop rendering does not establish physical iPhone behavior.

Scope validation verifies unrelated metadata unchanged, all3 source/runtime/review files byte-identical, F0the only revised frame, and the final pose identical to approach entry. Gameplay, contract, art-tool negative fixtures, browser regression and export hash are recorded under evidence/pursuer-hurt-*.

Final independent verdict: REVIEW: PASS, art/review-pursuer-hurt-r02/review_verdict.md. The final audit has0defects/flags. All1213 gameplay assertions,25 art-tool negative fixtures, contract cross-check and isolated browser regression passed.
