# Atlas spacing follow-up

The hazard release used five 2048-square pages and measured 126.56 MiB of art texture allocation, leaving little room under the 128 MiB starting budget. Reduce only the outer atlas gutter from eight to two pixels. Keep the two zero source pixels inside every trimmed region, original canvas/pivots, nearest filtering and disabled mipmaps. No art or gameplay changes.

The same333 source frames now fit four pages. Conservative RGBA inventory is83.9375 MiB; measured software-renderer art allocation falls from132703404 to110333784 bytes (105.2225 MiB), a21.33 MiB saving. Empty scene7401763 bytes; total117735547 bytes. Physical-device performance remains unmeasured.

Validation:333 exact full-source RGBA round trips, deliberate one-byte corruption detected, padding/nonoverlap/inventory checks pass. All618 engine samples over103 pages match the original source-texture fixture exactly, zero changed pixels. Existing independently approved art is unchanged. Exported runtime2001 checks and source runtime1666 checks pass, including original-resource exclusion in the export.

The first exported-runtime attempt used a relative PCK path that Godot resolved beneath the project, failed to open it and fell back to source resources. Its333 exclusion failures are retained in atlas-spacing-exported-runtime-wrong-path.log/.exit; they are not accepted evidence. The absolute-PCK rerun passes2001 checks with zero failures.

See atlas-spacing-{roundtrip,render}.json and atlas-spacing-exported-runtime.log. Current export hash is atlas-spacing-web.sha256. Contract checks and defect self-tests are retained separately. Future art requires repacking and memory checks again.

Browser boot/resume/touch smoke at568×320 CSS pixels, DPR2 and44/44/21 safe insets passes with zero console/page errors. Initial server-absent attempt is retained separately; the localhost server was started before the passing rerun. Contract check and all25 defect self-tests pass.
