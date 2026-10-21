# Terrain review pack

Blind first: lineup_terrain.png and every strip_terrain_*.png; save/read per-tile descriptions before metadata. Fourteen opaque static tiles, each one frame; no character/effect alpha-border/anatomy/onion rules apply. Original mandatory animation contract unchanged. Inspect patch_3x3.png, repeat_fill_3x3.png, repeat_sides.png, repeat_caps_9.png and platform_repeat.png for seams; platform preview shows the actual top32px crop used by16u thin platforms. Generated crops are unedited and source records retained.

Actual renderer selects top/side/fill/bottom/concave roles from unchanged surface geometry. Single-cell spans join half of each authored end; partial cells crop uniformly at2px/u. Existing continuous Slate Edge top stroke remains presentation of the collision boundary. Engine kit board is nonplayable inspection geometry; stage captures are fixed views, not traversal proof. All original animation requirements remain in force.
