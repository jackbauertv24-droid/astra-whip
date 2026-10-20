# Independent boss gate r02 review

Scope: `prop_boss_gate` only. I did not generate, process, or audit this art. Existing hunter, boss, terrain, background, UI, and exit are context, not approved assets under this verdict. No production files were edited. No earlier verdict or builder notes were read.

## Review order and coverage

Opened `lineup_vfx.png`, then `strip_prop_boss_gate.png`; saved per-tile descriptions to `blind_observations.md` and read that saved file before opening index, audit, scope, intent, contracts, or provenance. Then opened the delivered `frames/prop_boss_gate/f000.png` and all five images listed in `art/style-lock.json`: neutral hunter, attack key, pursuer, terrain patch, and the authorized `art/review-style-v3/style_env_mockup.png`. Read ART_REVIEW, ART_CONTRACT (including §9), ART_BIBLE, ASSET_BRIEFS §9, original `contract/art_contract.json`, scoped `review_contract.json`, scope, index, and audit.

All 38 actual capture PNGs were opened as full images, without review-side resizing or montage substitution. Native images are 1280×720; supplied phone images are 698×393 (capture reports viewport 852×393). Each cell below denotes the actual PNG opened under `evidence/boss-gate-r02-native/` and `evidence/boss-gate-r02-phone/`, respectively; no sample was omitted.

| Actual PNG | Native | Phone | Observation |
|---|---|---|---|
| before-entry.png | inspected | inspected | Both gates absent, passage clear. |
| closing-04.png | inspected | inspected | Almost retracted; no loose ornament. |
| closing-03.png | inspected | inspected | Bottom rail and short bars begin to emerge at the architectural masking line. |
| closing-02.png | inspected | inspected | Longer bars descend; paired panels keep registration. |
| closing-01.png | inspected | inspected | Rail descends nearer floor, without panel scale change. |
| closing-00.png | inspected | inspected | Nearly complete grille approaches floor. |
| blocked-left.png | inspected | inspected | Closed left grille rests on floor; hunter remains on arena side. |
| blocked-right.png | inspected | inspected | Closed right grille rests on floor; hunter remains on arena side. |
| before-unlock.png | inspected | inspected | Both gates stay closed through boss ash/death delay. |
| opening-00.png | inspected | inspected | Start of lift; no unrelated pieces or bright flash. |
| opening-01.png | inspected | inspected | Bottom rail rises with attached bars. |
| opening-02.png | inspected | inspected | Mid lift reads as same grille retracting upward. |
| paused-opening.png | inspected | inspected | Matches opening-02 gate position, with paused UI. |
| opening-03.png | inspected | inspected | Shorter exposed bar section remains, correctly connected to rail/masking boundary. |
| opening-04.png | inspected | inspected | Nearly retracted; no free-floating finials. |
| fully-open.png | inspected | inspected | Both panels disappear completely; floor remains clear. |
| passed-left.png | inspected | inspected | Hunter is beyond left gate position; no residual grille. |
| passed-right.png | inspected | inspected | Hunter is beyond right gate position; no residual grille. |
| restart-raised.png | inspected | inspected | Raised presentation restored, with neither gate remaining. |

## Per-clip verdict

| Clip | Result | Failing frames / samples | Defect | Smallest correction |
|---|---|---|---|---|
| prop_boss_gate | PASS | None: f000; all 19 native and 19 phone samples inspected | None found within supplied scope | None required |

The complete source panel has pointed finials, blind pointed arch tracery, riveted horizontal iron rails, and diamond collars on slender uprights. Its restrained slate highlights, deep recesses, and teal corrosion read as painted matte world iron alongside the locked cold masonry and environment. It does not introduce a franchise crest, text, crosses, warm decorative signals, or gore. The two small arch fields remain integrated with surrounding metal rather than looking like pasted rectangular patches.

The closed panel is a full-height barrier with its bottom rail on the platform's continuous light edge. Phone captures preserve the outer silhouette and separate vertical bars; fine ornament becomes quieter, but the object still reads as a closed iron gate rather than an enemy or scenery specks. It does not obscure the hunter silhouette, central boss silhouette, or walkable landing line in the supplied samples. The bars sit behind the hunter when their outlines overlap at contact.

Closing samples progress from fraction .9667 to .1, then 0 at contact, showing coherent downward travel. Opening samples progress from .0333 to .9 then 1, showing coherent upward travel. Exposed bars are deliberately occluded at the same architectural line during retraction; their changing visible length is not a scaling error. Neither fully-open nor passed samples retain floating finials, bottom rails, or disconnected fragments. The paused sample holds fraction .4 and visually matches opening-02. Restart restores fraction 1 with both collision layers 0 and an unobstructed arena presentation.

Supplied collision evidence agrees with the visible closed contacts: both layers are 1 while closed and before unlock; hunter x≈5632.07 at left and x≈6507.93 at right remain inside the corresponding barrier. Unlock switches both layers to 0 and sets target open, followed by visible raised passage and hunter positions x5560 and x6580 beyond each gate. This is alignment acceptance of the supplied fixture, not a claim of full traversal coverage or continuous collision timing validation. The fixture explicitly uses isolated standing boss contacts and the production 8 HP sequence 7,6,5,4,3,2,1,0; it is not a physical-device capture or a complete combat playthrough. No additional boss-tell animation is evidenced by these stills, so this verdict is limited to the shown gate placement and lack of interference.

## Contract and audit adjudication

`audit.md` reports 0 DEFECT and 0 FLAG. There are no FLAG entries to waive. Visual inspection agrees on the complete nonempty transparent panel, clear canvas margins, base registration, and absence of conspicuous debris, clipping, or rectangle edges.

ASSET_BRIEFS §9 specifies one static 128×320 panel at base (64,288), opening by presentation slide. The original animation contract omits props; the scoped review contract classifies this prop as `vfx` solely to exercise canvas/base/border checks. Its single ms=0 frame is static; effect growth/peak/fade, character anatomy/facing/crouch comparisons, attack composites, and onion pairs do not apply. Missing onion images are therefore not missing animation evidence for this one-frame prop. Motion was judged against all supplied engine samples instead.

The index lists this as `generated_key` with local arch-patch derivation. The delivered result still reads as one coherent gate panel and its intended slide presentation; the provenance label does not create an additional animated clip. This is the only clip approved here.

REVIEW: PASS
