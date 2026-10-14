# Independent scoped review — ground attack r02

Reviewer: /root/ground_attack_review_r02. I did not generate, process or audit this art. I opened all lineup and strip images first and saved `blind_observations.md` before reading contracts, indices, audits or metadata. No prior verdict or builder notes were consulted. Scope is exactly the three clips below; missing out-of-scope clips in the generated index are not findings in this review.

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| style_hero_neutral | PASS | — | Full right-facing hunter, intact head, torso, articulated legs and boots; stable reference scale, leather/linen/steel material distinction and readable silhouette. | None. |
| hero_attack_ground | PASS | — | Recognizable same hunter through a raised-arm windup, forward same-arm strike, follow-through and two-foot recovery. All eight frames are distinct action targets; no disappearing limb, disconnected shoulder, costume replacement or unsupported recovery. | None. |
| whip_attack_ground | PASS | — | Registered grip and visible glove occlusion in every composite/capture; thin tapered textured leather, compact rest coils, long active reach and progressively gathered recovery. | None. |

## Evidence inspected

Opened every native snapshot PNG (8 body, 8 whip, 1 neutral), both onion sheets, the composite, lineup and every strip. Read the requested review prompt, ART_CONTRACT, ART_BIBLE, ANIMATION_SPEC, style lock and machine contract; scoped clip timing, derivations, sockets and occlusion metadata; neutral provenance and normalization; both ordinary and supplemental strict audit JSON/Markdown. Opened all five style-lock image references, including the environment reference image only, without opening its prior review verdict.

Opened all 16 PNGs in each of `evidence/ground-attack-engine-r02` and `evidence/ground-attack-phone-r02`, including every frame in both facings. Read both capture.json files. The capture logs `ground-attack-capture-r02.log` and `ground-attack-phone-r02.log` both end in PASS for eight synchronized frames in both facings with mirrored sockets within 0.001 units. Captured active samples are F2 at 0.15 s and F3 at 0.208333 s; F4 at 0.258333 s is inactive. Both sets report socket_error_max 0.0.

## Adjacent-pair motion judgement

Timing is 75/75/50/50/62.5/62.5/62.5/62.5 ms, 500 ms total. Judgements below use native frames, onions, composites and the corresponding engine/phone samples. These are discrete timed frame captures, not a claim to have viewed a separate video.

| Pair | Body | Weapon |
|---|---|---|
| F0→F1, 75 ms | Broadens into a bent, supported stance while the striking elbow rises; head and trunk turn without changing identity. Large but readable anticipation. | Compact hanging coil becomes a swept-back elevated arc at the raised fist; a fast uncoiling anticipation, with grip remaining in hand. |
| F1→F2, 75 ms | Same raised arm extends through the shoulder into the forward strike. Both wide-set boots support the rotation; no arm substitution. | Arc casts forward to a long taper; rapid reversal is appropriate to the strike, and hand registration survives the large travel. |
| F2→F3, 50 ms | Small additional extension and head/torso lowering sustain the active beat; not an identical duplicated hold. | Wave and tip advance modestly while keeping full active reach; no detached root. |
| F3→F4, 50 ms | Elbow retracts and hand lowers toward the belt while broad support remains; readable fast follow-through. | Extended line curls down into a broad forward loop, preserving its visible connection to the lowering hand. Fast recoil reads as flexible weapon motion. |
| F4→F5, 62.5 ms | Arm returns toward the side; forward boot lifts while rear boot bears weight. Torso begins returning upright. | Forward loop tightens and lowers around the returning hand path; no blank phase or new separate object. |
| F5→F6, 62.5 ms | Forward boot replants and rear boot lifts to gather the stance. This is an articulated support transfer rather than the whole figure sliding. | Recovery loop contracts toward the hip, with a coherent curling direction and diminishing tip distance. |
| F6→F7, 62.5 ms | Rear boot replants beneath the recovering torso; head and coat settle toward neutral. Small foot repositioning reads as the final gathering step. | Small coil settles beside the lowered fist and matches the starting rest treatment. |

F7→neutral is not a loop requirement, but the final upright silhouette and lowered hand provide a plausible return. Standing head height returns to the design guide; the 212–224 px strike heights come from knee/torso articulation rather than shrinking. All frames retain two legs, usable boots and the same long coat, mantle, light sleeves, belts and hair. Neither foot recovery step requires both feet to float.

## Grip, reach, material and derivation

The cyan hand socket lies within the fist, not in adjacent empty space. The separate grip aligns with the body's handle direction, with the center hidden by the glove in composites and runtime. F1 and F2/F3 make this especially clear; F0/F6/F7 coils partially overlap coat-colored regions but remain connected and readable in the native images. Mirroring retains those relationships. The whip has a thicker textured root and a slender terminal taper; it does not become a rigid bar. F2/F3 pass through the yellow active area and extend beyond its far edge. In strict audit metrics their maximum x is 600/610 versus pivot x 256, giving 344/354 px reach. Rest bounds are 33×67 and 33×67 px, comfortably small beside a 224 px hero. Tip distance rises 57.219→149.164→276.684→281.853 then falls 182.016→136.4→68.731→58.549 px across recovery. These measurements support rather than replace the visual judgement.

The body derivation reuses painted action poses and in-betweens; it reads as a complete articulated action. The scripted weapon curves read as a flexible braided whip within the same muted leather material family. At phone size the fine braid reduces naturally, while the arc, full extension and recovery loop remain visible. The hunter remains distinguishable from the cool masonry and background in all captures. No visible source-canvas rectangle, cutoff, floating debris, glow or material change was found in scope.

## FLAG adjudication

- **A-11, hero_attack_ground F001, F0→F1: size +6.2%, height −3.1% — accepted.** This is the single finding in both audits. The raised bent arm, opened shoulder silhouette and spread coat/stance expose more painted area. The head, boots and limb proportions remain consistent in the native pair and onion; this reads as loading the strike, not a body scale pop. No correction required.

The supplemental strict audit reports zero defects under its documented thinner root/tip limits; it does not silently replace the production contract. No additional scoped FLAGS are present.

REVIEW: PASS
