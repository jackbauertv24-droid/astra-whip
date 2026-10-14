Independent scoped review — gait r19

Scope: `hero_walk` and `style_hero_neutral` only. Blind observations were saved in `blind_motion_observations.md` after viewing the lineup and both strips, before opening the contract, index, audit or derivation metadata. No prior review verdict was consulted. Inspected all eleven native frames, all ten onion pairs including F9→F0, and all twenty desktop/phone engine PNGs. Read the art review protocol, art contract, art bible, animation specification, style lock, scoped clip metadata and both capture records.

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| style_hero_neutral | PASS | — | Complete upright hunter, coherent limbs and costume, grounded boots, held hip coil, right-facing canonical identity. | None. |
| hero_walk | PASS | — | Full articulated alternating stride, consistent portrait and physical proportions; support transfer and swing remain readable during actual travel and at phone size. | None. |

The neutral is a complete person rather than an enlarged torso. Walking retains the face, hair mass, mantle, leather torso, bracer, hip coil and boot construction. Walking height varies 218–224 source pixels against the 224-pixel reference, with a modest vertical weight shift rather than a scaled body. Both legs remain present through the overlapping passing poses. Cloth overlaps the knees without concealing an anatomical disappearance. F3's exposed rear trouser/boot is darker, but its continuity into the rear leg at F4 remains legible; it does not introduce a different limb or costume piece. The coil remains attached at the hand/hip throughout.

Onion adjudication: F0→F1 rear-foot lift/front support; F1→F2 folding swing and closing legs; F2→F3 unfolding forward swing; F3→F4 lowered forward foot and rear heel release; F4→F5 trailing-leg advance under the coat with rising torso; F5→F6 knee lift; F6→F7 extension; F7→F8 lowering/rear heel release; F8→F9 opening contact; F9→F0 small continued extension/settle. Each pair retains one body. F4→F5 has the strongest upper-body rise and cloth silhouette change, but it is a small weight-transfer beat, not a scale jump. F9 and F0 are distinct close contact poses; their seam does not reverse the stride or duplicate an entire held phase.

Grounding was judged with capture.json, not a stationary strip alone. Both engine captures record a 0.4-second cycle at playback rate 2, speed 240 units/second, and 96 units of travel per cycle. Sample origins progress 678,688,698,708,718,728,736,746,756,766 at their recorded times. In the first support phase, the front support boot moves approximately twenty source pixels backward per ten game units of root travel (F0→F1→F2→F3), keeping its world contact near the same masonry point. At F4 the advancing boot takes contact as the previous support releases. The second support phase moves backward beneath the advancing root with a shorter visible heel/toe roll. Small residual contact drift is present in the latter phase, but neither desktop nor phone sequence reads as stationary legs being carried across the floor. Swing boots visibly clear the floor. The support foot is grounded in each frame; the prominent F3 extended boot is airborne, not a second planted support.

Derived-action adjudication: hero_walk is declared scripted_fallback. The result reads as walking through actual knee, hip, ankle, coat and modest arm/torso changes; it is not an unarticulated portrait translated through the level. Ten poses provide distinct progression; modest upper-body movement is sufficient alongside the lower-body action.

Every audit FLAG adjudicated:

- A-08, hero_walk F4, head width 1.051× reference: ACCEPTED. The 41-pixel top-band width versus 39-pixel reference comes from the hair/profile silhouette; the face remains the same adult portrait with no visible head enlargement or alternate character.
- A-11, hero_walk F2→F3, size +6.3%, height unchanged: ACCEPTED. F2 overlaps the legs in passing; F3 exposes the extending forward boot, separated legs and broader swinging coat. Head/torso and limb dimensions remain stable. The area increase reflects exposure of articulated parts rather than whole-body growth.

Unrelated missing clips and derived clips outside the stated scope are excluded from this verdict.

REVIEW: PASS
