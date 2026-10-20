# Painted checkpoint HUD indicator

Two128×96UI-space sources show the inactive hollow shrine socket and active filled ember. They display in32×24CSS bounds between the five health pips and live numeric health. The indicator ignores input, hides in portrait and follows the actual checkpoint boolean. Normal death/retry retains the lit checkpoint; completion retry resets it. HUD wording now selects a complete fitting phrase, preserving health first instead of clipping secondary text.

Both generated sources retain prompts/raws and uniform whole-canvas conversion provenance. The active source is a generative edit of inactive, retaining the shrine identity. No crop, deformation or manual paint. Static UI source audit has zero defects/flags; three negative fixtures reject opaque backing, identical states and wrong canvas. Original animation contract unchanged; no actor/VFX exception claimed.

232runtime checks cover four viewport/density/safe-area layouts, actual grounded approach, pending pit death, automatic pit retry and completion-reset. Frozen HUD refresh fails52checks.21actual engine images cover all20state/layout combinations and portrait. Capture-only camera synchronization frames the relocated actor; this is presentation evidence, not proof of natural camera traversal. Physical-device and unfamiliar-player tests remain unperformed.

Atlas402frames,400existing placements preserved, five2048-square pages/80MiB.402RGBAroundtrips/corruption control and756before/after renderer samples are exact. Conservative inventory114.9375MiB. Exported2415atlas checks and133227856bytes/127.06MiB measured desktop-software art allocation pass. Source/export checkpoint232checks, main1241assertions, health486, controls306, safe-area150 and existing world checkpoint51checks pass. Contract and25negative-case selftests pass.

Fresh independent REVIEW: PASS for both states after all21engine PNGs,4browser PNGs, both raw/delivered frames and5style references inspected. No blockers or unresolved flags. Browser568x320CSS/DPR2/safe44/44/21 reports0errors. Reviewed/canonical/runtime source bytes match.3UIassets/3frames remain pending.
