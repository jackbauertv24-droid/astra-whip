# Gate 1 — tools
Source: https://github.com/jackbauertv24-droid/gothic-whip-framework
Revision: cf717cab22b39344820c11ef9aaf3a827336ce14

`node tools/contract-check.mjs`: PASS, 64 clips / 356 frames.
`node tools/selftest.mjs`: PASS, 25 deliberate defect cases, 0 problems, 46.3 seconds.
Node: v24.19.0.

Setup correction: copying only tools and contract (as BUILD step 1 says) leaves
contract-check's required docs/ASSET_BRIEFS.md missing. Copied the supporting
specification documents too, without modifying contract or checker behavior.

Engine release verified through `gh api repos/godotengine/godot/releases/latest`:
4.7.2-stable. Web baseline checked against official export documentation:
https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_web.html
Compatibility renderer, single thread, GDScript, gesture before audio.

This repository is a separate implementation; the upstream spec is unchanged.
