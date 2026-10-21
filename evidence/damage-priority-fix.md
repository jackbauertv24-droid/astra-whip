# Same-step incoming damage priority

GAMEPLAY_RULES §2 gives incoming damage priority over outgoing attacks. Previously `world.step` resolved each foe's incoming contact and outgoing whip in encounter-list order, then processed projectiles. An active whip could kill an earlier foe before a later contact or projectile interrupted the hunter in that same step.

The world now advances every foe and resolves incoming contacts/projectiles before any outgoing whip damage. Standalone single-foe fixtures retain their default immediate resolution; production explicitly defers it. Existing once-per-attack IDs, hit geometry, timing, health, invulnerability and attack interruption are unchanged.

`game/tests/damage_priority.gd` exercises projectile and later-foe contact, both facings, lethal/nonlethal damage, and newly pressed/already-active attacks. Baseline `caa8e53`: 64 checks, eight failures, all identifying the outgoing hit before interruption. Fixed: 64 checks, zero failures. The shared runner includes this regression.

Main T-01–T-09: 1,241 assertions, zero failures. Continuous production stage completion and the affected boss death/entry/recovery/hazard/strike, whip impact, enemy defeat, swooper collision/recovery and ranged projectile regressions pass. Contract and all 25 art-tool negative cases pass. Exported pack checks are retained under the same evidence prefix. No source artwork or mandatory contract changed.
