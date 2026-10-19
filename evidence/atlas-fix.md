# Lossless runtime animation atlases

The original 302 runtime frame PNGs occupy 242.70 MiB of RGBA canvas data before static art. A deterministic, unrotated MaxRects packer trims only zero RGBA pixels, preserves two source pixels around each occupied rectangle and adds eight transparent gutter pixels. Every source file remains in the repository. Four 2048² RGBA8 pages use 64 MiB, with lossless imports, nearest filtering and no mipmaps. AtlasTexture margins retain the exact authored canvas and pivot. Frames and pages are shared. All 302 originals are excluded from the exported pack; direct existence checks confirm exclusion.

Whip masking now subtracts the atlas region origin and restores the trim origin before measuring distance to the authored hand socket. No art source or gameplay timing changes.

Validation:
- All302 reconstructed source canvases match full RGBA SHA-256 values, including hidden RGB and faint alpha. A one-byte negative control is detected. Padding, overlaps and inventory are checked.
-550 body/weapon samples in both facings,92 native engine capture pages. Body-only renders match exactly. With packed whip masking, one pixel differs by one 8-bit channel value across the full fixture. The comparison explicitly permits only that bound; raw source RGBA remains byte exact.
- Conservative current inventory, including every unpacked PNG:83.9375MiB. Future art requires repacking and rebudgeting.
- Actual exported-packing runtime:1815checks,zero failures. Software OpenGL reports110,333,784bytes art allocation above7,401,763byte empty-scene baseline;117,735,547bytes total. This is desktop evidence, not physical iPhone profiling.
- Full gameplay/UI regressions, contract check and25-case defect selftest pass. Compact density2 Chromium boot/resume has no browser errors.

Failed attempts are retained: a capture harness initially misclassified hero_hurt_recoil as a boss hurt context; exact trim boundaries produced3236 edge differences regardless of gutter width; two preserved source-border pixels fixed those differences. The first body-only atlas passed RGBA estimates but exceeded observed renderer memory; including whip frames resolved that excess. Initial full-renderer and isolated over-budget logs remain. A diagnostic for an unavailable debug API also remains as a failed diagnostic, not validation.
