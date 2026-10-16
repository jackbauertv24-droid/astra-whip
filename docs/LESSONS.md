# Lessons from the first implementation

One complete build of this specification exists: [askjackb/gothic-whip-game](https://github.com/askjackb/gothic-whip-game) (playable at https://askjackb.github.io/gothic-whip-game/), with its production log in [askjackb/gothic-whip](https://github.com/askjackb/gothic-whip) (`docs/REVIEW_RECORD.md`, `docs/SPRITE_TESTING.md`). It used Godot 4.7.2, 64 clips / 357 AI-painted frames, and was built autonomously in two days (2026-10-08 to 2026-10-09). It then needed five rounds of fixes, every one triggered by a person looking at the running game.

This file records what that build proved about the specification, so that the next implementation does not pay for the same lessons. Each lesson points to the rule that now encodes it.

## Art

| # | What happened | What the spec lacked | Now encoded in |
|---|---|---|---|
| L1 | Clips generated as separate sheets came out at different scales (walk −14%, crouch taller than standing). A per-actor scale did not fix it, and neither did a per-clip median | A per-frame size rule; a size measure that survives pose changes | ART_CONTRACT A-05, A-06, A-12, G-03 |
| L2 | The standing idle was a waist-up torso stretched to 224 px. Three audits passed it, because a stretched torso has the right bounding box | Anatomy rules; a reviewer forced to describe what it sees | ART_CONTRACT A-07, A-08, §9 |
| L3 | Crouch transitions were drawn as a smaller man (head 31–33 px against 38), so crouching read as zooming out | "Rigid parts keep their size" | ART_CONTRACT A-08 in the crouch and transition classes |
| L4 | The whip floated beside an empty fist, and its coil was the hero's height | Hand socket, grip, thickness and coil-size rules | ART_CONTRACT W-01…W-06 |
| L5 | The whip jumped between unrelated shapes (coil, coil, arc, straight bar); impact effects jumped from 102 to 256 px and back | Motion-progression and effect-size-curve rules | ART_CONTRACT W-05, V-03 |
| L6 | The boss had the torso defect too; the leg check had exempted "robe" characters | One anatomy rule applied to every actor with legs | ART_CONTRACT §2 "has legs" column |
| L7 | A full-screen red vignette went through green-screen keying and came out fully transparent: the damage flash never rendered | Screen effects belong in engine code | ART_CONTRACT V-04 |
| L8 | Specks, cell-border rectangles and a detached hand survived extraction; some frames were cut off by too small an extraction canvas | Extraction rules | ART_CONTRACT A-03, A-04, G-05 |
| L9 | Each fix claimed "verified" and was wrong three times, because every check measured extents | Checks proven to fail on the defect | ART_CONTRACT §10, `tools/selftest.mjs` |
| L10 | A fast motion (the 500 ms whip) cannot be judged from browser screenshots, which took ~1.3 s each in headless Chromium | Motion review from frame data | Onion-skin sheets (§9); engine frame-step test (VALIDATION V3) |
| L11 | When the image service failed mid-fix, an idle was rebuilt from another clip's frame plus a scripted breathing loop | A policy for fallbacks | ART_CONTRACT §11 (allowed, labelled, reviewed) |

## Gameplay

| # | What happened | What the spec lacked | Now encoded in |
|---|---|---|---|
| L12 | Crouching under a thin one-way platform trapped the hunter permanently: the clearance check counted the one-way slab as a ceiling, so neither standing, jumping nor moving was possible | What one-way platforms do to clearance; a no-trap rule | GAMEPLAY_RULES §6.1 |
| L13 | Ordinary crouching never switched to the 40×60 crouch body (only one landing path did), so crouch did not dodge anything. Every test passed | A test tied to each rule | VALIDATION "Rule-to-test traceability" |
| L14 | The jump rose 133.4 u, not the analytic 128 u, from discrete integration | A tolerance for measured motion | GAMEPLAY_RULES §6.1 note; VALIDATION V3 |

## Pipeline and verification

| # | What happened | Now encoded in |
|---|---|---|
| L15 | After repacking atlas PNGs, Godot kept sampling its old import cache, and the whip briefly drew a swooper wing | TECHNICAL_SPEC §7: re-import after every repack; compare packed atlases against source frames pixel by pixel |
| L16 | Proving the live site matched the local build needed a checksum of the downloaded `.pck` | TECHNICAL_SPEC §7 |
| L17 | All runtime evidence came from desktop Chromium with software rendering; the iPhone 17 target was never tested | VALIDATION: device gates stay PENDING and are reported as such in every handoff |

## What worked and should be kept

- Treating state machines as authoritative and sprites as passive (the whip frame is locked to attack time, not to animation playback).
- Archiving every pre-fix frame, which made each fix reversible and let each new check be proven against the old defect.
- Writing what was *not* tested in every review entry.
- The gameplay numbers: every constant in the shipped code equals this specification's, and the derived proofs (jump envelope, whip timing, boss punish windows) held in play.
# Implementation lesson: authored horizontal origin

The local normalization helper initially inferred horizontal origin from the bottom boot band. This shifts a tucked airborne pose toward a trailing boot and a falling pose toward a leading boot, making the torso slide sideways between actions. Foot-line auditing checks vertical registration and cannot infer an anatomical horizontal origin from arbitrary ink.

`tools/normalize-frame.mjs` now accepts an explicit authored horizontal guide origin for air/impact poses. It still applies one bounded uniform scale. `tools/test-normalization.mjs` demonstrates the legacy drift, verifies that the authored origin preserves placement, and verifies the scale-bound rejection. Both pre-fix and corrected production candidates remain archived. Engine captures and independent continuity review must still assess horizontal placement.


### Supported recovery needs a continuous support-foot path

Reversing a fall can preserve identity and numeric size while leaving the body unsupported during recovery. A seated hold, kneel and standing pose are individually plausible but do not automatically form a continuous get-up. Track the forward boot in canvas coordinates through leg draw-in, palm release and rising: finish repositioning before that foot carries weight. Neighbour references must preserve this path. The independent get-up reviews r01–r03 rejected unsupported transfer and one-boot-length sliding despite zero numeric defects; r04 accepted the corrected six-pose recovery.

### Sprite registration must use each actor's contract pivot

The renderer reused the pursuer offset for every non-hero actor. Full-canvas sprite registration then misplaced the swooper by (16,-48) world units, ranged enemy by (16,24), and boss differently in each facing. Ink-size audits cannot detect a runtime transform error. `game/tests/actor_pivot.gd` places a registration pixel at each contract pivot on a full-size texture and transforms it through the actual sprite for both facings. The archived previous renderer fails six cases; the corrected renderer passes all ten. Hero and pursuer offsets remain identical.

### Circle collisions require rectangle-to-circle distance

The swooper's declared circle was approximated by a 60-unit distance to the hunter's center, which missed real contact near the top and bottom of the hunter. Whip hits used the circle's bounding square and could hit empty corners, consuming the target's once-per-attack slot. A 32-case engine regression reproduces 12 failures in the previous implementation across both facings and standing/crouched bodies. It exercises actual damage and attack deduplication, not just a standalone math helper. The repair measures distance from the circle center to the closest point of each body/attack rectangle, using the authoritative 40-unit radius. `tools/test-game.sh` now includes this suite and the actor-pivot regression. Pixel art audits do not establish runtime collision geometry.

### Recovery interpolation must start at the actual entry altitude

The swooper climb assumed every entry came from the 64-unit low pass. Its conditional nonlethal hurt branch also entered that state after damage at patrol or mid-climb altitude, causing an immediate downward teleport. Capture the actual y position on recovery entry and interpolate from there. Normal dive entry remains at 64 units and keeps the identical path. `swooper_recovery_entry.gd` reproduces six old-code failures and passes all 17 checks after the fix, using explicit test-only 2 HP foes; normal basic HP remains 1. The default test runner includes this regression.

### Lowered wings can still read as active flight

Three painted death drafts and a derived shoulder rotation retained broad supported wing fans. Repeated coordinate instructions and downward rotations did not establish loss of lift. Fresh static reviewers rejected those poses despite intact anatomy and valid measurements. A new painted pose folded the wing fingers and slack membranes alongside the body, with a drooping hood; it passed the separate static gate. Keep rejected drafts and judge the resulting action before deriving an entire clip from a source key.

### Lock anatomy that can perform the later action

The first ranged identity tightly bound the upper arm that its later aim must raise, and its post cap overtopped the hood required to remain highest. A static key can fit its idle silhouette while preventing a credible future action. The independent source gate rejected both construction issues before animation derivation; reroute the bindings and lower the post cap while preserving the complete base and figure. Retain the rejected source rather than silently changing its construction during an attack.

### Foreground arm occlusion and transparent RGB (ranged aim)

A locally folded mesh can let later transparent source triangles overwrite an already transformed hand. The first ranged aiming rig produced a detached fragment and failed A04. Preserve that failure; use a separate rigid foreground forearm layer for the robe crossing, leaving a blended attached elbow on the body. Source identity and motion still need fresh independent review. Also assess color on correctly alpha-composited images: hidden saturated RGB at alpha1 can look vivid in some previews while contributing essentially nothing to the displayed pixel. Record cleanup thresholds instead of inferring a palette defect from hidden RGB.

### Measure projectile travel from projectile birth

An enemy-root reference shortened a forward-offset shot's specified flight by its40u muzzle offset. Store the projectile's actual spawn coordinate for its range limit. The ranged projectile regression fails at639u before the fix in both directions and passes afterward while preserving timing, speed and crouch clearance.

### Effect extraction must remove the effect from the body

The first ranged firing derivation removed its separate charge layer, but bright charge pixels retained around the painted fingers created an apparent rebound in the final frame. A zero opacity field does not prove an effect is gone. Inspect the correctly composited body-only hand and the final runtime pose; preserve the failed frames/review and correct only the local source region before rederiving affected frames.

### Rooted collapse and ash need separate evidence

The ranged generated cycle drifted its fixed post center117→96→90px across equal tiles. Do not disguise that drift with per-frame recentering. Reuse the accepted impact pose and paint intermediate supported slumps while preserving fixed construction; a large local warp can stretch post-adjacent cloth into a spike. Record and replace that named bridge.

A soft final ash blur can pass an audit yet read as a smudge against actual masonry. Retain the runtime failure and inspect a textured painted replacement on the stage. The scoped opacity tripwire reproduces the faint-core failure; it supplements rather than approves readability. A09 separately caught an effect allocation7px above ground, corrected by moving only the ash effect to the pivot line.

### Dynamic draw evidence and coordinate precision

A testing-mode world can return before its normal redraw queue while logical projectile age/position still advances. Explicitly queue the world draw before capturing a dynamic projectile; counts/clock assertions alone do not prove current artwork rendered. Also distinguish float32Vector2 accumulation from a speed defect: the long-flight fixture measured0.0444u rounding over637u; its0.1u tolerance remains below one source pixel and leaves gameplay values unchanged.
