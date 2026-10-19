# Independent boss strike review r04

Reviewed independently without reading another reviewer's observations or verdict. Blind inspection was limited to lineup and strips; observations were saved to blind_observations_r04.md and read back before consulting documentation or metadata. Frame numbers below are zero based.

Scope: mandatory strike windup/execute/recover and supplemental contextual hurt variants. Idle/walk/standing hurt are support references. This is a scoped art verdict, not approval of missing unrelated inventory.

| Clip | Verdict | Failing frames | Finding and smallest correction |
|---|---|---|---|
| boss_strike_windup | PASS | — | Full armored body, stable crowned head and recognizable plate/shroud. Arm rises across F0–F4 and holds F4–F6; the silhouette tell is clear at phone capture size. Shoulder/chest acting is stiff but the arm remains visibly connected. Retain its endpoint while fixing the following execute transition. |
| boss_strike_execute | FAIL | F0–F1; F2→F3 | Windup F6 has a straight fist overhead; execute F0 abruptly substitutes a chest-level bent elbow/fist, then F1 extends the fist farther forward before F2 lowers it. The held overhead limb does not follow a clear continuous strike arc. F2→F3 then changes from an upright arm release to the entire supported stoop in one 50ms step, with the fist returning next to the knee rather than showing the force transferring through the body. Replace execute F0–F2 with connected descending arm/chest poses starting near the raised endpoint and progressively load the knees before F3. Preserve four 50ms frames and the supported F3 endpoint. |
| boss_strike_recover | PASS | — | F0 matches execute F3. Knees/hips remain bent, soles planted, large gauntlet rests near the knee; F1–F3 sustain exertion, then F4–F5 rise toward neutral. Head keeps physical size instead of growing. |
| boss_hurt_stooped | PASS | — | Small recoil and return retain low pelvis, bent legs, fixed soles and knee-level gauntlet. The first punish entry and return preserve the supported posture in both facings. |
| boss_hurt_rising | PASS | — | Small entry recoil releases through a continuing rise; the 200ms interruption hands back to recovery F4 without a neutral-standing flash. Hurt motion is subtle, consistent with the brief's small brief flinch. |
| boss_hurt_half_stoop | PASS | — | Late entry starts from the intermediate posture, then releases toward neutral F2 and recovery F5. It avoids forced return to the earlier deep stoop. |
| boss_idle (support) | PASS | — | Full legs and boots, stable identity/size, quiet local breathing/cloth motion; loop F7→F0 has no conspicuous jump. |
| boss_walk (support) | PASS | — | Articulated alternating legs and retained body/head proportions; upper body is restrained. Loop seam is consistent with the sampled gait. This review does not replace a separate moving-world gait/sliding review. |
| boss_hurt (support) | PASS | — | Restrained recoil releases to neutral with stable soles and head size; appropriate to standing context. |

## Evidence and independent adjudication

Opened every native tile: all nine clip folders, 45 total delivered frames, each 512×576 PNG. For unscaled inspection I assembled three 512×576 frames per 1536×576 sheet in inspection-r04; no actor scaling or crop normalization was applied. All nine onion sheets were inspected, including idle/walk loop pairs. Cross-clip overlays in inspection-r04/seams.png compare windup F6→execute F0, execute F3→recover F0, and recover F5→walk F0; only the first has the major arm displacement described above. The execute onion also shows the last-step whole-body posture jump.

Native anatomy shows both thighs, knees, shins and boots, including the supported stoops. Neither the low pose nor subsequent rise reads as global scale change. Helmet crown, hanging face shroud, layered shoulder plates, belt and ragged cloth remain the same character; all source poses face right. No conspicuous clipped body, opaque rectangle, loose debris or gore was seen. Arm joints remain connected, though the reused shoulder-cap/cloth and largely unchanged torso make the lift mechanical; this is quality debt, not the primary failure.

Read ART_BIBLE in full and opened all five style_lock_r01 references from art/style-lock.json: neutral hunter, attack hunter, pursuer, terrain patch and environment mockup. The boss's matte corroded gray plate, desaturated decay cloth, soft painted texture and horror silhouette belong to that material/world treatment. It remains clearly larger and more armored than the hunter. Fine texture is lost at phone size, but helmet, legs, large gauntlet and overhead tell survive.

Read scoped review_contract.json: mandatory strike clips retain strike classes and 700/200/1100ms timing; windup's 0.9–1.4 height override is appropriate to the raised arm. Supplemental hurt variants use strike with 0.92–1.03 height. I accept that contextual classification: they are supported attack-recovery postures, not neutral standing hurt; direct native head inspection finds no physical head shrinking even though a top-band proxy would be unreliable. This does not justify relaxing size/anatomy checks. Audit reports 0 DEFECT and 0 FLAG, so there are no numerical FLAGs to accept. The visual execute failure exists despite that result.

Read derivation manifests and relevant construction source in tools/prepare-boss-strike.mjs. D23 scripted fallbacks are explicitly labeled, sourced from neutral boss art and the supported pose rig; source joint paths, reuse endpoints and removed components are recorded. The manifests do not conceal the fallback. Source code confirms that the overhead endpoint is replaced by a low bent-arm target at execute F0; provenance does not make that action read continuous. Idle/walk/hurt provenance is also labeled. Keep scripted animation quality debt in the release handoff.

Inspected the six native and six phone runtime-inspection contact sheets, their image indices, and evidence capture metadata. These represent actual engine PNG captures from evidence/boss-strike-native and evidence/boss-strike-phone, including full cycle, two-whip punish and late hurt branches for right and left facings. Actual PNG headers are 1280×720 native and 698×393 phone. Phone metadata explicitly says physical_device:false: this is browser capture evidence, not a physical-device test. I did not play a video or claim live playback. Timing assessment uses declared frame durations and captured sequence times.

Both mirrored cycles preserve identity, supported recovery and contextual hurt handoffs. In the phone cycle sheets, the arm is vertical for three held tiles, abruptly bent at torso height on the next tile, then reaches forward: reducing the display does not resolve the strike's path. Background masonry is busy, but the raised fist is readable and the recovery remains distinguishable. Contextual hit reactions remain small at phone size; their preserved low/partial stance and smooth handback are acceptable for this boss's restrained hurt brief.

One mandatory clip fails. Product files were not edited; only reviewer observations, inspection images and this verdict were added.

REVIEW: FAIL
