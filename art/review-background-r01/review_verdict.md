# Independent background review r01

REVIEW: FAIL — required actual-input attack readability evidence is missing its subject. Static source verdicts below are PASS; this does not approve the complete background integration gate.

Reviewer: /root/background_review_r01, independent of production. Blind lineup and all four strips were viewed first; observations were saved to blind_observations.md and read back before index/scope/audit or asset intent. Reviewed ART_CONTRACT §9, original contract/art_contract.json, ART_BIBLE, ASSET_BRIEFS §9 and ASSET_SPEC. No production files edited. No prior reviewer/builder verdict or evidence/fix notes used. The supplied audit.md reports zero defects/flags; that does not resolve the evidence failure below.

## Per-asset verdicts

| Asset | Static visual verdict | Finding |
|---|---|---|
| bg_sky | PASS | Dark violet, painted matte cloud field; no stars/pixel motif, warm signals, text or gore. Suitable quiet backdrop and consistent with the approved environment's cloud material. Non-tiled opaque source, not transparent VFX. |
| bg_distant_silhouette | PASS | Teal atmospheric silhouettes remain subordinate to closer architecture. Wrap joins preserve color and silhouette continuity without a vertical cut. Reflected castles are visibly repeated, especially the central paired castle masses; accepted as repetitive Gothic distant scenery at the supplied stage scale, not claimed to be organic unique scenery. |
| bg_midground_arch | PASS | Slate/violet broken Gothic arches and original knot tracery agree with terrain and environment references. Fine masonry is busy but darker than foreground walkable edge strips. Both wrap and midpoint joins look like continuous stone construction, without a gap, color step or broken masonry line. Bilateral tower/arch duplication is clearly visible in the triple repeat and crops and is a quality limitation, but did not materially hide hero/threat/landings in the fixed views. Opaque scenic source with baked distant scene is judged as declared, not as a transparent arch cutout. |
| bg_foreground_frame | PASS | Sparse upper-corner branches on otherwise empty alpha; visually clean on checkerboard. No visible opaque rectangle, key fringe or displaced debris. Branches remain at screen edges in supplied enabled segments and do not intersect a landing, actor or boss tell. |

The three opaque source images extend to their declared panel borders by design; actor anatomy and transparent-effect V-01 border requirements do not apply. Alpha judgment is visual from raw/strip/composed previews; no independent numerical alpha measurement was available in this review environment.

## Blocking evidence failure

The following four actual PNGs show scenery and threats but **no hero or whip anywhere in view**:

- evidence/background-r01-native/ground-whip.png
- evidence/background-r01-native/air-whip.png
- evidence/background-r01-phone/ground-whip.png
- evidence/background-r01-phone/air-whip.png

capture.json labels them actual input-driven active ground attack / jump plus active air whip. Their camera positions are near x4919 and x6067 while the recorded hero x remains 160. Irrespective of cause, these images cannot establish active hero/whip contrast against these backgrounds. This is an evidence/integration FAIL, not a conclusion that the backgrounds erased the hero, and not a re-review of actor animation. Supply correctly framed actual-input attack images at both sizes to complete this gate. Boss fixtures incidentally show a hero whip, but do not replace the requested actual-input ground and air evidence.

## Exact image coverage

Individually viewed lineup_background.png; strip_bg_sky.png; strip_bg_distant_silhouette.png; strip_bg_midground_arch.png; strip_bg_foreground_frame.png.

Individually viewed all four raw files: frames/bg_sky/f000.png, frames/bg_distant_silhouette/f000.png, frames/bg_midground_arch/f000.png, frames/bg_foreground_frame/f000.png.

Individually viewed repeat_bg_distant_silhouette.png and repeat_bg_midground_arch.png in full; seam_bg_distant_silhouette.png and seam_bg_midground_arch.png; mirror_join_bg_distant_silhouette.png and mirror_join_bg_midground_arch.png. Reflection is visible at both midpoint and wrap centres; neither crop shows a material discontinuity. Repeated symmetry is acknowledged above.

Individually viewed all five style-lock image references: art/frames/style_hero_neutral/f000.png; art/candidates/style_hero_attack_key.png; art/candidates/style_enemy_pursuer.png; art/candidates/style_terrain_patch_3x3.png; art/review-style-v3/style_env_mockup.png.

All 30 engine PNGs were individually opened, not replaced by a contact sheet. The following table records each filename in **both** evidence/background-r01-native/ (1280×720) and evidence/background-r01-phone/ (698×393):

| Filename (both directories) | Inspection finding |
|---|---|
| threshold.png | Hero and low threat separate from wall; bright terrain lip, bridge and lower return remain legible; corner framing clear. |
| bridge.png | Standing hero, effigy and enemy readable; bridge/landing edges remain distinct. |
| lower-return.png | Hero cleanly separates against violet cloud recess; lower landing and upper bridge legible. |
| court.png | Three low threats and hero remain identifiable against dark masonry; floor/gap lip distinct. |
| stairs.png | Stair and thin platform tops remain readable against arches; hero clear. |
| upper-platforms.png | Thin landing strips and gaps readable; background decorative friezes do not match their bright top value. |
| fallback.png | Small fallback landing and hero identifiable; background remains behind it. |
| checkpoint.png | Hero, low pursuer and tall rooted threat separate; checkpoint has a distinct shape but subdued warm trim. No framing interference. |
| mixed.png | Low threat, elevated rooted threat and hero identifiable; corner branches avoid combat/landing area. |
| arena.png | Hero and boss separate from masonry; floor edge continuous and prominent. |
| ground-whip.png | FAIL evidence: actual-input hero/whip absent from view. |
| air-whip.png | FAIL evidence: actual-input hero/whip absent from view. |
| strike_windup.png | Explicit 8HP boss state fixture: raised arm silhouette readable at both sizes, although the far-right arm edge crosses detailed arches. Hero/whip visible. |
| hazard_windup.png | Explicit 8HP boss state fixture: warm floor ring immediately distinct and unobscured. |
| hazard_execute.png | Explicit 8HP boss state fixture: warm eruption remains distinct; no background/framing over it. |

These comprise ten fixed stage views, two actual-input attack captures and three explicit production-8HP boss fixtures per directory, as distinguished by capture.json. No claim of traversal completion, physical-device testing, AI boss completion or animation approval is made. Static stills establish sampled composition/readability only.
