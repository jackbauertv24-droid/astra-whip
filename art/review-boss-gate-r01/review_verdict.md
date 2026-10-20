# Independent review: prop_boss_gate r01

Scope: sole clip `prop_boss_gate` in this pack. Existing characters, environment, UI and exit placeholder are context only. I did not generate, process or audit this art. No builder notes or prior verdicts were consulted. I opened lineup_vfx.png, then strip_prop_boss_gate.png, saved blind_observations.md and read that saved file before opening index/audit/scope/intent/contracts/provenance. The blind observations already identified the cross-shaped upper decorations.

| Clip | Verdict | Failing frame / samples | Defect | Smallest correction |
|---|---|---|---|---|
| prop_boss_gate | FAIL | F000; source lineup and strip; visible gate instances in closed/partly lowered scene samples | Two clear cross-shaped ornaments occupy the upper left/right spandrels. ART_BIBLE §5 explicitly forbids crosses as set dressing. | Replace only these two ornaments with the approved original thorn-knot or blind pointed-arch vocabulary, preserving panel silhouette, rails, registration, palette and presentation behavior. Rebuild/audit and obtain a fresh independent review. |

The single delivered PNG is a complete, tall, narrow iron barrier: both posts, finials, pointed arch, interior bars and bottom rail are present. Matte slate-grey metal, restrained teal oxidation and worn light edges fit the locked masonry/material family; it does not introduce Ember decoration or resemble a character. The upper ornaments are recognisable crosses rather than ambiguous four-lobed wear marks. This is a direct vocabulary violation despite the otherwise appropriate gothic treatment.

Read docs/ART_CONTRACT.md, docs/ART_BIBLE.md, docs/ASSET_BRIEFS.md §9, contract/art_contract.json and this pack's review_contract.json. The original animation contract omits static props; the scoped actor vfx applies canvas/base/border checks to the 128×320 panel at base (64,288). Its one duration of 0 denotes a static frame, not a broken timed animation. No onion pair, anatomy, facing, hand socket, whip composite or burst growth/fade test applies to this static prop. Its declared generated_key derivation reads as a complete static gate; there is no reverse-action ambiguity.

Opened all five style-lock reference images from art/style-lock.json, including the authorized art/review-style-v3/style_env_mockup.png. Compared the gate against the cool painted stone/iron, upper light, restrained highlights and original funerary vocabulary. No other gate-specific style correction is required by this review.

# Exact engine image coverage

I opened every final actual PNG individually at its delivered scale after notification that both capture manifests were final: 19 native images at 1280×720 and 19 phone images at 698×393. No reduced contact sheet was used. Each row below means both named PNGs were opened, under evidence/boss-gate-r01-native/ and evidence/boss-gate-r01-phone/ respectively (38 total). The phone capture reports viewport (852,393), physical_device false; these are actual captured rendered PNGs, not physical-device evidence.

| File in each evidence directory | Native opened | Phone opened | Observation |
|---|---|---|---|
| before-entry.png | yes | yes | Both gate positions clear, no floating remnants; hero and standing boss readable. |
| closing-04.png | yes | yes | Earliest near-raised phase; no isolated panel fragments. |
| closing-03.png | yes | yes | Near-raised continuation, same two fixed horizontal gate positions. |
| closing-02.png | yes | yes | Lower portions descend visibly at both positions. |
| closing-01.png | yes | yes | Both panels extend farther downward without width/material change. |
| closing-00.png | yes | yes | Nearly seated panels approach floor coherently. |
| blocked-left.png | yes | yes | Closed left panel bottom rail meets floor wear line; hero stops at barrier. |
| blocked-right.png | yes | yes | Closed right panel meets floor; hero stops at barrier; boss silhouette remains readable. |
| before-unlock.png | yes | yes | Both panels seated while boss ash settles; no premature raised appearance. |
| opening-00.png | yes | yes | Initial upward lift, tiny floor clearance; both gates lift together. |
| opening-01.png | yes | yes | Greater clearance, rigid panel translation upward. |
| opening-02.png | yes | yes | Mid-lift at 0.4, consistent bars and width. |
| paused-opening.png | yes | yes | Same 0.4 panel positions as opening-02 despite pause UI change. |
| opening-03.png | yes | yes | Higher clearance, remaining panel portions recede upward coherently. |
| opening-04.png | yes | yes | Near raised; no loose foot rail or detached fragments. |
| fully-open.png | yes | yes | Both gate locations entirely clear, no floating remnants. |
| passed-left.png | yes | yes | Hero visibly beyond left gate position, no residual obstruction. |
| passed-right.png | yes | yes | Hero visibly beyond right gate position, no residual gate obstruction. |
| restart-raised.png | yes | yes | Both gate positions clear again after reset. |

The closed barrier reads at phone scale as a distinct narrow barred panel with a visible floor contact. The stopped-hero positions and closed panel positions are consistent at both arena boundaries. During sampled movement the rigid panel retains scale and moves down to close/up to open; the cropped-away upper portion does not leave detached pieces. Gate bars do not mask the hunter silhouette, boss silhouette or floor/landing edge in these samples. These fixtures show standing boss and death context, so they do not independently prove every possible live boss tell overlap.

Both final manifests agree: before entry open_fraction 1, collision layers [0,0]; closure targets 0 with [1,1]; blocked samples open_fraction 0 with [1,1]; before-unlock boss death elapsed 1.075, locked; opening-00 death elapsed 1.08333333333333, exit unlocked, fraction .0333333333333333 and [0,0]; opening proceeds .133333333333333, .4, .633333333333333, .9, 1; pause preserves .4 and death elapsed 1.175; pass samples retain 1 and [0,0]; restart returns arena inactive, boss HP8, exit locked and gates raised. Presentation begins rising at unlock; collision clears as opening starts. The capture actual_hits sequence is 7,6,5,4,3,2,1,0: actual-whip contacts against an isolated standing production-8HP fixture. This establishes the scoped gate prelude/unlock evidence, not a full traversal/combat playthrough.

# Audit adjudication

Read audit.md and audit.json: 0 DEFECT, 0 FLAG for this one clip. There are no FLAG entries to accept or reject. Canvas/base/transparency/border acceptance does not adjudicate iconographic vocabulary; the visually identified cross ornaments therefore remain a release-blocking defect even with a clean audit. No other failing gate frame/sample was found. Existing actor and environment assets receive no new approval here.

REVIEW: FAIL (1 clips)
