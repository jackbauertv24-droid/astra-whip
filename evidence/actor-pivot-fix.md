# Actor sprite registration repair

The previous renderer assigned the pursuer's (32,-96) source-pixel offset to all non-hero actors. The renderer now derives the offset from each actor's authoritative canvas and pivot, reflecting the horizontal offset with facing.

`actor-pivot-before.log` records six actual failing registration checks against the previous renderer. `actor-pivot-targeted.log` records zero failures across five actors and both facings. The check uses a full-size texture with a marked source pivot and the actual sprite's world transform. `actor-pivot-gameplay.log` records 1,213 passing gameplay assertions. No actor PNGs, gameplay constants or contract values changed. Hero and pursuer retain their prior registration; remaining enemy textures are still pending production art.

Web export: `actor-pivot-export.log`; exact exported pack hash: `actor-pivot-build.sha256`. Physical iPhone validation is not performed.
