# Copy-paste build prompt

Use this to have a model implement the game from this specification. It is written for an autonomous run (D21): no human reviews art or code along the way, so each gate below is the review. Run it in a new repository; this specification repository stays documents and tools only.

---

> You are building the first playable slice of a 2D gothic horror platformer, specified in full in this repository. Work autonomously; do not ask the user questions. Where the specification leaves a routine detail open, choose, record the choice and its reason in your review record, and move on. Never change a CONFIRMED decision in `docs/DECISIONS.md`.
>
> **Read first, in this order:** `AGENTS.md`, `SPEC.md`, `docs/DECISIONS.md`, `docs/LESSONS.md` (what the last build got wrong), `docs/GAMEPLAY_RULES.md`, `docs/STAGE_DESIGN.md`, `docs/ART_CONTRACT.md`, `docs/ART_BIBLE.md`, `docs/ASSET_BRIEFS.md`, `docs/TECHNICAL_SPEC.md`, `docs/VALIDATION.md`, `prompts/ASSET_GENERATION.md`, `prompts/ART_REVIEW.md`.
>
> **Build in this order. Do not start a step until the previous step's gate has passed. Commit at every gate.**
>
> 1. **Tools.** Copy `tools/` and `contract/` from the specification repository. Run `node tools/contract-check.mjs` and `node tools/selftest.mjs`; both must PASS. If either fails, stop and report: the contract is broken, not your art.
> 2. **Greybox.** Godot project per `docs/TECHNICAL_SPEC.md`, gameplay per `docs/GAMEPLAY_RULES.md` with every constant copied unchanged, stage per `docs/STAGE_DESIGN.md`, flat-colour placeholder shapes for every actor. Write the headless tests T-01…T-09 of `docs/VALIDATION.md`. *Gate:* all pass, and each was seen failing once with its rule deliberately broken (record how).
> 3. **Style pack.** Generate the five calibration pieces of `docs/ART_BIBLE.md` §8 following `docs/ART_CONTRACT.md` §8. Put `style_hero_neutral` in the frames layout of `contract/art_contract.json`. *Gate:* `node tools/audit-art.mjs --frames <root> --only "^style_" --allow-missing` has 0 DEFECT, and a fresh reviewer session given the pack and `prompts/ART_REVIEW.md` returns `REVIEW: PASS`. Register the style lock in ART_BIBLE §9.
> 4. **Hero and whip.** All hero and whip clips, key poses first, then in-betweens, with `clips.json` and `hand_sockets.json`. *Gate:* `audit-art --only "^(hero_|whip_|style_hero)"` 0 DEFECT; `node tools/review-pack.mjs` rebuilt; a **new** reviewer session returns `REVIEW: PASS`. Fix only named frames; keep every replaced frame (G-06).
> 5. **Enemies, boss, effects, terrain, props, UI.** Same loop per actor: audit 0 DEFECT, review pack, new reviewer session, PASS.
> 6. **Integration.** Replace placeholders; state machines stay authoritative and sprites only follow them. Re-import after every atlas repack and run the pixel round-trip check (`docs/TECHNICAL_SPEC.md` §7). *Gate:* the full audit has 0 DEFECT; a final reviewer session over the complete pack returns `REVIEW: PASS`; T-01…T-09 and the engine frame-step test pass; in-engine captures at phone size (standing, walking, crouching, mid-strike, mid-air, boss) are in the review record.
> 7. **Web build.** Single-threaded export per TECHNICAL_SPEC §3, published, and the deployed `.pck` checksum matches the local export.
>
> **If image generation fails** mid-run, you may derive frames by script from approved frames (ART_CONTRACT §11): label each in `derivations.json`, pass every gate, and list them in the handoff as quality debt.
>
> **Handoff.** Report, for every gate: the command or session that produced the evidence, its result, and where the evidence lives. List every FLAG accepted and why, every derived clip, every choice you made where the spec was silent, and everything not tested. iPhone 17 device gates (VALIDATION V5, V8) stay PENDING unless run on the device; desktop browser evidence is never reported as device evidence. Never write "should work".
