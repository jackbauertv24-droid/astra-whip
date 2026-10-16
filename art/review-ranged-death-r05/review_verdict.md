# Independent ranged death r05 art review

Blind observations were saved and read back in blind_observations.md before intent, index, audit, or contracts. I did not generate or process these assets. This review covers exactly the three clips in this pack, not the missing inventory listed in its index.

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| ranged_idle | PASS | — | Full hood-to-rooted-base identity; subtle shoulder/arm and cloth sway without post skating or whole-body scaling. All six pairs, including f5→f0, remain a coherent breathing loop. | None. |
| ranged_hurt | PASS | — | One connected arm folds inward for recoil in f0/f1, then releases to the exact upright idle construction in f2. Hood recoil and fixed lower support preserve identity; the faster arm release reads as recovery at 60 ms per frame. | None. |
| ranged_death | PASS | — | f0 impact fold releases into a single hanging arm in f1; hood/shoulder descend further in f2 and settle in f3 against the stationary post. f4 erodes and desaturates the supported silhouette, then f5 leaves painted ash and detached flecks at the same ground location. | None. |

## Identity, construction, and motion

I opened all fifteen individual native PNGs, all three strips, lineup and all three onion sheets. The face remains concealed, the pale elongated arm stays connected to the shoulder, and the olive layered robe, bindings, capped funerary post and rooted stone base remain recognisably the same actor. The figure is complete for its declared robe-to-ground design; legs are not required. Source art faces right; runtime mirroring preserves the construction in the other direction. No extra arm, severed limb, visible wound, hard rectangle, clipped hood, floating root or unexplained debris appears.

The hood and shoulder descent across death f0→f1→f2 is a progressive bend and release rather than a smaller copy of the upright actor. The half-slump bridge keeps the hand below the elbow and opens the chest fold without a visible duplicate arm. The f2→f3 local sag is small and plausible. The hand is limp beside the robe, with no planted palm or active brace supporting the upper body; the post supplies the support. The tall lower robe is appropriate to the explicitly supported in-place collapse. Post cap/base stay fixed until the dissolve starts; lower cloth differences do not read as an advancing foot or moving plinth.

All five style-lock images were opened: hero neutral, hero attack, pursuer, terrain patch, and environment mockup. Painterly fine shading, worn muted olive cloth, pale bone/flesh highlights, cold funerary stone and the ash treatment fit that family without visible pixel styling or gore. I also opened the ranged identity key, painted half-slump key, painted slump key, r05 restored slump-source, and only f005 of the ash source sheet. The restored fixed post/base does not introduce a conspicuous seam. The isolated ash source supplies actual irregular painted rubble and particles rather than a uniform blur.

## Audit and derivation dispositions

The pack audit reports zero DEFECTs and one FLAG. A-11 ranged_death f005 (from f004: size 67.9%, height 74.3%) is ACCEPTED. This is a deliberate body-to-ash change within the dissolve class: f4 already has distributed soft holes, Ash Grey desaturation, reduced opacity and low ash accumulation; f5 removes the remaining upright ghost and leaves a grounded irregular pile with flecks. The onion makes the large mass loss obvious, but it reads as completion of supernatural erosion, not an accidental actor resize or an unrelated replacement pose. The sharp reduction is brief and legible in the production sequence. No other audit flags exist in this pack.

D23 derivation was inspected in tools/prepare-ranged-death.mjs and r05/derivation.json. The reused hurt entry, separately painted half/full slump, fixed original support, bounded local sag and seeded erosion preserve acting and identity. The isolated ash is intentionally sized as an effect at 0.46, not used as actor normalization. This remains scripted animation quality debt as declared; it does not excuse the visual gate. The three scoped derived clips each read as their declared action.

## Production captures and phone readability

All forty current PNGs were opened at their original dimensions through unscaled contact sheets: twenty native 1280×720 and twenty phone-viewport captures, including both before-aim views, every death frame in both facings, holds at 650/1000 ms and cleanup after 1225 ms. Both capture.json files were read. The phone PNGs retain the actual viewport presentation; no enlargement was used to award readability.

In both facings the chest-fold entry, progressive dropped hood and final limp arm remain distinguishable from the upright threat. At phone size f4 is visibly the fading/eroding tall silhouette. At f5 onset the low pale irregular deposit is small but discernible on the platform where the actor stood; it is not an empty disappearance. Fine individual flecks are primarily a native-size detail, while the collective pale mound provides the phone-scale endpoint. At 650 ms the ash is faint but still locatable. By about 1000 ms it is near invisible, which is ordinary late fade, not failure of onset ash readability. The 1225 ms images show the cleared platform without residual fragments or a lingering body. The native captures corroborate pile/fleck structure. No failing source, transition, or hold frame was found.

The capture harness was read: it starts the production ranged actor at 2 HP, performs an actual whip to 1 HP/hurt, permits natural return to aim, and performs a second actual whip to 0 HP/death. This is not a forced death-state screenshot fixture. Records show all six 80 ms frames, fixed root [4608,432], no projectile after lethal interruption, final-frame hold, no dead contact damage, and removal after 1.2 s. Runtime alpha falls from 1 at onset to 0.6 at f5 onset, 0.35 at 650 ms and 0.1 at late hold; that fade is included in the visual judgment.

## Limits

These are engine-rendered desktop and phone viewport captures, not a physical phone test (physical_device=false). Static captures and onion comparisons support the acting/timing judgment; no real-device luminance or sustained playback measurement is claimed. This is approval only of ranged_idle, ranged_hurt and ranged_death in this exact pack, with the inspected current production evidence; other action clips and the projectile are outside this gate.

REVIEW: PASS
