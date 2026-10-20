# Independent review — prop_exit r01

Scope: `prop_exit` only. I did not create, process or audit this art. I opened `lineup_vfx.png`, then `strip_prop_exit.png`, saved per-tile descriptions in `blind_observations.md`, and read that saved file before opening the index, audit, scope or contracts. No builder notes or earlier verdicts were consulted.

I subsequently read ART_REVIEW, ART_CONTRACT, ART_BIBLE, ASSET_BRIEFS §9, original `contract/art_contract.json`, scoped `review_contract.json`, `scope.json` and both capture manifests. I opened the delivered `frames/prop_exit/f000.png` and all five registered style-lock images: hero neutral, hero attack key, pursuer, terrain patch and the authorized `review-style-v3/style_env_mockup.png`. Those are comparison references, not additional clips approved by this review.

| Clip | Verdict | Failing frame / sample | Defect | Smallest correction |
|---|---|---|---|---|
| prop_exit | PASS | None | None found in F0 or the 20 engine images below | None required |

The single delivered frame reads as complete planted architecture: intact pointed crown, nested blind arches, closed timber leaves, paired stone pillars and substantial feet. It has the slate/violet stone and matte worn material treatment of the terrain and environment references. The shallow carving, iron studs and ring handle form original generic gothic vocabulary; I see no crosses, readable text, franchise emblem, gore or enemy-like silhouette. The feet meet the floor in engine without floating or a cast-shadow patch. No visible opaque matte, key fringe, bright extraction halo, detached debris or cut-off contour appears in the delivered frame or either viewport.

The brief requires exactly one 192×320 static image, base (96,288), with engine Ember tint for locked/unlocked; it does not require a second painted door state. The scoped `vfx` classification provides canvas/base/border tests for this prop, not character anatomy or a burst animation requirement. `ms:[0]` is a held static frame. Same-character height, crouch, right-facing anatomy, whip sockets and attack composites are inapplicable. There is no adjacent frame and therefore no onion pair, growth/fade or loop seam to judge. The listed generated-key derivation still reads as a door, with no apparent nonuniform architectural distortion.

## Exact engine-image coverage

Every row below was opened as the actual full PNG in both directories, without making an enlarged collage. Native images are 1280×720; phone images are 698×393, manifest viewport 852×393. `N` means `evidence/exit-r01-native/`; `P` means `evidence/exit-r01-phone/`. Both manifests say `physical_device:false`.

| Actual PNG filename | N inspected | P inspected | Visual result |
|---|---|---|---|
| locked-before-lethal.png | Yes | Yes | Closed cold-slate doorway remains planted at the right; separate from boss and attack lane. |
| locked-near-left.png | Yes | Yes | Left-facing nearby hero remains readable in front of adjacent architecture; door contour and floor contact survive. |
| death-start-locked.png | Yes | Yes | Door stays cold/locked as death begins, without premature Ember signal. |
| before-unlock.png | Yes | Yes | Settled ash precedes unlock; door remains cold with the same geometry and placement. |
| unlocked.png | Yes | Yes | Localized ochre door becomes an immediate warm destination against cool ruins; sharp state distinction. |
| paused-unlocked.png | Yes | Yes | Ember state and planting persist while paused; pause UI does not cover the destination. |
| unlocked-near-right.png | Yes | Yes | Right-facing approach leaves hero silhouette readable and door recognizable; no glow spills across actor or landing. |
| unlocked-near-left.png | Yes | Yes | Opposite facing preserves the same separation and door state. |
| completed.png | Yes | Yes | Hero visibly reaches/overlaps the doorway; warm door and floor remain stable through completion. |
| retry-relocked.png | Yes | Yes | Door returns to cold closed presentation beside the hero; no stale warm tint remains. |

At actual phone image size the unlocked pointed door is findable on immediate inspection, within the intended one-second visual criterion: it is the isolated ochre patch on the right, with a tall pointed silhouette and lighter value than its immediate dark architectural surround. Its tint is strong across the door, but contained to this one interactable rather than a screen-wide ambient wash or bloom. The locked door is intentionally quieter; its complete pointed outline, paired feet and closed leaves still identify a doorway distinct from nearby barred gate and blind decorative arches. Unlock is unequivocal in both viewports even though the leaves do not animate open, which matches the stated presentation design. This is a visual judgment from still captures, not a timed human usability experiment.

The exit does not cover the actor, the continuous landing/floor line or the boss tell lane in the supplied samples. The slight expected hero/door overlap at completion is a readable arrival, not actor erasure. Pause, completion and retry retain the same structure, scale and location. Existing actors, environment and UI were inspected only as context; this verdict does not approve them independently.

## Audit adjudication and evidence limits

`audit.md` and `audit.json` report 0 DEFECT and 0 FLAG. There are no named flags to accept or reject. Visual inspection independently supports complete architecture, clean contour, planting, style consistency and engine readability; the automated result alone was not treated as approval.

The manifests record isolated standing boss contacts with actual HP sequence 7,6,5,4,3,2,1,0, followed by actual final approach/completion. Samples record cold locked state through death elapsed 1.075, Ember unlock at 1.08333333333333, persistent paused state, near views in both facings, completion at hero x6602, and retry with boss HP8/relocked. These captures support the exit presentation sequence and final arrival; they are not proof of full boss traversal or physical-device performance. No missing frame or requested PNG was encountered. No production files were edited.

REVIEW: PASS
