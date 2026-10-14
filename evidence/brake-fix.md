# Fix 3 — grounded braking weight transfer

Only F1 was replaced with a painted knee-compression pose: both soles remain grounded while the rear foot draws inward. The approved neutral portrait is reused without scaling after two generated portraits failed the head tolerance. The body uses one bounded uniform normalization (0.973214); there is no limb deformation. Raw images, normalization records, failed candidates and reviews are retained.

Fresh independent review approved hero_stop_move and style_hero_neutral in art/review-brake-r03/review_verdict.md. Scoped audit: zero defects and flags. All three runtime textures match reviewed source; F0/F2 remain byte-identical. Canonical 3 × 50 ms timing and gameplay logic are unchanged.

Gameplay passed 1,213 assertions; contract checker passed; 25 negative art-tool cases passed with zero problems. Actual Godot captures include every frame at desktop and phone-sized resolution. These discrete desktop-rendered frames support pose/continuity inspection; physical-device performance and live playback timing are not claimed. Web export completed without script errors, and Chromium smoke testing reported no errors. Package hash: brake-build.sha256.

The earlier passing-pose and compressed-boot revisions remain rejected. Remaining work follows docs/FIX_QUEUE.md.
