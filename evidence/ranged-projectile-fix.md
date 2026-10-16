# Ranged projectile travel distance

GAMEPLAY_RULES§8.3 specifies280u/s and640u travel. The shot spawned40u ahead of the enemy but stored its root as the distance origin, so it vanished after600u of flight. The fix records the actual muzzle x as `start`. Shot timing, muzzle height, speed and collision dimensions remain unchanged.

The new actual-engine regression exercises both directions: no shot before50ms, exactly one shot at birth and after repeated fire updates, unchanged muzzle, distance origin,280u displacement after1s, survival at639u, expiry beyond640u, standing damage/consumption and crouch clearance on the actual floor. Before the change22checks produce4failures, exactly the two range-origin and premature-expiry checks per facing. Afterward all22pass. The regression is included in the default gameplay runner.

Logs include before/after, gameplay, contract/tool fixtures, release export and browser smoke. No new art or physical-device approval is claimed.
