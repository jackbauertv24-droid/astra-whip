# Independent scoped review — gait r16

Scope: `hero_walk` and `style_hero_neutral` only. Unrelated missing clips are outside this gate. Blind observations were saved first in `blind_observations_motion.md`, after opening only the lineup and both strips. No prior verdict was consulted and no art was edited.

Inspected all eleven native PNGs, all ten onion pairs including F9→F0, and all ten desktop plus ten phone real-input samples and their capture records. Read ART_REVIEW, ART_CONTRACT, ART_BIBLE, ANIMATION_SPEC, style-lock and current scoped metadata/audit after the blind record.

| Clip | Verdict | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| style_hero_neutral | PASS | — | Full right-facing hunter with intact head, torso, arms, two legs and boots; coherent planted stance and approved identity. | None. |
| hero_walk | FAIL | F1–F5 (support-contact progression), F4→F5 (support/swing handoff and coat/torso pop) | Grounded boot registration does not compensate real root travel consistently; F2→F3 visibly jerks the supporting foot backward, and F4→F5 resets the leg/coat configuration instead of showing a continuous touchdown and release. | Retain the identity and intact anatomy; repair support-foot local coordinates F1–F4 against actual root displacement, then repair F5 touchdown/trailing-foot release and its coat/torso join to F4. Keep each leg's depth identity through the handoff. Rebuild actual-input captures before fresh independent review. |

The same face, hair, mantle, linen sleeves, leather body, coil and boots persist. Full bodies remain visible and consistently sized; there is no torso-only substitution, squashing or clipping. Cloth does articulate with the legs, and the poses are distinct, although F0/F1 are close. Arm and chest motion is restrained and can be accepted for this guarded walk. The failure is support and continuity, not lack of a full body.

Pair observations:

- F0→F1: upper body holds coherently, but the forward planted boot moves only about 12 source pixels backward while the root advances 10 game units (20 source pixels). Its ground contact therefore drifts forward about 4 units.
- F1→F2: front support again moves roughly 12 source pixels backward against 20 pixels of root travel, giving another roughly 4 units of forward ground slip. Rear knee/boot lift is otherwise readable.
- F2→F3: the grounded boot moves from approximately source x255 to x218 at the heel while the root advances 20 source pixels. This produces approximately 8.5 units of backward ground displacement. This is visible in the actual desktop samples against the platform masonry, and is a support defect rather than ordinary swing.
- F3→F4: swing boot lowers and extends plausibly; the support heel retreats only about 11 source pixels against 20 source pixels of root travel, so it slips forward again by approximately 4.5 units. The support never reads as a stable world contact through this interval.
- F4→F5: the extended forward boot snaps inward to the overlapping under-body pose, and the previously trailing support changes into a forward bent-leg arrangement without a readable intermediate release. The coat changes from a long split diagonal arrangement to a compact skirt, with a sudden upper-body rise/left shift. A touchdown could explain a support transfer, but this particular transfer fails continuous leg/depth tracking.
- F5→F6: lifted forward boot separates from the overlapping legs; support moves rearward approximately with the physical root. No missing limb or scale defect. This pair by itself is acceptable.
- F6→F7: supported leg remains grounded while forward boot advances; short continuous change. Acceptable.
- F7→F8: forward boot lowers, rear support extends; continuous late swing. Acceptable.
- F8→F9: wider contact and small body descent read as weight settling. Acceptable apart from the earlier faulty support cycle.
- F9→F0: small final separation/settling change; identity and silhouette join without a seam pop. Acceptable.

The approximate source positions above are visual heel-landmark readings, not automated precision measurements. Their diagnostic value is the direction and magnitude of the support displacement: the F2→F3 backward jerk is much larger than a heel-to-toe contact adjustment, and the alternating forward/backward skating is clear in world-space captures. Capture.json gives a 0.4-second cycle, 2× playback, speed 240 units/s, 96-unit full-cycle travel, and roots 678, 688, 698, 708, 718, 728, 736, 746, 756, 766. At phone size the hunter remains identifiable and the leg articulation is readable, but reduced display size does not fix the support mismatch.

Audit adjudication: current audit reports 0 DEFECT and 0 FLAG. There are no flags to accept or reject. Automated size/alpha checks do not adjudicate world-space support or the F4→F5 handoff; those visual failures block this clip under ANIMATION_SPEC's skating-feet rejection and ART_CONTRACT §9.

REVIEW: FAIL (1 clips)
