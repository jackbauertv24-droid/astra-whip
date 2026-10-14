# Fix 2 — repaired turning animation accepted

The preview contained the repainted turn pose but had not completed its independent acceptance gate. The fresh reviewer inspected the neck/collar/shoulder join, all native frames/onions and runtime captures and approved both scoped clips: `art/review-turn-r01/review_verdict.md` ends `REVIEW: PASS`. The scoped audit reports zero DEFECT and zero FLAG. No additional repaint was needed.

A real-input capture harness now drives left input through the actual controller. It checks all four observed phases (F0 right, F1 right, F1 left, F2 left), and confirmed the facing event at exactly 75 ms in both desktop and phone-sized runs. These engine captures are desktop-rendered; no physical-device performance is claimed. All three runtime textures match the reviewed source.

Gameplay T-01…T-09 passed 1,213 assertions with zero failures; the contract checker passed. Art-tool code is unchanged from the passing 25-case self-test recorded for fix 1. The single-threaded Web export completed without script errors; package hash is in `turn-build.sha256`.

This closes turning's independent-review gap. Other clips and the full production inventory remain under the queue in `docs/FIX_QUEUE.md`.
