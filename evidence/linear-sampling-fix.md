# Consistent linear sampling for painted art

ASSET_SPEC §1 requires linear filtering for the painted branch. Explicit nearest overrides on background/framing, effects, UI and exit now use linear. The viewport default is linear without mip sampling, replacing linear-mipmap mode on assets imported without mipmaps. Exit tint samples the interpolated texture coordinate rather than snapping it to a texel centre. All source PNGs, atlas placements, collision, gameplay clocks and authored transforms are unchanged.

124source checks traverse every painted CanvasItem to reject nearest/mipmap overrides and confirm the viewport default. Forcing nearest on one UI node fails one check. Source-versus-packed linear rendering covers762samples/127pages: exactly one pixel differs by one8-bit channel value, within the existing strict whole-fixture tolerance. No tolerance changed. Both tinted/untinted exit shader states match exactly. Raw atlasRGBA roundtrip remains exact and atlas bytes are unchanged.

18actual engine stills cover native/phone normal/held controls, impact/defeat/checkpoint effects, health2, pause/retry, victory/retry and portrait at densities1/3. These are scoped sampling/UI/effect still fixtures, not animation or full traversal proof. Independent visual review is separate. Physical-device validation remains unperformed.

Exported124sampling checks and2433atlas checks pass; art allocation remains133227856bytes/127.06MiB on desktop software renderer. Main1241assertions, controls306, portrait graphic91 and completion75checks pass. Contract and25defect selftests pass. Eight browser PNGs cover568x320CSS/DPR2/safe44/44/21controls/menu and393x852portrait→852x393landscape atDPR3; browser records contain0errors. No source-image or atlas-page bytes changed.

Fresh independent REVIEW: PASS after all18blind/mapped stills,8browser images, both packed exits and5references inspected. No integration blockers. Neutral-surround exit fixture approved for sampling/state contrast only; complete scenes supply world context. Whole-product complete-pack and physical-device acceptance remain separate.
