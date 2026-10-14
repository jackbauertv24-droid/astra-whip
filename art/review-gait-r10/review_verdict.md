# Independent motion review r10

## Blind visual observations recorded before reading intent or audit

Lineup tile 0: long-haired brown-clad man faces right, head slightly lowered, gloved hands down, split brown coat over dark pants, coil at left visible hip, both boots grounded. Anatomy reads as one coherent person.
Lineup tile 1: same recognisable man in a wide rightward stride; left-image boot trails on toe and right-image boot reaches ahead; coat splits around legs. Torso and head remain close to neutral proportions.
Neutral strip F0: stationary upright stance, two boots separated on ground, arms down, visible hip coil, long split coat; no obvious detached anatomy.
Walk F0: broad stride, rear toe down and front sole down; arms slightly separated, coil on left-image hip.
Walk F1: similar broad stride with trailing foot moved inward; front sole grounded; head approximately same height.
Walk F2: rear lower leg folds up, other boot grounded below body; coat tails spread. Bent boot clearly raised.
Walk F3: left-image boot grounded under body; right-image leg extends forward with raised toe/sole; hands and coil remain coherent.
Walk F4: wide stride with left-image rear boot angled onto toe and right-image front boot lowered near ground; coat hangs between legs.
Walk F5: rear toe planted and front boot flat; proportions look consistent, coil and wrist remain together.
Walk F6: left-image boot raised and bent rearward, right-image boot planted; coat lifts away from raised leg.
Walk F7: left-image boot planted under body, right-image boot raised forward; silhouette resembles F3 with shifted coat and arm position.
Walk F8: left-image boot planted behind torso, right-image boot reaching ahead with toe up; hip coil sits lower beside hand.
Walk F9: broad stride, rear toe down and front sole near ground; silhouette approaches F0, with different arm/coat placement.

## Identity, anatomy, motion, and evidence

Scope is exactly `hero_walk` and `style_hero_neutral`; missing unrelated clips are excluded. I opened all eleven scoped native frame PNGs and all twenty supplied engine captures (F000–F009 in each of `evidence/walk-engine-r10` and `evidence/walk-engine-phone-r10`). I read the review protocol, art contract, art bible, animation specification, style lock, and scoped clip/audit metadata after recording the blind observations. No previous verdict was consulted and no artwork was changed.

The full head-to-boot body remains present throughout. Face, hair mass, mantle, linen sleeves, bracers, belt, split coat and compact hip coil remain recognisably the same identity. Walking heights are 218–224 px, with modest vertical gait displacement rather than a scaling body. All tiles face right. Native portraits remain coherent without a visible hard head/body rectangle. The far boot is substantially cooler in F3–F5, but its cuff, shaft and toe retain a leather boot read; I accept that as shadow-side separation rather than a replacement metal boot.

Near/far leg tracking reads as two alternating steps: the visible foreground leg trails through F0/F1, folds behind in F2, swings forward in F3 and contacts in F4/F5. The other leg trails through F4/F5, folds in F6, advances in F7/F8 and contacts in F9. Coat overlap and boot shading provide depth cues. Both hands remain attached; the coil stays compact and with the hip/hand assembly. Coat tails lift at the bent-leg poses and return during contact; there is no detached whip or independently floating cloth.

Every onion pair was inspected:

| Pair | Observation |
|---|---|
| F0→F1 | Stride closes slightly; no anatomy or portrait jump. |
| F1→F2 | Trailing foot lifts and knee bends while opposite foot supports; mantle/coat shift accompanies it. |
| F2→F3 | Swinging foreground leg comes forward; opposite boot supports below the hip; no missing limb. |
| F3→F4 | Forward boot lowers into contact, supporting leg moves rearward; coat follows without a cut edge. |
| F4→F5 | Contact progresses with front boot drawn inward and rear toe loaded; proportions retained. |
| F5→F6 | Rear leg folds off ground while the other boot supports; coil and arm move together. |
| F6→F7 | Other swing leg advances; head rises slightly and coat opens. |
| F7→F8 | Forward reach continues and supporting foot shifts backward; coherent connected limbs. |
| F8→F9 | Return to broad contact with arm/coat settling; body remains one figure. |
| F9→F0 | No motion at all: exact duplicated contact pose. This is a held seam rather than an in-between. |

The engine captures show a readable grounded hunter at desktop and actual phone size in every frame, with no clipping or loss of feet/coil. They are frame captures, so they establish rendering/readability and frame sequence rather than independently proving travel-speed synchronization. The declared 80 ms durations imply the identical F9 and F0 hold that contact silhouette for 160 ms at the loop seam. Native PNG SHA-256 comparison confirms F000 and F009 are byte-identical (`952de031e0d7066982e6a4f422ab1a3bc593f4cceaf0ab6f58b2f7f182a16aa5`). This repeats a pose to meet the ten-frame budget, contrary to ANIMATION_SPEC: “Frames are unique authored pose targets, not repeated copies to inflate counts.”

The declared derived walk reads as walking through the articulated support/swing sequence. Its remaining defect is the duplicate terminal pose and associated held seam; scripted derivation itself is allowed by ART_CONTRACT §11.

## Per-clip verdict

| Clip | Verdict | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| style_hero_neutral | PASS | — | Full coherent grounded identity reference, matching the scoped neutral intent. | None. |
| hero_walk | FAIL | F009 (duplicate of F000; seam F009→F000) | Identical terminal/initial image creates a 160 ms contact hold and violates the unique authored pose requirement. | Replace only F009 with a distinct contact/settling in-between from F008 toward F000; preserve identity, alternating limb assignment, grounded boots and 80 ms timing. |

Audit adjudication: zero DEFECT and zero FLAG reported; no FLAG needs acceptance. The duplicate-pose finding is independent of those numerical checks.

REVIEW: FAIL (1 clips)
