# Independent visual acceptance — pursuer alert r01

Scope: `pursuer_alert` only. `pursuer_patrol_walk` and `pursuer_approach_walk` are unchanged calibration and handoff references, not new acceptance submissions. Missing unrelated clips in this deliberately partial pack do not enter this verdict. Reviewer did not generate, process or audit these assets. No earlier verdict files or builder notes were opened.

Blind review order: opened the one lineup and all three strips; wrote and verified `blind_observations.md` before reading the contract, intent, index, audit or metadata. Then inspected ART_CONTRACT, ART_BIBLE, ANIMATION_SPEC, relevant ASSET_BRIEFS, machine contract, all five registered style-lock images, all four native alert PNGs, all three onion sheets, clip metadata/derivations and both audit files.

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| pursuer_alert | PASS | — | Complete, consistent quadruped executes a supported rear-up with folded forelimbs, then settles into the approach entry; visible silhouette change at phone size. | None required. |

## Anatomy, identity and size

All four frames contain the complete head, hanging muzzle, ragged olive back/hide, pelvis, two hind legs and two long forelimbs. The folded forearms overlap at the peak but remain attached and anatomically traceable. The pale limb lengths, claw shapes, head mass and hide details persist; no torso-only replacement, limb loss, obvious detached fragment, clipping, hard rectangle or identity change appears. Source faces right throughout; mirrored in-engine captures are plausible.

The body rotates up about the hindquarter while its hind legs provide support. The near hindpaw remains planted; the far hind leg adjusts underneath. Elbows visibly fold to lift the foreclaws toward the chest and reopen on descent. Head and rigid limb parts retain physical size; increased height comes from the posture, not whole-character enlargement. The cutout technique is visible in rigid painted surfaces, but its multiple articulated joints produce a coherent action and meet the explicitly reviewed skeletal/cutout allowance in ANIMATION_SPEC.

The low patrol/approach reference is long and nearly horizontal. Alert f1 raises its head substantially and pulls the foreclaws clear of the ground; f2 begins the descent and f3 restores the low posture. This reads as one short rear-up rather than a recolored patrol frame. At the phone capture's actual displayed scale, the raised head and steeper front contour remain distinguishable in both facings without relying solely on the alert tint. The unchanged locomotion reference strips/onions retain the same complete creature and provide a compatible low endpoint.

## Motion and every audit FLAG

- **A-11, alert f1, f0→f1: accepted.** Height +24.6%, S change 3.1%. The head/chest arc upward while the rear contact remains fixed and the forearms fold. This is the declared rear-up silhouette event, not scaling or a limb teleport. Native PNGs and both-facing captures support the onion interpretation.
- **A-11, alert f2, f1→f2: accepted.** Height change 13.2%, S change 2.3%. The same torso rotates down partway, elbows open and claws descend; attached joints and consistent painted features explain the envelope change. No anatomical or identity discontinuity is visible.
- **A-11, alert f3, f2→f3: accepted.** Height change 15.2%, S change 0.5%. The descending body returns to its low forward stance while the foreclaws lower coherently. The endpoint matches the approach entry silhouette and support; no size pop occurs.

All three adjacent alert onion pairs describe a single rise and recovery. The four 75 ms poses provide an economical 300 ms tell with a definite raised peak; their comparatively large vertical steps are purposeful action timing. No further unreported discontinuity was found. Alert is non-looping, so an alert f3→f0 seam is not required.

## Derived action and engine evidence

The metadata declares alert a D23 scripted fallback articulated from the same painted parts as locomotion; no whole-body scaling or translation is declared. The observed joint changes substantiate that derivation as a rear-up action. Patrol's scripted gait and approach's reused gait were inspected only as unchanged references; their identity, scale and entry silhouette agree with alert. Scripted fallback remains disclosed quality debt.

Both `evidence/pursuer-alert-capture-r01.log` and `evidence/pursuer-alert-phone-r01.log` ended in PASS before capture inspection. Opened every PNG individually: alert f00–f03 and approach_walk f00, right and left, in each of `evidence/pursuer-alert-engine-r01` and `evidence/pursuer-alert-phone-r01` (20 PNGs total). Inspected both capture.json files. Their reported viewports are 1280×720 and 852×393; the delivered phone PNG shows the letterboxed game view at its displayed scale.

For each facing the records show alert frames 0,1,2,3 at elapsed 0, .075, .15 and .233333 seconds, a .300-second alert duration, then natural approach_walk frame0. Root x stays1062 for right and1038 for left, including the handoff; stationary_root is true for both. The rendered feet remain on the platform in every capture. The visual rear-up happens above that fixed root, rather than through world displacement. Alert f3 and approach f0 preserve posture, anatomy and ground placement in both facings; the change in state tint does not hide a pose mismatch.

No attacks, whip layers or effects are submitted in this scope; those protocol checks are inapplicable. This is acceptance of the alert clip only, not whole-game animation completeness.

REVIEW: PASS
