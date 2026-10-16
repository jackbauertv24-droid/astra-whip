# Boss waiting idle delivery and clock correction

Scope: boss_idle, eight125ms frames,1000ms loop. Accepted walk support supplies the fixed feet/pivot and exact neutral endpoint. Local0–2px inhale and0.6px cloth response are D23 scripted fallback after retained generated boss-sheet scale/registration failure. There is no actor resizing or corrective recentering. Scripted animation quality debt remains.

The previous inactive-arena branch returned before ActorVisual.follow/queue_redraw, freezing waiting animation. The corrected branch advances the presentation clock while preserving the arena gate on boss behavior. The new headless regression fails on the old branch (16/26checks) and passes on the correction (26/26), with both facings, eight phases,1000ms wrap,fixed root,production8HP and actual activation→walk. The native capture fixture also fails before the correction. Original code is retained in history, with negative exit1 logs separate from passing logs.

Actual Godot native/phone captures contain all eight frames,wrap and outgoing walk in each facing:40PNGs total. Arena remains inactive during the waiting loop; actual activation enters the approved walk. These are desktop viewport captures, not physical iPhone observations. Automated art audit has zero defects/flags. Browser smoke checks web boot/start/pause; waiting action evidence is native.

Fresh independent PASS: `art/review-boss-idle-r01/review_verdict.md`, idle plus walk support/handoff reference,all40PNGs inspected. Idle is deliberately restrained at phone size. Actual phone PNG dimensions698×393 differ from852×393viewport metadata; this proves readability at delivered image size only. Exact-width capture correction belongs to pending phone validation.

Validation completed: contract,25defect tools fixtures,1213gameplay assertions,pivot/swooper collision/recovery/projectile range/art regressions,26waiting clock checks,native/phone captures,Web export and Chromium boot/input smoke all exit0. Negative freeze/clock proofs intentionally exit1.
