# Independent camera presentation review r01

REVIEW: FAIL

Reviewer: /root/playfield_review_r01. Scope: camera framing, required landing visibility, and hero/threat readability relative to touch controls. No production files changed. No builder verdicts, fix notes or audit summaries read.

## Review procedure and coverage

Individually viewed all twenty actual PNGs in evidence/playfield-captures-final. Saved blind_observations.md, then read that saved file before reading capture.json, SPEC.md, ART_BIBLE.md, ART_CONTRACT.md and art/style-lock.json. Viewed all five actual image references listed in that style lock: neutral hero, attack key, pursuer, terrain patch and environment mockup.

Actual reviewed image dimensions are 1280×720 native and 698×393 phone. Metadata control positions are logical coordinates, not phone image pixels. Phone controls visually begin about y300; native controls begin y590. The reference comparison establishes the warm hunter, cool layered masonry and readable capped edges; it does not reapprove actor animation.

SPEC §6 requires that the camera never hide the required landing zone and that gameplay threats remain readable outside thumb-covered zones. ART_BIBLE requires clear play-plane surfaces and no foreground/fog across landing zones or tells.

## Sample verdicts

| Sample | Verdict | Observation |
|---|---|---|
| native-entry | PASS | Hero, lower trough, return step and right threat all visible above controls. |
| native-approach | PASS | Lip, lower landing and both return heights visible; hero clear. |
| native-lower-landing | PASS | Feet and landing around y560, about 30px above controls; exit step and threat clear. |
| native-return-step | PASS | Hero at first step; upper return landing and threats clear. |
| native-main-return | PASS | Main landing around y538 above controls; nearest dog overlaps hero but their locations remain readable. |
| phone-entry | FAIL | Hero absent from frame; entry route/required landing is not presented. |
| phone-approach | PASS | Lower landing around y284 above controls; hero and right threat clear at actual size. |
| phone-lower-landing | PASS | Hero and floor above controls with roughly 16px clearance; exit step clear. |
| phone-return-step | PASS | Step, upper return and two threats clear. |
| phone-main-return | PASS | Main landing around y272 above controls; hero and nearby dog overlap but remain locatable. |
| native-stage-1120 | PASS | Current upper floor, hero and threats above controls. Lower left trough is behind the current route and partly under buttons. |
| phone-stage-1120 | PASS | Current upper floor around y284 above controls; hero and dog overlap but remain visible. Lower left trough intersects controls; no approval of backtracking traversal is inferred. |
| native-stage-2880 | PASS | Raised route, next gap and platforms readable; lower floor above controls. |
| phone-stage-2880 | PASS | Raised platform, gap and lower floor visible above controls. |
| native-stage-3520 | FAIL | Current small step clear, but continuous lower landing ahead is around y623, inside control band beginning y590. |
| phone-stage-3520 | FAIL | Current small step clear, but lower landing ahead around y319 runs through control band beginning y300, including action-button areas. |
| native-stage-4128 | PASS | Hero, dog, primary floor, elevated statue and steps clear above controls. |
| phone-stage-4128 | PASS | Hero, dog and primary floor visible above controls at actual size. |
| native-stage-5900 | PASS | Hero and boss fully framed, separated and above controls. |
| phone-stage-5900 | PASS | Hero and boss fully framed and separated above controls. |

## Blocking findings

1. **phone-entry.png:** no visible hero, so entry framing fails regardless of control clearance. Metadata confirms hero [160,560] versus camera [4961.05,527.69], consistent with a distant camera view. This pack cannot establish acceptable phone entry presentation. Correct framing and supply a new entry capture; a capture timing problem also requires corrected evidence.
2. **native-stage-3520.png and phone-stage-3520.png:** the lower continuous landing ahead is visibly within the controls. The thin cap remains partly visible through translucent buttons, but button overlays and expected thumbs occupy the landing surface. The scene therefore fails required-landing presentation outside the control zone. Small dark top bands also appear here; these do not independently cause the verdict.

The supplied input-driven approach, lower landing, first return step and second-jump return are visually readable in both sizes. This does not override the failed entry and fixed-position samples. Static captures cannot establish camera smoothness, full-route transient framing, physical-device playability, thumb behavior, unfamiliar-player success, or animation quality. Existing actor animations remain outside this review. A fresh independent reviewer must review corrected evidence after fixes under ART_CONTRACT §9.
