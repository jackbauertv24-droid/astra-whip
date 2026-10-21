# Restore canonical supplemental boss reactions

Final inventory/review detected that four supplemental recovery-hurt clips existed in the runtime and their scoped review pack, but not in art/frames. This left the complete pack missing twelve frames despite the game shipping them.

The exact previously reviewed files for boss_hurt_stooped, boss_hurt_rising, boss_hurt_half_stoop and boss_hurt_hazard_late are now copied from art/review-boss-hazard-r02/frames into the canonical root. Timing metadata and original derivation records are restored alongside them. Every copied byte matches its runtime counterpart; no art, gameplay, atlas or build bytes changed.

The production inventory checker caught12missing canonical files plus the incomplete aggregate count before this fix. It now verifies409production frames:405packed and4standalone background panels, including all source/runtime hashes and canvases, atlas coverage,13UIassets/19frames and unchanged mandatory/runtime contracts. Before report retained in canonical-context-before.json/log. Complete review r01 remains rejected for the incomplete pack; a fresh r02 review is required after regeneration.

Expanded68clip/368frame review-only audit reports0DEFECT/34FLAG. Contract checker and25negative-case selftest pass. Mandatory/runtime contract files remain identical. Fresh complete-pack review is still required; no approval inferred from the numeric audit.
