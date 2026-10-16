# Ranged nonlethal hurt reaction

Three60ms frames show an inward protective arm fold and small away-from-hit hood/chest recoil, followed by exact idle endpoint reuse. A generated defensive key supplied the connected anatomy but leaned toward the hit and repainted stationary construction. The disclosed D23 local correction preserves idle post/base, limits the upper-body recoil and retains uniform source normalization provenance. Scripted animation remains quality debt.

The actual production2HP enemy on its stage platform receives real player whip input: the first hit changes2HP→1HP and interrupts aim into hurt; all3frames are captured before idle return at180ms. No projectile escapes. After the first player attack commitment finishes, a second actual whip enters death at0HP without changing enemy HP in between. Death appearance is explicitly outside this review. Captures cover both facings/native and phone viewports; phone is emulated, not physical.

Initial fixture failures came from using an input action named `attack` instead of the actual `whip`; diagnostic logs retain the idle hero/unchanged enemy showing no attack had occurred. The corrected fixture passes in both sizes. This was not a gameplay defect.

Exact source/runtime/review bytes, fixed post/base regions and exact idle endpoint pass (`ranged-hurt-inventory.json`). Scoped audit, contract,25tool fixtures,1213gameplay assertions, actor pivots,32collision/17recovery-entry/22projectile regressions and export are recorded. Independent review and browser smoke remain separately recorded acceptance gates. The previously pushed recovery build060732f was live-hash verified before this fix.

The combined export/browser wrapper returned143after producing completed output. Export succeeded before its checksum step; the browser was rerun independently and completed with observed exit0 (`ranged-hurt-browser.exit`), Chromium156 and no errors. No interrupted wrapper status is counted as a successful validation.

Fresh independent r01review returned REVIEW: PASS for all3scoped clips, no failing frames/flags. Full verdict: `art/review-ranged-hurt-r01/review_verdict.md`. Phone recoil is subtle but the protective arm fold supplies the visible hit cue. D23 and death/device exclusions remain.
