# Independent boss_walk review

Scope: boss_walk only, review pack art/review-boss-walk-r01. This is not release-wide approval or approval of any other boss action.

## Protocol and evidence

I first opened only lineup_boss.png and strip_boss_walk.png, wrote blind_observations.md, and read that saved file back before reading intent, contracts, audit or derivation. I did not consult builder notes or earlier verdicts. The observations remain an unmodified record of that first impression.

Then inspected the onion sheet; all eight native RGBA frames composited correctly over grey; the boss identity key; ART_CONTRACT, relevant ART_BIBLE requirements and boss brief; ASSET_BRIEFS boss inventory; machine contract boss/clip definitions; audit.json and audit.md; clip/derivation entries; the actual leg-rig implementation and its per-frame source records; source normalization/provenance and retained failed-sheet rejection record. All eight reviewed frames byte-match the stated derived outputs. Inspected all FIVE image references in art/style-lock.json: neutral hero, attack key, pursuer, terrain patch, environment mockup.

Inspected the actual scene at native and phone sizes, plus all 18 current PNG samples in each evidence/boss-walk-native and evidence/boss-walk-phone, using lossless scene crops covering the full moving boss and ground. Each set contains both directions, frames0–7 and wrap0. Read both capture.json records for elapsed times, root positions, state, frame and viewport. The source frame composites use alpha weighting; hidden RGB is not treated as an opaque fringe.

## boss_walk — PASS

Anatomy and identity: full crowned helmet, neck, torso, both arms and hands, hips, two plated legs and boots remain present throughout. This is an armored revenant warden with a distinctly oversized striking gauntlet. It never becomes a torso silhouette, grows an extra limb, or changes its costume. F3–F5 have crowded ankles and shroud overlap, but progression from the preceding and following poses makes the two legs traceable. Leg bends preserve the plate segments' apparent lengths. The cloth occludes hips without visually severing the legs.

Size and style: the stable helmet width, chest and gauntlets avoid changing scale with the stride. The small downward body motion is weight response rather than shrinkage. Dark weathered metal, olive decayed shroud and restrained broad highlights agree with the painted style references and the boss brief. No bright chrome, warm ornamental cue, gore or unrelated visual treatment appears. Both mirrored runtime facings retain the identity and remain readable; lighting is sufficiently broad for the flip.

Gait and support: far leg supports through F0–F4; near leg lifts in F1–F3 and lands at F4. Near leg supports through F4–F7 and the wrap; far leg lifts F5–F7 and lands at F0. There is a planted boot throughout, including the two support changes. The two swings bend at the knee and clear the ground instead of merely translating a complete standing drawing. The gentle body/shroud response supports the heavy cautious advance. The almost unchanged upper body and flat boots give it a restrained mechanical quality, acceptable for this plate-bound warden; this remains declared scripted-animation quality debt.

Contact and motion: capture.json shows actual walk state at speed70, production HP8, elapsed0→0.6416667s and root6240→6284.9292 moving right, with symmetric left movement. That is about70.02u/s from recorded positions, consistent with70 plus runtime integration precision. At two source pixels/u, root travel is11.2source px per80ms frame. The source stance foot retreats11.2px per frame, cancelling root advance: far228.88→217.68→206.48→195.28→184.08, near179.88→168.68→157.48→146.28→135.08 across the wrap. Visible planted boots remain near their ground contact rather than continuously skating. The discrete80ms sprite holds necessarily permit a small within-hold glide; phone captures do not show objectionable sustained skating. A swing landing moves about18source px vertically from F3→F4 and F7→F0, a firm heavy footfall rather than a disconnected pose jump.

Continuity and loop: neighboring pairs preserve the same body construction and coherent leg paths. The blind concern about F7→F0 is resolved by the source/actual movement sequence: the raised far boot lands ahead while the near stance boot continues backward relative to root. Head/body change only2px at the wrap. No identity or size pop appears. Narrow leg silhouettes around F4 do not persist or read as missing anatomy during the cycle.

Phone scale: actual phone files are698×393 imagery within the reported852×393 viewport. At that scale the boss is roughly96px high and clearly larger than the hunter, with crown, gauntlet, shoulder and shroud silhouette readable. Plate decoration becomes texture as expected. Both alternating foot lifts and grounded support remain discernible, though subdued against dark lower scenery. No control overlay hides the boss. The native scene gives clearer knee detail and reaches the same conclusion.

## Audit adjudication

Audit reports one clip, zero DEFECT and zero FLAG; findings array is empty. There are no individual findings to waive. Reviewed numerical evidence: heights348–352px; foot512 every frame; head53px every frame; S192.369–202.598 against197.384 reference. This agrees with observed stable scale and supported stance. The machine contract requires512×576 canvas, pivot176,512, stride class, eight80ms frames and looping; the delivered clip records agree. A-10 facing is visually right in source and correctly mirrored left in engine. A-07 anatomy is confirmed visually rather than inferred solely from lower-body ratios. A-11/A-13 have no automated flag and no visible continuity defect on onions or the runtime sequence. No visible clipping, detached debris, opaque key background or conspicuous alpha halo is present in the inspected composites/captures.

## Limits

The engine evidence is sampled screenshots plus timing/root metadata, not continuous video or physical-device observation; both capture files explicitly set physical_device:false. I can judge the ordered gait, discrete cadence and wrap from the samples and onions, but not claim a live-device frame-pacing test. Contact assessment combines rendered samples with source records; it is not a subpixel optical flow measurement. The flat planted boots, quiet arms and crowded mid-stride leg overlap are modest quality limitations, not blockers for the intended heavy walk. Source provenance records a bounded0.93617 uniform normalization; the animation itself adds no global scale or recentering. D23 scripted fallback must remain disclosed as quality debt. No handoff to idle, turning, attacks or death is approved by this isolated clip review.

REVIEW: PASS
