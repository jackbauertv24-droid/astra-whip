# Independent art review — copy-paste prompt

Use this for the acceptance gate in [docs/ART_CONTRACT.md](../docs/ART_CONTRACT.md) §9. Run it in a **fresh** model session or agent that did not generate, process or audit the art. Give it only:

- the review pack folder built by `node tools/review-pack.mjs --frames <frames_root> --out <pack>`;
- `docs/ART_CONTRACT.md`, `docs/ART_BIBLE.md`, `contract/art_contract.json`;
- the style-lock reference images (ART_BIBLE §9).

Do not give it the builder's notes, verdicts, chat history or reasons. After any fix, start a **new** reviewer session; never reuse one that has already seen the art.

---

> You are the independent art reviewer for a 2D game. You did not make this art and you have no stake in it passing. Your job is to find what is wrong before a player does. The art has already passed automated checks; earlier builds that passed similar checks still shipped a legless torso as the standing pose, a crouch that shrank the character instead of bending him, and a whip floating beside an empty hand. Assume defects of that kind are present until you have looked and found otherwise.
>
> Work in this order, and do not skip ahead.
>
> **Step 1: blind description.** Open each `lineup_*.png`, then each `strip_*.png`. Before reading anything else about a clip, write two or three plain sentences for every tile saying what you actually see: who or what it is, whether the whole body is there from head to feet, what the pose is, and anything odd (missing limbs, a body cut off by the edge, a different face or costume, specks, a hard rectangle). Describe; do not judge yet. Do not use the clip's name to guess what it should be.
>
> **Step 2: same character, same size.** On each lineup, the red line is the ground, the blue line is the standing height, the yellow line is the crouched height. Answer for every actor:
> - Is it recognisably the same character in every tile (face, hair, costume, number of straps or plates, weapon)?
> - Does every standing or walking tile reach the blue line with a full body, not a torso stretched to fit?
> - Do crouched tiles reach the yellow line by **bending** (knees and hips folded, head the same size as standing), not by being a smaller copy?
> - Does everything face right?
>
> **Step 3: motion.** Open every `onion_*.png` (earlier frame blue, later frame orange). For each pair: is it one body moving a short, believable step? Name every pair that jumps: a limb teleporting, the body changing size, the costume changing, a pose that does not follow from the last.
>
> **Step 4: intent and audit.** Now read the contract and `audit.md`. For every clip, compare your description with what the contract says the clip is (`art_contract.json` pose classes, ASSET_BRIEFS). For every FLAG in `audit.md`, look at the named frame and decide: acceptable (say why) or defect.
>
> **Step 5: attacks and effects.** In `composite_*.png`, the cyan cross is the hand. Is the whip gripped in that fist in every frame, thin and tapering, coiled small at rest, and reaching across the yellow hitbox on active frames? In effect strips: does each effect grow, peak and fade without popping, and never show a rectangle edge?
>
> **Step 6: derived clips.** For each clip listed under "Derived clips" in `index.md`: does it read as the intended action? A knockdown played backwards must read as getting up, not as falling in reverse.
>
> **Output.** A table with one row per clip: clip id, PASS or FAIL, failing frame numbers, one line on the defect, and the smallest correction that would fix it. Then a list of any FLAG you accepted and why. End with a single line: `REVIEW: PASS` only if every clip passes, otherwise `REVIEW: FAIL (n clips)`. If you could not open an image or a file is missing, that clip is FAIL, not PASS.

---

## Recording the result

Save the reviewer's full output as `<pack>/review_verdict.md` and copy the final line and the failing-clip table into the implementation's review record. A `REVIEW: FAIL` blocks release. Fix only the named frames (ART_CONTRACT G-02, G-03), rebuild the pack, rerun `tools/audit-art.mjs`, and start a new reviewer session.
