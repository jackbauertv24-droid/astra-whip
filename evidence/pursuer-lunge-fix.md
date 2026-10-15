# Pursuer windup, lunge and recovery

Scope: the connected windup/execution/recovery action,11frames total. Canonical timing stays350/240/600ms. Approach,260u/s lunge physics, contact damage and AI are unchanged; complete assets load through the existing renderer.

## Articulation and retained failures

The action continues the explicitly reviewed painted cutout technique used by this actor. The independently accepted static source supplies four limb chains and connected torso paint. Windup compresses hips, bends knees/elbows and gathers a front arm. Execution extends the body low, releases the old support and catches with the near forepaw. Recovery replants the other limbs and rises into the approved approach entry. Each bone keeps its source length; no whole-body scaling is used.

This is a disclosed D23 scripted fallback after direct actor generation failed gait continuity and intermediate-pose density/shape constraints. The manifest identifies those actor failures rather than claiming a new generated lunge attempt failed. Scripted animation remains quality debt. All three new clips require independent acceptance on their own behavior.

The first draft's below-floor ink in lunge F2/recovery F0 is retained under art/rejected/pursuer-lunge-ground-r01 and art/review-pursuer-lunge-draft-r01. Independent motion review r01 later accepted windup/recovery but rejected lunge F2→recovery F0: the planted far paw dragged19.5units during the terminal interval. The complete failed pack, raw candidates and actual-AI captures remain.

The correction changes only lunge F2. The far forepaw releases; the near forepaw catches at source x272.6 and registers against recovery's x231 after the last41.6source-pixel interval (260u/s ×80ms ×2px/u). The near support remains fixed throughout stationary recovery. Small torso lean keeps the stretched chain connected; every source bone length remains within0.01pixel. No windup or recovery PNG changed after independent r01 review.

## Validation

`tools/check-pursuer-lunge.mjs` fails on the retained earlier candidate and passes on the correction. It checks support contact, release, moving-root compensation through the terminal interval, and fixed recovery support. Negative and positive logs are retained. The same checker consumes both actual capture records: early support drift is0.8663u and terminal drift is at most1.3004u, within one120Hz step (2.1767u); recovery support remains stationary in both directions and viewports.

The actual-AI harness triggers windup from close approach, records all11frames in both facings, then the natural approach handoff. Native/phone captures are evidence/pursuer-lunge-engine-r02 and evidence/pursuer-lunge-phone-r02. It verifies350/240/600ms clocks, nominal62.4-unit lunge travel within a120Hz simulation step, stationary windup/recovery, and mirrored ground pivots. These are phone-sized desktop captures, not physical-device tests.

Scope checks verify unrelated metadata is unchanged, all11 source/runtime/review frames are byte-identical, only lunge F2 changed after r01, and windup entry/recovery finish equal the approved approach entry. Contract, gameplay, art-tool negative fixtures, browser boot/input regression and web export hash are recorded under evidence/pursuer-lunge-*.

Independent r02 visual verdict: REVIEW: PASS for windup, lunge and recovery; see art/review-pursuer-lunge-r02/review_verdict.md. The final audit has0defects/flags. All1213 gameplay assertions,25 art-tool negative fixtures, the contract cross-check and isolated browser smoke passed.
