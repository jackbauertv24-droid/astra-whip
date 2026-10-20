# Independent boss death review, r02

Reviewer: fresh agent `/root/boss_death_review_r01`. Acceptance scope: boss_death. The other three clips are comparison references; their rows below assess the supplied reference motion, not a renewed approval of their entire gameplay cycles.

Blind-first record: opened lineup_boss.png and every strip, saved blind_observations.md, then read that file back before opening index, scope, audit, contract or derivation metadata. No builder verdict or explanation was received. Source art and runtime were not modified.

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| boss_death | FAIL | runtime stooped entry→f0; f6→7; f9 | Stooped lethal hit instantly resets to upright before collapsing. Supporting near hand flattens into a thin extended shape at f6 then returns to a large closed fist at f7. Dissolve begins with conspicuous round punched holes across the entire silhouette. | Preserve the lethal entry pose through a short supported transition into the existing loading/kneel sequence; repair f6 hand/wrist articulation between f5 and f7; replace circular holes in f9 with irregular edge-led ash erosion. |
| boss_idle (reference) | PASS | — | Full plated legs, stable crown/shoulders and quiet breathing; fixed soles and seamless small motion. | — |
| boss_walk (reference) | PASS | — | Both legs remain present; alternating lifted boots and bent knees preserve armor size, with a coherent loop. | — |
| boss_strike_recover (reference) | PASS | — | Supported bent-knee stoop rises progressively to matching neutral; does not shrink the figure. | — |

The lethal handoff defect occurs in all four strike_recover fixtures (native/phone × left/right): compare before-{left,right}-strike_recover.png to death-{left,right}-strike_recover-f00.png. The crown rises, knees straighten and gauntlet lifts on the lethal instant, then the same stance is immediately lowered again over f1–2. This reads as recovering before dying and is visible at phone size. Standing idle entry is continuous and correctly registered in both facings. A state-dependent entry or a short pose-preserving bridge can correct this without changing the later death keys.

The central collapse is legible: soles load, knees reach the floor, shroud pools, supporting gauntlet catches the weight, torso folds, and plate settles. Head, shoulder plate and oversized arm remain recognizable; there is no whole-body miniature or stretched torso. The f6 near hand is the exception: its very flat outward projection followed by f7's thick clenched fist changes local form rather than carrying a stable hand through a convincing support release. Repair its wrist and fingers using both neighbors. No floor penetration, full-figure clipping, key-color fringe, rectangle, gore or severed-body read was found.

The f9 erosion is objectionable in the actual captures even though the gray strip makes it less conspicuous. Black/background-filled round spots appear all across the formerly solid corpse for one 90ms sample; at phone size it reads as a perforated cutout. Ash itself is localized, matte, neutral gray and appropriate. f10→11 completes its removal cleanly. Use ragged, irregular erosion connected to silhouette edges and cloth/plate breakup, retaining the registered ash mound.

Audit adjudication (all four FLAGs):

- A-11 f3, size +13.8% / height −9.1%: accepted. The bent legs move into a folded kneel and the fist gains floor contact; the broader pooled cloth and exposed folded armor explain increased area. Crown and main plates remain plausibly the same physical size. The step is brisk but reads as the heavy knee-drop at 90ms.
- A-11 f7, size −9.0% / height −25.6%: defect in the supporting hand transition described above. The height reduction itself is justified by chest/head settling onto folded limbs; the local wrist/fist continuity needs repair.
- A-11 f10, size −31.4% / height −1.3%: accepted as dissolution, with the separate f9 mask defect retained. The residual silhouette loses opacity while the ground mound becomes dominant; this is not actor shrinkage.
- A-11 f11, size −22.9% / height −45.7%: accepted as the final faint armor remnant disappears, leaving the same anchored ash mound and a few suspended ash particles.

Onion coverage: every pair viewed: death 0→1 through 10→11 (11 pairs); idle 0→1 through 6→7 plus 7→0 (8); walk 0→1 through 6→7 plus 7→0 (8); recovery 0→1 through 4→5 (5). Loading and torso folding follow one body; reference loops and recovery have no discontinuous size/costume jump. f6→7 and round f8→9 erosion are the exceptions above.

Coverage: opened every supplied strip and lineup, all four onion sheets, and every native source frame at legible native pixel scale using unscaled 2×2 review sheets: death f000–f011 (12), idle f000–f007 (8), walk f000–f007 (8), recovery f000–f005 (6), total 34. Read protocol, ART_CONTRACT, ART_BIBLE, scope, index/derived-clip declarations, audit, review contract, original boss_death machine contract and death derivation registration record. Opened all five style-lock images: style_hero_neutral/f000.png, style_hero_attack_key.png, style_enemy_pursuer.png, style_terrain_patch_3x3.png and style_env_mockup.png. Corroded metal, muted olive shroud, matte painted edges and quiet ash fit those references and the warden brief.

Both capture.json inventories were read. Every referenced PNG was opened in unscaled review sheets (review_views/manifest.json maps each sheet to its actual source): 64 native +64 phone =128 samples. For each resolution these include right idle, right strike_recover, left idle, left strike_recover; each has before, all twelve death frames f00–f11, unlock, fade and cleanup, 16 samples per fixture. No referenced image is missing or unopened. Native sheets capture-native-{0,4,8,...,60}.png and phone sheets capture-phone-{0,4,8,...,60}.png cover all samples. The review images are visualizations only and retain source pixel sizes.

Timing/lifecycle: twelve 90ms frames give 1080ms, nonlooping. Sample times progress through every source frame. Exit remains locked during f0–11, becomes visibly ochre at approximately 1.083s, ash fades at approximately 1.142s and is removed at approximately 1.208s. Floor and world root stay fixed in both facings. Ash cleanup does not pop back to neutral or leave persistent debris. All captures are isolated controller fixtures; physical_device is false, so this does not establish a physical-device playtest or full arena traversal. Whip-composite acceptance is outside this death scope; the lethal hit is visible in the supplied controller samples.

REVIEW: FAIL (1 clips)
