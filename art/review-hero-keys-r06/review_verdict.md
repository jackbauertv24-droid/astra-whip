# Blind visual notes (recorded before reading text)

Opened lineup.png first, then key_1.png through key_7.png individually.

1. Full brown-haired male adventurer facing right, layered brown coat, pale sleeves, gloves and tall boots. Upright relaxed stance; near hand holds a hanging brown coil. Head and feet visible.
2. Same adventurer mid-step, rear foot lifted and forward boot planted. Near arm hangs with coil; opposite arm slightly forward. Head slightly lower than neutral.
3. Same adventurer in a longer walking stride, rightward/front leg extended, other leg behind. Coil stays with the near hand. Coat tails spread around legs.
4. Same neutral-looking upright adventurer, near hand carries a short downward-pointed handle instead of the obvious coil. Head and feet visible.
5. Wide bent-knee stance, near arm raised with elbow bent to upper left and fist near head height, short handle projects left from fist. Opposite hand rests near front waist. Coat opens with stance.
6. Same wide stance; near arm extends horizontally to the right across upper chest, fist holding a short rightward handle. Opposite hand at waist. Shoulder, elbow, wrist chain looks continuous.
7. Same wide stance with near arm lowered diagonally across body toward waist and short handle angled downward/right. Opposite arm/hand lies close beside it; hands overlap somewhat but remain plausible.

Across lineup, identity and costume look coherent; walk poses have modest lowered heads and attack poses crouch. No obvious cropping, extra limb, or severe proportion collapse. These are isolated poses, so no motion-quality inference is made.

# Scoped assessment

This verdict approves or rejects isolated body keys only, as specified by scope.md. It is not a clip/release acceptance gate. Timing, in-betweens, loop seams, rope attachment/reach/progression, effects, and engine captures were not provided and are outside this review. References inspected: style_hero_neutral/f000.png and style_hero_attack_key.png only. No other review or builder reasoning was consulted.

All seven keys retain the reference's brown tied-back hair, warm face, mantle, linen sleeves, leather torso, belt, bracers, split coat and knee boots. All face right and show a full anatomical body from head to soles. No visible hard matte rectangle, cropped extremity or detached debris. Walk height 218 px versus neutral 224 is a small gait bend, not a shrunken person. Attack keys retain head and limb scale while knees spread and bend; their 217 px silhouette is appropriate to a strike, not a crouch-class key.

The weapon arm is consistently the viewer-near arm: it hangs at the left side of the image in keys 1–4, rises on that side in key 5, crosses the chest and extends right in key 6, and lowers across the torso in key 7. The opposite arm stays the front/right resting or balancing arm. There is no visible arm swap. In keys 4–7 the short grip meets the closed glove; the projected shaft is not floating beside an open hand. Key 7's hands are close, but the near bracer and diagonal forearm distinguish the returning weapon arm from the opposite hand.

| Key / intent | Verdict | Failing key | Defect and smallest correction |
|---|---|---|---|
| 1 — neutral identity | PASS | — | None. Complete reference-consistent upright body and near-hand coil. |
| 2 — walk intermediate rear heel lift | PASS | — | None. Rear heel/boot lifts with a bent leg; forward leg bears weight. Coil stays in near hand. |
| 3 — opposing walk contact | PASS | — | None. Near coat-covered leg is forward and far gray-trouser leg is back; both boots remain anatomically connected. |
| 4 — lowered attack grip | PASS | — | None. Neutral scale maintained; short downward grip joins near glove at hip. |
| 5 — wind-up | PASS | — | None. Raised near upper arm, elbow and wrist form a plausible bent chain; closed glove holds left-projecting grip. |
| 6 — extended strike | PASS | — | None. Near shoulder/sleeve crosses in front of chest into a continuous horizontal forearm; glove holds right-projecting grip. |
| 7 — follow-through/return | PASS | — | None. Near forearm lowers across body with grip still held; opposing hand is nearby but no fused or extra limb is visible. |

# Measurement observations and limits

Foot line is 448 in every supplied measurement. Heights are 224, 218, 218, 224, 217, 217, 217. Relative ink-size S versus key 1 ranges from approximately −0.8% to +7.9%, within the supplied stride/strike per-frame ±8% band, with key 5 close to its upper bound. The wider attack stance and exposed sleeve explain additional visible ink; there is no obvious physical enlargement.

Head-band widths of keys 2–4 (42, 43, 41 versus reference 39) exceed the nominal ±5% proxy for keys 2 and 3, and slightly for key 4. Visually the face/skull scale remains consistent; hair silhouette and viewing angle broaden the measured upper band. These are observations in measurements.json, not formal supplied audit FLAGs. Full production audit must adjudicate A-08 under its actual per-frame pose classes; this visual key verdict does not waive a future automated DEFECT. Key 5's 68-pixel top-band width includes the raised arm/grip and cannot represent anatomical head width; strike head rules explicitly skip that proxy.

No audit.md or audit.json was supplied in this isolated pack, so there are no supplied FLAGs to accept. No required scoped image was missing or unreadable.

REVIEW: PASS
