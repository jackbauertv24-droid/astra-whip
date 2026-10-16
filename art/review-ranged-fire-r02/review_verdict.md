# Independent ranged fire review

Reviewer: fresh independent agent /root/ranged_fire_review_r03. Scope: ranged_idle, ranged_aim and ranged_fire in review-ranged-fire-r02. No art edits performed. The lineup and all three strips were opened first; two sentences per each of the 15 tiles were persisted to blind_observations.md and reread before intent/index/audit/contracts were read.

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| ranged_idle | PASS | None | Full rooted hooded figure, single connected pale arm, subtle breathing/cloth/hand sway, steady funerary post and grounded base. Six-frame loop and last-to-first seam remain coherent. | None |
| ranged_aim | PASS | None | The same arm lifts continuously through six poses; elbow, wrist and hand remain connected. The small initial green cue becomes a clear pointed diamond at the hand without changing actor size or adding a second arm. | None |
| ranged_fire | PASS | None | Exact incoming aim endpoint holds for 50ms, diamond contracts/fades on the next 50ms frame, then disappears as the forearm retracts slightly and rises into a 100ms recoil hold. Hand remains clean and connected without a persistent charge fragment, warm patch, detached duplicate or rectangular edge. | None |

Identity, construction and motion

Opened every individual native frame (idle f000–f005, aim f000–f005, fire f000–f002), all three onions and all strips. The robe-to-ground creature is complete from hood to stone base; no legs are declared or required. Every source faces right. The 300px figure height and stable post/base register visually across clips. Hood, bindings, layered moss cloth, post cap and pooled lower robe preserve the identity-r02 construction. The aim key and clean-body/clean-hand sources preserve this same painted identity. There is only one visible aiming arm throughout, and its forearm sits in front of the robe without an empty cutout or extra limb.

Idle adjacent pairs 0→1, 1→2, 2→3, 3→4, 4→5 and loop 5→0 show small localized changes rather than whole-figure scaling. Aim pairs 0→1 through 4→5 advance the arm in one coherent arc and slow toward the final hold. Fire pairs 0→1 and 1→2 preserve shoulder/body registration; the latter gives a small upward/backward wrist response, appropriate to a rooted caster. It is restrained recoil rather than a large bodily flinch, but reads as release after the brighter held tell. Incoming aim f005→fire f000 has no pose or cue discontinuity.

Style and intent

Read ART_CONTRACT, ART_BIBLE, the ranged section and shared requirements of ASSET_BRIEFS, contract/art_contract.json, pack index and audit. Opened all five style-lock images: hero neutral, hero attack key, pursuer, terrain patch and environment mockup. The enemy's pallid limb, matte decaying cloth, restrained phosphor cue and worn stone belong with their painted treatment. No explicit gore, exposed face, arbitrary bloom, baked floor plane, visible clipping or stray large detached debris was found. The charge supplies a shape cue, not color alone.

Audit flags

The pack audit reports three clips, zero DEFECT and zero FLAG; there are no flags to waive. Its stable 300px heights and 320px foot lines agree with visible registration. Audit success was not used as the visual verdict.

D23 derivation assessment

Inspected tools/prepare-ranged-fire.mjs, tools/prepare-ranged-fire-clean-body.mjs, candidate-r02 derivation.json and hand-correction.json. The declaration accurately describes exact aim-end reuse, local alpha-aware generated hand correction, separately composited shrinking/fading painted diamond, and localized six-degree/six-pixel forearm recoil. The correction uses an eight-pixel alpha-aware wrist blend and preserves the rest of the source. The delivered frames show no visible patch boundary or inappropriate replacement of the actor's identity. This remains declared scripted-animation quality debt; a visual PASS does not turn it into newly painted in-betweens. Prior verdicts, builder notes, regression summaries and rejected artwork were not opened.

Runtime evidence and limitations

Opened all ten PNGs in each of evidence/ranged-fire-native and evidence/ranged-fire-phone: before-aim, fire f00/f01/f02 and recover f00 for both directions. Read both capture.json files. At 1280×720 and the phone capture size, both facings retain the complete rooted silhouette, stable ground, visible forward arm and bright initial diamond. The hand neighborhood loses its charge progressively and f02 has a clean pale hand. Mirroring does not reveal an arm seam or change the character. The native foreground and masonry do not hide the cue; the phone view retains the compact diamond/release contrast, while the very small recoil is less prominent there, as expected from its brief extent.

JSON records fire frames at 0, 58.33ms and 108.33ms, one projectile from frame1 onward, no actor-position change, and approximately208.33ms total runtime for the nominal200ms clip. This is compatible with frame-quantized sampling of50/50/100ms. The f01 hand remains in the same muzzle neighborhood in both facings; no visible anatomical jump accompanies the spawn sample. The JSON establishes projectile event timing/count, while the captures do not independently prove exact sub-frame timing or projectile flight trajectory. These are screenshots, not continuous playback or physical-device evidence (physical_device=false in both JSONs). Phone evidence is a viewport capture, not a device test.

Outgoing recover graphics visibly use an unapproved placeholder and projectile graphics are explicitly unapproved; both are excluded from this gate. Their screenshots were opened to inspect the boundary context, and this verdict does not approve either asset or the outgoing visual handoff. Missing unrelated clips listed in the filtered pack index are outside this three-clip review, not silent approvals. No whip/composite review applies to these ranged creature clips.

REVIEW: PASS
