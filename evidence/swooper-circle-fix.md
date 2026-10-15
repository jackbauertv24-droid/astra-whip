# Exact swooper circle collisions

The specified radius-40 circle now tests the nearest point of the hunter/whip rectangle. Previously contact used a distance-to-hunter-center shortcut and whip hits used the bounding square. This missed true contact above/below the hunter and allowed whip hits in empty square corners. Radius is unchanged and shared through `Rules.SWOOPER_RADIUS`; other actors retain their rectangle intersection.

`game/tests/swooper_collision.gd` drives real foe simulation, contact damage, whip damage and target deduplication. Thirty-two cases cover both facings and standing/crouched bodies: top/bottom/side contact caps, square-corner and out-of-radius misses, a corner miss that leaves the target available to a later true hit in the same attack, and repeat-hit suppression. A test-only 2 HP foe allows the nonlethal dedup proof; production basic HP remains 1.

`swooper-circle-before.log` records 12 failures against the previous renderer-independent collision implementation. `swooper-circle-targeted.log` records all 32 passing after the fix. The default test runner includes the circle suite and actor-pivot regression; its scoped full output is `swooper-circle-default-suite.log`. Existing gameplay regression and art-tool check results are retained in their scoped logs. No actor artwork changed, so no new art approval is claimed.

Export, browser smoke, build hash and deployment are recorded separately. Physical-device validation remains unperformed.

The final corner-miss fixture uses the whip's upper outer corner, at a flight altitude reachable during dive/climb, and was rerun against both previous and corrected collision code. The earlier default-runner proof used the geometrically equivalent lower corner; its complete output is retained, and the final 32-case result is in `swooper-circle-targeted.log`. Both old-code runs produced 12 failures and both corrected runs passed. `swooper-circle-pivot.log` retains the default runner's pivot check; `swooper-circle-default-collision.log` retains its original collision output.

Final checks: existing gameplay 1,213/1,213, collision 32/32, actor pivots zero failures, contract 64 clips / 356 frames / 64 rows, art self-test 25/25. Scoped Chromium156 smoke booted the export, started gameplay, ran AI and paused with no page/console errors. See `swooper-circle-browser-smoke.json` and screenshot. Export/hash: `swooper-circle-export.log`, `swooper-circle-build.sha256`. The committed web artifact is the tested build.
