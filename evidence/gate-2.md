# Gate 2 — greybox

PASS. Godot 4.7.2-stable official ed1daf0bf, headless Linux, 120 Hz.

Command:
```
GODOT_BIN=/tmp/astra-tools/Godot_v4.7.2-stable_linux.x86_64 tools/test-game.sh --mutations
```

- T-01 through T-09: PASS, 1,213 assertions, zero failures.
- Every deliberate mutation: expected nonzero exit and matching test failure.
- No-trap sampling: 229 valid standing origins, every 32 u along authored surfaces.
- Jump: 125.399 u rise, 0.391667 s apex, 192.025 u same-height travel; all within 6%.
- Full evidence: gameplay.log, test-runner.log, mutation-T-01.log through mutation-T-09.log.
- Mutation methods and limitations: mutation-methods.md.
- Level/platform choices and unresolved device gates: implementation-decisions.md.

No art approval, phone playtest, user study, or performance claim is made here.
