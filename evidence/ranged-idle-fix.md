# Ranged enemy rooted idle

Six150ms frames form the required900ms loop. A local mesh expands/lifts the chest, shifts the free forearm/wrist and follows with cloth, while the stone post and grounded base remain fixed. This D23 scripted fallback is labelled quality debt; no global animation scale, translation or per-frame normalization is used. The accepted source is `art/production-candidates/ranged-identity-r02/key.png`, with bounded uniform1.016949 static normalization. Exact generation prompts, raw/delivery images and derivation records are retained.

The first identity was independently rejected: bindings pinned the arm needed for later aiming, and the post cap overtopped the hood. The corrected source reroutes those bindings and lowers the cap. Fresh static r02 PASS confirms full anatomy/post/base, free aiming limb, concealed right-facing hood and consistent matte palette/materials. Full animation approval remains a separate gate.

`ranged-idle-native/` and `ranged-idle-phone/` capture every frame, loop wrap and natural detection into aim, in both directions at the enemy's actual stage root(4608,432). Production HP stays2. Phone evidence is desktop viewport emulation. Outgoing aiming artwork is still the explicit preview silhouette and is not approved by this scoped fix.

`ranged-idle-source-check.json` proves exact source/candidate/runtime/review PNG bytes, unchanged unrelated clip metadata and complete capture inventory. Art audit has zero defects/flags. The initial capture harness incorrectly treated the base-anchored sprite as center-anchored; its retained failure log is a fixture error, not a runtime pivot regression. The corrected harness transforms the authored base point through the actual sprite geometry.

Gameplay1,213 assertions and the actor-pivot, circle32 and recovery-entry17 regression groups pass. Logs are scoped to this fix. A session restart interrupted unfinished self-test/export/review work; those are rerun rather than inferred from partial logs. No physical device or remaining ranged action approval is claimed.

Final replacement independent motion review PASS: `art/review-ranged-idle-r01/review_verdict.md`, no flags or failing frames. Clean25-case tool self-test exited0 and export/hash completed after the restart. Chromium156 browser smoke passes with no errors. All six runtime frames are delivered with the tested web pack in this fix commit.
