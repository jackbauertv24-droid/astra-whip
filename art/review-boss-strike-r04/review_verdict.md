# Independent boss strike review

Reviewer: `/root/boss_strike_review_r06`, 2026-10-19. Scope: mandatory `boss_strike_windup`, `boss_strike_execute`, `boss_strike_recover`; supplemental `boss_hurt_stooped`, `boss_hurt_rising`, `boss_hurt_half_stoop`; idle, walk and ordinary hurt as support references. This is a scoped acceptance, not approval of the missing inventory listed in the pack.

I opened only the lineup and nine strips first, wrote `blind_observations.md`, saved it and read the saved file before opening index, audit, intent, contracts or provenance. I did not read prior review observations or verdicts. I then opened every individual native PNG (45 tiles), every onion sheet including idle/walk loop seams, all five registered style-lock images, ART_BIBLE, ART_CONTRACT and the review protocol. I inspected the derivation records and source scripts. Actual source tiles are all 512×576 PNGs.

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| boss_strike_windup | PASS | — | F0 neutral progresses through F1–F3 arm lift to the strong overhead F4–F6 hold. Full body and connected shoulder/elbow/wrist remain present. | None required. |
| boss_strike_execute | PASS | — | F0 continues the overhead arm into a forward/downward F1 swing, F2 low release and F3 supported stoop. The elbow remains connected and body weight advances with the arm. | None required. |
| boss_strike_recover | PASS | — | F0–F2 sustain loaded bent knees and low gauntlet; F3–F5 progressively raise chest and straighten legs into the original neutral. | None required. |
| boss_hurt_stooped | PASS | — | Brief modest recoil preserves bent knees, planted soles, low fist and torso scale, then rejoins the stooped recovery. | None required. |
| boss_hurt_rising | PASS | — | Small contextual flinch releases through the rising posture and meets the later recovery without an upright reset. | None required. |
| boss_hurt_half_stoop | PASS | — | Late small recoil releases to the upright endpoint, preserving the end-of-recovery transition to walking. | None required. |
| boss_idle | PASS (support) | — | Complete armored figure, subtle breathing and stable loop seam. | None required. |
| boss_walk | PASS (support) | — | Distinct alternating boot lifts and knee articulation, stable head/torso scale and continuous return to F0. | None required. |
| boss_hurt | PASS (support) | — | Small brief upright recoil preserves the neutral identity and scale. | None required. |

## Anatomy, identity and motion

Every tile contains a helmeted head, torso, pelvis, two plated legs and two boots. The shroud does not substitute for a missing lower body. The corroded crown, overlapping shoulder plates, narrow dark face, ragged olive cloth and oversized striking gauntlet remain the same character throughout. All source figures face right. The head stays the same apparent physical size as the torso bends; the recovery is not a shrinking copy. No frame is cut off by its source canvas, and I see no stray object, opaque rectangle or empty tile.

The raised limb is long by design, consistent with the neutral oversized striking arm. Shoulder paint remains behind its movement rather than disappearing from the body. At execute F1 the sharply bent lower elbow silhouette initially drew attention in the blind strip. The individual native tile shows continuous cloth/armor from the shoulder to a bent upper arm, around the elbow and into the horizontal forearm and closed fist. Its angular corner is stylized plate articulation, not a detached forearm or an extra limb. Wrist and gauntlet remain one connected shape. Execute F0→F1 is the largest sweep, appropriate to the 50 ms active tiles; the torso leans and knees load as the fist drops rather than remaining completely frozen.

Recovery F0–F2 reads as a deliberately held exhaustion/punish posture. Both boots remain grounded, knees visibly flex and the gauntlet lies beside/over the forward knee as a weight support. The head remains upright enough to retain its helmet proportions. F3 begins the release, F4 is visibly straighter, and F5 restores neutral. The movement is economical and somewhat rigid, but it reads as supported recovery, not a fall played backward or global enlargement.

