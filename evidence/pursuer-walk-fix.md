# Pursuer patrol and approach locomotion

Scope: two locomotion clips only. The remaining seven pursuer actions are tracked separately in docs/FIX_QUEUE.md.

The runtime now loads the two complete eight-frame pursuer clips. Source timing stays 90 ms per patrol frame and 70 ms per approach frame. Patrol remains 60 u/s; approach remains 100 u/s. Approach playback uses 35/27 cadence, derived from source durations and movement speeds, so either gait cycle travels 43.2 units. Mirroring now registers the asymmetric 128,224 pivot correctly in both facings.

## Derivation and retained rejection

The directly generated cycle failed independent motion review r01, despite passing static identity/anatomy review. Both the failed frames and complete verdict remain in art/review-pursuer-walk-r01. The eight isolated painted keys were independently accepted as static source art in art/review-pursuer-keys-r01; this did not approve their animation.

The replacement is a disclosed ART_CONTRACT §11/D23 scripted fallback. tools/prepare-pursuer-gait.mjs extracts painted limb pieces from accepted key f000, rotates them about connected joint targets, and keeps four stable limb identities through continuous stance and lifted forward swing. Foreground/background limb order is explicit. The connected torso paint preserves the source identity; isolated old toe fragments outside the limb masks are removed. No whole-body scaling is used. Each stance advances backward 10.8 source pixels per frame to compensate actual world movement. The derivation and source/target joints are retained in the manifest and production-candidates/pursuer-gait-rig-r02/rig.json.

This scripted animation remains disclosed quality debt, even if the independent acceptance gate passes. It does not imply that the full pursuer inventory is ready.

## Validation

Actual AI transitions, rather than a manually selected clip, produce all eight frames in both facings. Desktop and phone-sized captures are in evidence/pursuer-walk-engine-r02 and evidence/pursuer-walk-phone-r02. Capture logs verify patrol/approach state entry, complete cycles, measured travel and mirrored ground pivots. These are desktop renderings at phone size, not physical-device tests.

The scope check verifies unrelated clip metadata is unchanged and all16 source, runtime and review PNGs are byte-identical. Gameplay regression, contract validation, the25 art-tool negative fixtures, browser boot/input/error checks and exported pack hash are recorded under evidence/pursuer-walk-*.

Independent visual verdict: REVIEW: PASS for both scoped clips; see art/review-pursuer-walk-r02/review_verdict.md. All1213 gameplay assertions, all25 art-tool negative cases and the64-clip/356-frame contract cross-check passed. Browser smoke reported no errors. This acceptance covers only the two locomotion clips.
