# Independent review: turn r01

## Blind visual descriptions (recorded before reading contract or metadata)

Lineup tile STYLE_NEUT: full height brown-haired man facing right in layered brown leather coat/cape, cream sleeves, dark trousers, boots, belt and looped whip. Arms rest at his sides; feet planted. Head connects to raised collar and sloped shoulders.
Lineup tile TURN: same apparent character, height, costume and relaxed right-facing stance as the first tile.

Hero turn strip F0: relaxed right-facing standing man, both boots planted, arms down, long coat tails and looped whip at hip.
Hero turn strip F1: same man with wider stance and bent knees; torso appears more front-facing, right-side arm crosses abdomen, opposite arm extends down/out, head continues facing right. Cape broadens at shoulders and tails swing outward. Crown sits slightly lower than F0.
Hero turn strip F2: returns to the relaxed right-facing stance, matching F0 closely in height, costume and silhouette.

Style neutral strip F0: full height right-facing man in the same relaxed planted pose, layered brown coat, cream sleeves and metal bracers, whip loop at hip, dark trousers and boots. No visible loose debris.

## Scope and inspection

This verdict covers only `hero_turn` and `style_hero_neutral`. The other clips listed as missing in this scoped pack are outside this review. Inspected both lineup tiles, all four strip tiles, all four native PNG frames, both onion pairs, all five registered style images, and the five included runtime captures. No art was edited and no prior review was opened.

## Visual findings

The neutral reference is a complete body from crown to soles, with two distinct legs and boots, both arms and hands, and a compact coiled whip at the hip. Its face, tied-back hair, mantle, coat, cream sleeves, bracers and belt agree with the registered hero reference. It reaches the standing guide with feet at the pivot; it has no clipped anatomy, hard background rectangle or visible detached debris.

Turn F0 and F2 maintain that identity and scale. F1 lowers the crown by about ten pixels through a wider, flexed stance; the head itself remains comparable in size. It rotates the chest/shoulder silhouette toward the viewer, brings the near forearm across the waist, moves the other hand outward, and spreads the coat tails around the hips. The bent rear leg and loaded forward boot make the weight shift plausible. This is a quick planted twist rather than a character resized between poses.

The F1 head sits over a continuous neck/collar connection. The pale neck narrows into the shirt opening and the collar joins the mantle/chest; there is no gap, severed neck, floating head or extra shoulder. The face angle stays aimed toward the canonical right while the torso twists, which is physically plausible. The shoulder-to-upper-arm and forearm-to-hand joins remain continuous. Fine costume details change with occlusion and rotation without an obvious new armor piece or disappearing garment.

Onion F0→F1 shows a short lateral foot adjustment, knee bend, shoulder rotation and arm swing around the same grounded body. F1→F2 reverses the stance adjustment and lowers the arms into the neutral finish. At the declared 50/50/50 ms timing this reads as a brief turn accent; neither pair shows a detached limb, scale jump or an unsupported airborne body. The source frames face right throughout, as required for runtime mirroring.

`0_right.png` shows the neutral anticipation facing right; `1_right.png` shows the broad twist still facing right. `1_left.png` shows the same twist mirrored at the facing event, and `2_left.png` settles facing left. The flip moves the lead silhouette around the same grounded origin; it does not introduce a separate body-scale change. The mirrored neck, shoulders and boots remain plausible. `engine_phone_1_left.png` preserves the whole hunter silhouette and makes the wide twist/guarded arm read at phone-sized content resolution. These stills establish the supplied facing sequence and display-size readability; they are not physical-device playback evidence.

The turn's declared scripted derivation is acceptable on its delivered visual result: it reads as weight preparation, a torso/hip turn, and a neutral settle in conjunction with the supplied runtime facing event. The reference's 224 px height and turn heights 224/214/224 px agree with the visible stance change; reported head widths 39/40/39 px and size values 115.585/120.312/115.139 support the visual finding of consistent anatomy. No attack composite or effect is applicable to these two clips.

## Per-clip verdict

| Clip | Verdict | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| `style_hero_neutral` | PASS | None | None observed; complete canonical planted hunter. | None. |
| `hero_turn` | PASS | None | None observed; supported short twist, consistent neck/shoulder joins and identity, readable runtime flip and settle. | None. |

## Audit flag adjudication

The included audit reports 0 DEFECT and 0 FLAG for the two clips. There are no flags to accept or reject.

REVIEW: PASS