I examined every adjacent pair in all nine onions. Windup F4→F5→F6 is an intentional held tell. Execute F0→F1 and F1→F2 are rapid, large arm steps in a consistent downward arc. Recovery F0→F1 deepens the load before the subsequent rise. Idle F7→F0 and walk F7→F0 preserve identity and registration. No pair requires an anatomy or scale correction.

## Runtime and handoffs

After the root agent notified me that the refreshed captures were ready, I reviewed the new execute PNGs and the current captures in `evidence/boss-strike-native` and `evidence/boss-strike-phone`. I inspected all 76 PNGs per run using native-pixel region contact sheets, and opened full captures for the raised tell, every right-facing execute tile, mirrored left-facing arm keys, recovery endpoints and representative punish/late-hurt transitions. The regional sheets crop the outer leftward attack reach; full left-facing captures were separately opened to inspect that reach.

The actual PNG dimensions are 1280×720 native and **698×393** phone. The phone evidence is a rendered phone-size view; `physical_device` is false. I did not run or claim a physical device test, and I did not watch continuous playback. Timing assessment uses the supplied sample sequence, declared tile durations and onion progression.

Both facings retain the complete knight and plausible mirrored anatomy. Walk F0→windup F0 preserves neutral exactly. Windup F6→execute F0 advances the same fist from the vertical hold into the descending diagonal. Execute F3→recover F0 holds the same supported posture. Recover F5→walk F0 returns without a figure-scale or foot-registration pop. The two-whip branches show the first stooped flinch and second rising flinch returning to the corresponding recovery phase. The late-hit branch uses the half-stoop variant and ends upright before walking. These handoffs preserve the current posture rather than snapping to ordinary standing hurt.

At 698×393, the overhead fist clearly extends beyond the helmet and the subsequent forward/downward change remains readable against the scene. Fine plate texture compresses, and the small contextual hurt movements are subtle, as expected for the bible's brief boss flinch; the silhouette, lowered recovery posture and rise survive. The tree/background overlaps some interior texture, but it does not erase the arm tell, body outline or planted-foot relationship. I found no phone-only blocking defect.

## Contract, style and provenance

The pack audit reports 0 DEFECT and 0 FLAG over nine clips; there are no audit flags to adjudicate. The mandatory strike entries match the canonical contract unchanged: windup seven 100 ms tiles with its declared 0.90–1.40 height allowance, execute four 50 ms tiles, recovery 200/200/200/200/150/150 ms, all nonlooping `strike` poses. These are grounded attack classes and retain lower-body anatomy.

Supplemental contextual hurts exist only in the scoped review contract and use `strike`, 70/70/60 ms and a 0.92–1.03 height band. That classification represents the supported strike-recovery posture; it does not authorize loss of head integrity. I checked their native helmets directly because the automatic top-band head rule is skipped. Their heads retain the neutral helmet's shape and physical size. No mandatory timing or pose-class substitution is being accepted by this review.

All five style-lock reference hashes match `art/style-lock.json`. The boss shares their subdued painted materials, restrained upper-left metal highlights, decay treatment and gothic scene integration. There is no gore, baked glow, visible pixel-art treatment or conspicuous franchise emblem.

The six scoped action clips declare D23 scripted fallback from the neutral boss, `tools/prepare-boss-strike.mjs` and `tools/lib/boss-supported-pose.mjs`. The records describe separate connected arm pieces and supported leg articulation with fixed soles, torso rotation and rigid head countertranslation. Source inspection agrees with the delivered shapes. The windup first and recovery last PNGs are byte-identical to the neutral source; all scoped pack PNGs match their current runtime asset copies. Retained derivation and removed-component records make the fallback traceable. This acceptance does not erase the declared scripted-animation quality debt: held torso motion and angular arm articulation remain visible, but they do not defeat this action's anatomy, tell, recovery or contextual handoffs.

REVIEW: PASS
