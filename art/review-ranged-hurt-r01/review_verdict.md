# Independent ranged hurt review r01

Reviewer: /root/ranged_hurt_review_r01, fresh independent session, 2026-10-16. No art edits. Blind observations were saved and read back before intent, index, audit or contracts were opened; see blind_observations.md.

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| ranged_idle | PASS | — | Complete rooted figure, one connected pale arm, stable post/base, subtle breathing and hand sway; f5→f0 closes without a visible size or anatomy pop. | None required. |
| ranged_aim | PASS | — | The same shoulder/upper arm/elbow/forearm/hand progressively extends through f0–f5; the attached phosphor cue develops a distinct diamond. Hood, post and roots keep their identity and registration. | None required. |
| ranged_hurt | PASS | — | f0–f1 give a clear protective elbow fold and inward hand against the chest/hood, with a small backward/downward upper-body recoil; f2 restores the complete idle pose and holds the base. The 180 ms response reads as a brief guarded flinch. | None required. |

All 15 native frame PNGs, the lineup, all three strips and all three onion sheets were opened. Idle adjacent pairs and its loop seam preserve body construction. Aim adjacent pairs follow a single arm without a duplicated dangling arm or detached hand. Hurt f0→f1 is a small further backward/downward movement of the upper silhouette; f1→f2 releases the folded arm rapidly, appropriate to its 60 ms recovery tile. The large arm change at aim→hurt is the impact event, rather than a continuation of the aiming gesture. The charge disappears on interruption and does not remain floating beside the folded hand. Hurt f2→idle f0 is an exact pose handoff.

The ranged identity source, generated hurt key and patched peak-source were opened. The generated key supplies a coherent shoulder-to-elbow-to-hand protective fold; the delivered frames retain that anatomy while restoring the idle funerary post, lower robe, roots and stone base. The front hood remains somewhat forward of the neutral hood in the protective hunch: this is not a large backward whole-body knockback. The visible f0→f1 recoil and pronounced protective arm silhouette are sufficient for a stationary bound enemy's short nonlethal flinch. It does not read as an attacking reach or a second limb.

The palette, matte painted material, hidden face, ragged decay-green layers and pale exposed arm remain consistent with all five opened style-lock references and ART_BIBLE's rooted threat. Every source pose faces right; the runtime left-facing poses preserve the same construction under mirroring. There are no cropped body parts, new wounds, gore, obvious rectangle seams, floating roots or obvious alpha debris in the opened images. Alpha was assessed in the gray-backed strips as well as scene composites, rather than treating the viewer's black transparency background as painted ink.

D23: tools/prepare-ranged-hurt.mjs and art/production-candidates/ranged-hurt-r01/derivation.json were inspected. The script performs a local upper-body blend and bounded mesh displacement, restores the declared post regions and lower body from idle, and reuses idle exactly for f2. There is no whole-actor resizing/recentering in that construction. The manifest declares kind/source/method/reason. This is accepted as a labelled scripted fallback and remains release-handoff quality debt, not directly painted three-frame animation.

All 20 current runtime PNGs were opened: before-aim, hurt f0/f1/f2 and returned idle, for both right and left facing, in evidence/ranged-hurt-native and evidence/ranged-hurt-phone. The protective pale triangle at the chest is distinguishable at phone display size in both facings, and its disappearance into the hanging-arm idle is readable. The smaller incremental hood movement is subtle at phone size; the arm fold carries the hit read. The post/base do not visibly slide or jump in these captures.

Both capture.json files were read. They record production starting HP 2, the first whip leaving HP 1 in hurt with no projectiles, all three hurt frames at approximately 0/66.7/125 ms, a fixed root at (4608,432), and return to idle after approximately 183.3 ms. Both facings record a second whip reaching HP 0/death. The before images show aim and the impact images show the actual whip crossing the target. This supports aim interruption by the real first hit rather than a conditional HP fixture. Death art is explicitly outside this approval.

Audit disposition: audit.md and audit.json report 0 DEFECT and 0 FLAG for the three included clips; there are no FLAGs to accept or reject. The audit's 61 missing clips are outside this focused pack and receive no approval here. No whip-layer/effect clip is included for standalone approval.

Limitations: runtime evidence consists of sampled captures and reported timings, not continuous video or independent replay of the input sequence. Both JSON files declare physical_device=false; phone evidence establishes viewport readability, not physical-device testing. This review approves only the three included clips and their shown nonlethal interruption/handoff, not ranged death or the complete game.

REVIEW: PASS
