# Independent animation review: swooper cruise r01

Reviewer: /root/swooper_cruise_review_r01. Scope: the single present clip, `swooper_cruise`; the 63 absent clips remain a separate production queue. This is an animation acceptance review, not acceptance of the complete actor inventory or game.

The lineup and strip were opened first and blind observations were successfully saved to `blind_observations.md` before reading intent, audit, contracts or metadata. I subsequently opened all eight native frame PNGs and the complete onion sheet, including F7→F0. I read `prompts/ART_REVIEW.md`, `docs/ART_CONTRACT.md` including allowed derivations, `docs/ART_BIBLE.md`, the swooper section of `docs/ASSET_BRIEFS.md`, `contract/art_contract.json`, `art/style-lock.json`, the pack index/audit and derivations, and the source rig declaration. I visually inspected the source identity key and all five registered style reference images. Engine evidence inspected: native and phone right-facing F0/F4/F7/wrap-F0 and left-facing F0/F4, with both capture manifests. Captures are engine screenshots, not physical-device tests.

| Clip | Result | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| swooper_cruise | PASS | — | Broad shrouded winged creature performs a restrained, continuous articulated cruise beat; identity, body pivot and scale remain stable. | None required for this scoped clip. |

## Frame and motion findings

F0 shows the full winged shroud, both extended wings, hood, central body and trailing tatters; no feet are expected for this legless flight actor. F1 starts drawing the outer wing tips downward and inward. F2 continues that bend with clearly narrower spread. F3 approaches the narrowest downstroke; F4 is its extreme. F5 opens again, F6 continues opening, and F7 approaches the starting spread. All retain the same hood, wing bones, rag pattern and trailing body. None is clipped, missing an anatomical part expected of this design, or surrounded by obvious loose debris or a background rectangle.

Both wing membranes change their outline relative to the stable shoulder/body, rather than the entire sprite floating, rotating or resizing as a unit. The elbows and outer fingers flex visibly; the bent F4 wing silhouette differs from the extended F0 silhouette. This reads as a shallow, slow cruise stroke, not a strong climbing stroke. That distinction fits this clip. The shroud/tail itself is almost completely held; this makes the motion somewhat mechanical, but does not erase the wing articulation or prevent the intended cruise action from reading. It remains known quality debt of the declared scripted fallback, as required by §11.

Every onion pair F0→F1, F1→F2, F2→F3, F3→F4, F4→F5, F5→F6, F6→F7 and F7→F0 shows small continuous wing movement around a stable torso. No pair teleports a limb, changes costume, changes body size or shifts the body pivot. The seam is an ordinary small closing step, not a held duplicate followed by a snap. The 8×90 ms, 720 ms looping sequence agrees with the manifest and engine capture timing. Native source inspection shows no visible crack or hard cut at the wing-root mesh joins.

## Identity, facing, scale and palette

The complete small shrouded body is present throughout, and the wing envelope changes by articulation rather than global shrinking. Alignment is around the central body, not the rag-tip or a ground foot line; the native pivot cross stays within the body. The hood is oblique and fairly frontal, so the facing cue is modest, as recorded in the blind observations. On closer native inspection its projecting hood and descending opening incline toward the source's right, with the long trailing shroud sweeping left. This is sufficient for rightward orientation in this nonhuman design. Engine mirroring produces the corresponding leftward silhouette without a lighting contradiction.

The matte ash/old-bone gray membranes, shadowed hood and ragged silhouette fit the registered illustrated horror style. They carry restrained warm bone/brown highlights, not an ember signal or a luminous effect. There is no palette flashing, explicit wound/gore, bright whimsical detail or obvious franchise marker. Relative to the registered pursuer, hero and environment references the paint treatment remains coherent.

## Engine and phone readability

At native engine size the wing bend remains easy to distinguish between F0 and F4 while the enemy moves through cruise. At phone screenshot size fine membrane texture largely disappears, but the broad wings and tapered hanging shroud still identify a flying threat, and the narrower F4 spread remains distinguishable from F0. Its light gray/bone outline separates from the teal distance and dark masonry in the supplied scene; it is not lost behind foreground or fog. F7→wrapped F0 does not introduce an obvious silhouette or position snap beyond normal world travel. The left-facing samples retain the same readable winged threat shape.

The phone manifest describes a nominal 852×393 viewport; the displayed image content has a narrower scene area at that height, so this judgment is based on the actual supplied screenshot pixels, not an assumption of full 852-pixel scene width. No claim of physical handset testing is made.

## Audit and derivation adjudication

The scoped audit records 0 DEFECT and 0 FLAG. There are no FLAGs to accept or dismiss. The scripted derivation is explicitly disclosed and permitted by ART_CONTRACT §11. My acceptance rests on the visible independent bending of wing sections and stable anatomy, not the rig's claim to articulation. Whip, attack composites, crouch anatomy, effects and other actor clips are not applicable to this single flight clip.

REVIEW: PASS
