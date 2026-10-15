# Independent animation review

Reviewer: /root/swooper_telegraph_review_r01. Scope: new `swooper_dive_telegraph` and unchanged `swooper_cruise` reference only. This is not approval of the missing swooper dive, recovery, hurt, death, perch or other actor inventory. I did not create or modify the production art. Opened the lineup and both strips and saved `blind_observations.md` before opening index, audit, intent, contract or reference material. The initial blind notes group visually similar frames rather than giving separate repeated paragraphs per tile; the explicit frame inspection below covers every native tile.

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| swooper_dive_telegraph | PASS | — | All four frames hold a complete, narrow folded-wing wraith at a stable body center; subtle local tightening and cloth quiver preserve the pose through the 600 ms tell. | None required in scoped clip. |
| swooper_cruise | PASS | — | All eight frames preserve identity and size; articulated outer wings narrow and descend toward f004, then reopen continuously through the loop seam. | None required in scoped reference. |

## Identity, completeness, size and direction

Visually inspected all 12 individual 384×256 source PNGs, both source keys, both strips, lineup, and both onions. Cruise f000 is the broad spread-wing key; f001 begins a slight membrane shift, f002 bends the outer wing inward, f003 deepens it, f004 is the smallest wing spread, f005 opens, f006 opens further, and f007 approaches the initial spread. Every frame retains the same hood, central torso, chest crossing, wing roots and long torn lower shroud. Telegraph f000 is the narrow folded key, f001 slightly tightens its membrane/hood, f002 tightens further with cloth-tip reversal, and f003 holds tension while cloth settles. None clips the silhouette or substitutes a torso fragment. This actor has no declared legs; its trailing cloth is complete and should not be mistaken for missing anatomy.

The hood projects right and cloth streams left in source images. Cruise is a three-quarter, nearly frontal spread but retains the rightward hood cue; folded frames are more explicit. Head/body remain comparable in scale between source keys; narrower folded ink area is caused by overlapping wings, consistent with the declared size override, rather than whole-body shrinking. The lineup loses wingspan intentionally while retaining the full vertical shroud. Body-center registration is stable, with no global translation or scaling visible across either clip. There is no feet/ground-line requirement for this center-aligned flyer.

## Motion and derivations

Inspected cruise onion pairs f000→f001, f001→f002, f002→f003, f003→f004, f004→f005, f005→f006, f006→f007, and seam f007→f000. None jumps in body identity, size, wing attachment or position. Movement is restrained but visibly jointed at native resolution; the center and tail remain fixed while outer wings flex. The broad flight silhouette remains distinct from the narrow tell.

Inspected telegraph pairs f000→f001, f001→f002 and f002→f003. Membrane and cloth contour changes are small and continuous; no second torso appears and no limb teleports. It is a held anticipation, not an unfolding transition: f000 is already fully narrow, and all four 150 ms intervals preserve that warning. Its movement is deliberately slight. At phone size the small quiver is largely lost, but the silhouette carries the warning throughout; I do not require large motion that would destroy the fold.

Both scripted fallbacks are explicitly declared in index and derivations metadata. Read the actual preparation scripts. Telegraph derives from `art/production-candidates/swooper-fold-r01/key.png` using localized membrane/hood/cloth mesh changes; cruise derives from `art/production-candidates/swooper-identity-r02/key.png` using separate wing meshes and fixed central paint. The viewed sources match their delivered identities. These derivations read as the intended actions and are acceptable under §11. They remain scripted-fallback quality debt for handoff, especially the restrained held acting; that declaration is not a claim of newly painted independent in-betweens.

## Style and engine evidence

Read ART_CONTRACT, ART_BIBLE, swooper ASSET_BRIEFS and machine contract. Read `art/style-lock.json` and visually opened all five registered references: neutral hunter, attack hunter, pursuer, terrain patch and environment mockup. The swooper's matte desaturated bone/olive membranes, dark shroud, detailed painted edges and upper-left lighting belong to that style family. There is no gore, baked rectangle, key-color residue visible to the eye, text, glow or foreign iconography.

Opened both capture.json files and every captured telegraph PNG in `evidence/swooper-telegraph-native` and `evidence/swooper-telegraph-phone`: right/left f00–f03 at 1280×720 and phone viewport (852,393). The phone PNG presents a smaller rendered play area; judged at its delivered size without enlarging it. Both directions retain a narrow, clearly separated floating threat above the stage. Cloth micro-detail reduces, but hood/wing mass and the long narrow outline survive against the teal background. No UI obscures the tell. The records report natural detection, stationary roots, frame changes at 0/.15/.30/.45 s and a .6 s tell. These are desktop engine viewport captures (`physical_device: false`), not physical-device validation.

Entry compares the broad cruise reference with the fully folded first frame: the sudden narrow silhouette is the specified snap-fold tell, with no identity or body-size substitution. Capture histories report cruise before detection, but there is no immediately preceding cruise screenshot, so visual entry assessment uses the native reference rather than claiming a filmed handoff.

Opened both directions of the post-tell `dive-*-f00.png` at both viewports. At transition the painted tell gives way to a geometric placeholder flying enemy; it is an obvious art discontinuity. The root stays at the same recorded position and gameplay state advances, so this does not reveal a registration defect in the telegraph. The missing dive artwork is explicitly outside this review's scope and is NOT approved. This pack's scoped PASS must not be presented as approval of that placeholder, a completed swooper sequence, or release readiness. A later dive review must assess the painted outgoing handoff as well as the active dive.

## Audit adjudication

`audit.md` reports 2 clips, 0 DEFECT and 0 FLAG. No FLAGS to accept or reject. The folded-wing size override is justified visually by overlapping wings and consistent hood/body dimensions. No attack compositing or VFX strips belong to this scope. The other 62 missing clips listed in index are outside this two-clip review and receive no approval.

REVIEW: PASS
