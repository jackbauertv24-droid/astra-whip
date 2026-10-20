# Independent camera presentation review

REVIEW: PASS

Reviewer: fresh independent agent `/root/playfield_review_r02`. Scope: camera presentation only; no new painted assets. No production edits were made. Prior reviews, builder evidence and fix notes were not read.

## Procedure and references

Read scope.md, individually viewed all 20 supplied PNGs, saved blind_observations.md, then read that saved file before reading intent/metadata/contracts. Subsequently read capture.json, SPEC.md (especially §§2–4 and 6), docs/ART_BIBLE.md, docs/ART_CONTRACT.md including §9, and art/style-lock.json. Individually viewed all five actual registered reference images: art/frames/style_hero_neutral/f000.png; art/candidates/style_hero_attack_key.png; art/candidates/style_enemy_pursuer.png; art/candidates/style_terrain_patch_3x3.png; art/review-style-v3/style_env_mockup.png. The latter was viewed as an image reference only; its prior review was not read.

PNG IHDR dimensions were independently read from actual files using Node: every native sample is 1280×720; every phone sample is 698×393. Judgments use the individually displayed PNGs at those sizes, not logical viewport dimensions.

## Exact coverage and findings

Each table row covers both named actual PNGs separately inspected in evidence/playfield-r02-captures.

| Native PNG | Phone PNG | Scoped result |
|---|---|---|
| native-entry.png | phone-entry.png | PASS: full hero, far-bank threat, lower landing and exit step visible above controls. |
| native-approach.png | phone-approach.png | PASS: departure lip, lower landing, return step and bank are visible before the drop. No blind required destination in this sample. |
| native-lower-landing.png | phone-lower-landing.png | PASS: entire hero and foot-contact edge visible, plus next step/bank and nearby threat. Floor clears control tops. |
| native-return-step.png | phone-return-step.png | PASS: full hero on intermediate step, bank surface and both ahead threats visible; controls do not overlap them. |
| native-main-return.png | phone-main-return.png | PASS: main-bank landing, full hero and threats remain above controls after second jump. Nearby hero/threat overlap is visible but bodies are not clipped by camera or controls. |
| native-stage-1120.png | phone-stage-1120.png | PASS: ground, hero and nearby/forward threats above controls. Actor overlap compresses leg detail, especially phone, but upright hero and low threat remain distinguishable. |
| native-stage-2880.png | phone-stage-2880.png | PASS: elevated hero, forward ledges, intervening gaps and lower floor visible; left-edge partial threat is behind the route, not an unseen forward threat. |
| native-stage-3520.png | phone-stage-3520.png | PASS: small support ledge, lower floor and forward shrine area visible; no required local surface hidden under controls. |
| native-stage-4128.png | phone-stage-4128.png | PASS: full hero, ground pursuer, raised ranged figure and their platform edges visible. |
| native-stage-5900.png | phone-stage-5900.png | PASS: full hero and large boss with common ground line and forward arena/exit architecture visible. |

The input-driven route's shallow landing line sits around native y=560, leaving roughly 30 px before controls at y=590. On phone it sits around y=285, leaving roughly 15 px before controls around y=300. The same modest phone clearance applies to settled main-ground stage samples. These are small but plainly visible margins, with the complete relevant actor silhouettes above the touch region. Return step has greater clearance, and main-return bank is around phone y=272. Logical button coordinates in capture.json were not treated as physical PNG coordinates.

The lower route behind the hero in main-return and stage-1120 can extend beneath the left controls after the camera returns upward. It is a trailing surface in these supplied views; the current bank, upcoming landing surfaces and ahead threats remain clear. This does not fail the scoped required-landing presentation.

Camera positioning gives a substantial forward view while keeping the hero inside the frame. Across the five input-driven route states, the shallow floor and each upward return destination are exposed. Across fixed stage inspections, varied elevations and the boss remain framed with readable light top edges. Detailed cold gothic architecture retains the style-lock treatment; warm hunter and irregular enemies separate sufficiently from masonry at 698×393. Overlap in main-return/stage-1120 is a limitation of those sampled positions, not a camera/control occlusion or reason to reapprove actor art.

## Limits

Failing samples: none within this camera presentation scope. This verdict does not reapprove unchanged actor animations, movement timing, combat tells or art production. Stills do not establish camera smoothness between samples, unfamiliar-player success, two-thumb comfort, safe-area behavior on real hardware or whole-stage traversal. capture.json explicitly identifies physical_device=false; no physical-device proof is claimed. The stage-* images are fixed inspections, not input-driven route completion evidence. No claim of overall product release readiness follows from this scoped PASS.
