# Initial handoff review

Date: 2026-10-07. Scope: documents and examples only.

## Completed checks

- All 18 relative Markdown file links in the initial 16-file handoff resolve.
- The example asset manifest parses as JSON.
- The eight example attack-frame durations sum to 500 ms, matching the gameplay and asset contracts; active interval is [150, 250) ms.
- The proposed hero animation table totals 113 body frames plus 24 weapon frames (137 total).
- Untrimmed frame memory is explicitly reconciled as a budget conflict to solve before production: 113 MiB body + 36 MiB weapon exceeds the 128 MiB slice-art target.
- Final interview direction is reflected throughout: primarily Castlevania, no visible pixels, full supported-action animation. Earlier Mario/crossover brainstorming is not a production commitment.
- No existing workspace project, third-party art binary, game implementation, or generated asset was copied into this repository.

## Explicitly not tested

Engine import, sprite quality, animation playback, combat behavior, mobile touch controls, browser export, performance, loading, and Android APK. No implementation or assets exist to test.

## Open at publication

The final identity answer is confirmed: Simon Belmont in Castlevania’s world. Exact costume reference, horror intensity, target hardware, and proposed numerical tuning remain for later specification work. No further interview is required to use this handoff.

---

# Follow-up review — audit + P1 gameplay rules

Date: 2026-10-08. Scope: documents only. This entry appends to, and where noted supersedes, the 2026-10-07 record above; the original entry is retained unedited as history.

## Completed checks

- Cross-document audit written to `docs/AUDIT.md`. All shared numbers re-derived and consistent: jump envelope (640/1600 → 0.4 s apex, 128 u rise, 192 u same-height travel; SPEC's 112 u gap / 64 u step limits sit inside it); whip frame durations [75,75,50,50,62.5,62.5,62.5,62.5] sum to SPEC's 150/100/250 ms phases, 500 ms total, active interval [150, 250) ms; crouch body 40×60 centered (0, −30) vs standing 40×104 centered (0, −52) share the y=0 foot origin; knockdown + get-up (360 + 450 = 810 ms) fits inside the 1 s invulnerability.
- The manifest example still parses as JSON and matches the contracts; all relative Markdown links in the repo were re-resolved programmatically (18 checked, 0 broken before this pass's additions; re-checked after, see commit).
- `docs/GAMEPLAY_RULES.md` (Package P1) completed as a fully PROPOSED baseline: hero state-transition table covering every ANIMATION_SPEC state with interruption priority, input rules (100 ms coyote/buffer, opposing-input neutral, fresh-press whip, focus-loss input clear), damage/knockback/knockdown rules, all crouch-clearance cases, pit/death/checkpoint/retry cases, and briefs for the ground pursuer, airborne swooper, stationary ranged threat, and two-attack boss — each with timing windows shown arithmetically compatible with the 500 ms whip timeline and 128 u jump rise, at SPEC hit-points (1/2/8).
- Three user decisions dated 2026-10-08 recorded in `docs/DECISIONS.md` (Amendments section, ledger resolve format): D02/D12 superseded — protagonist and world are an **original hunter in an original gothic world** (Castlevania retained as design reference only); D13 confirmed — dread, decay, silhouettes, **no explicit gore**; D14 confirmed — target device **iPhone 17 / iOS Safari** (must-support). D09 and all other entries untouched.
- The identity contradiction (D02/D12 vs the public distribution confirmed in D15) is therefore closed. Remaining audit items are an unresolved texture-budget reconciliation (hero frames 149 MiB untrimmed vs the 128 MiB slice budget — P3/P5) and a list of wording follow-ups in SPEC/README/AGENTS/ART_DIRECTION/ASSET_SPEC/prompts that this pass deliberately did not edit (AUDIT B1/B11); TECHNICAL_CONSTRAINTS' Android-phone performance anchor is superseded in substance and owed a P5 rewrite, also not edited here.

## Explicitly not tested

Everything from the 2026-10-07 list still stands: engine import, sprite quality, animation playback, combat behavior, mobile touch controls, browser export, performance, loading, and Android APK. The iPhone 17 / iOS Safari target (D14) has no device evidence yet; VALIDATION gates V1–V9 all remain PENDING. No implementation or assets exist to test.

## Open after this pass

- D09 (stomp kills vs the contact-hurts baseline) is the only remaining user question; P1 proceeds on the proposed baseline.
- D07–D11 remain PROPOSED; `docs/GAMEPLAY_RULES.md` and its [P1 proposal] values need user confirmation or greybox evidence before being treated as settled.
- Follow-up packages unblocked in sequence: wording consistency pass (B1 list), P2 art bible (identity reference now creatable; D13 line fixed), P3 asset briefs with a packed texture-occupancy table (B2), P5 technical/export design anchored on iPhone 17 Safari (B4).

---

# Follow-up review — B1 wording consistency

Date: 2026-10-08. Scope: documents only.

## Completed checks

- B1 wording pass executed across the seven files enumerated in AUDIT B1/B11: `SPEC.md` (§1 identity, §2 signature moment, §5 "hunter's foot pivot" / contact wording), `README.md` (title line), `AGENTS.md` (intent bullet, guardrail meaning preserved), `docs/ART_DIRECTION.md` (visual grammar, Reject section), `docs/ASSET_SPEC.md` (§2, §3), `prompts/ASSET_GENERATION.md` (identity paragraph, hero key-pose example), `prompts/NEXT_LLM.md` (protagonist paragraph). Product identity now reads as an original hunter in an original gothic world; Castlevania appears only as design reference for tone/mechanics. No numbers, timings, or confirmed decisions were changed.
- Post-edit grep over the seven files: the only remaining "Simon" occurrence is in `prompts/NEXT_LLM.md`, explicitly describing the superseded interview-era identity. AUDIT items B1's follow-up list and B11 are closed by this pass (see AUDIT.md status notes).

## Explicitly not tested

Unchanged from prior entries: no implementation, assets, device, or performance evidence exists. VALIDATION gates V1–V9 remain PENDING.

## Open after this pass

- P4 stage design, P2 art bible, P3 asset briefs/texture budget, P5 technical spec (see subsequent entries), P6 readiness review, and user question D09.

---

# Follow-up review — P4 stage design

Date: 2026-10-08. Scope: documents only.

## Completed checks

- `docs/STAGE_DESIGN.md` written as a fully PROPOSED, NOT-TESTED blockout specification: the five SPEC §3 beats laid out over 104 terrain modules (x 0–6656) on the 64 u grid, with terrain layout per beat, an encounter table (effigy, five pursuers, two swoopers, one ranged threat, boss — HP 1/1/2/8 per GAMEPLAY_RULES), safe zones, checkpoint placement (module 64), boss arena bounds (modules 88–101), camera zones, and the first-minute teach sequence mapped to geometry.
- Mandatory-traversal proof is arithmetic, tabulated for all 20 mandatory elements: every gap is 64 u (≤112 u limit, 48 u margin — the only compliant same-level gap on a 64 u grid), every up-step 64 u (at the 64 u limit), every mandatory landing ≥128 u (six elements exactly at a limit, flagged as greybox probes). Conclusion: all mandatory geometry sits inside the proposed envelope; no impossible mandatory jump is specified. The 48 u knockback is shown to be less than half the narrowest mandatory landing (64 u), closing the AUDIT B6 dependency on P4. The no-sub-104 u-passage rule is recorded (no crouch-walk exists).
- Known feel-risks are stated rather than hidden: one pre-checkpoint pit (B2, module 34) on the single-checkpoint layout, and the at-limit steps.

## Explicitly not tested

No greybox, level file, or playtest exists; beat pacing (3–5 min), camera behavior, and all geometry "feel" are unproven. VALIDATION V6/V7 remain PENDING.

## Open after this pass

- P2 art bible, P3 asset briefs/texture budget, P5 technical spec, P6 readiness review, D09.

---

# Follow-up review — P2 art bible

Date: 2026-10-08. Scope: documents only.

## Completed checks

- `docs/ART_BIBLE.md` written (Package P2): a named palette of 17 swatches with proposed hexes mapped one-to-one to ART_DIRECTION's palette roles (plus budgeted signal/material colors for interactables, the enemy projectile, and the hunter), silhouette/material/light rules implementing the upper-left light and five-layer depth stack, an original hunter design brief (silhouette, face/hair, thorn-knot costume construction, layered whip — franchise elements named as rejection reasons), visual briefs for the pursuer, swooper, ranged threat, and boss keyed to GAMEPLAY_RULES §8 tells, environment kit rules, and the D13 line rendered as an enforceable permit/prohibit list for asset review.
- The style-pack calibration plan is written as five filled briefs in `templates/ASSET_BRIEF.md` format (`style_hero_neutral`, `style_hero_attack_key`, `style_enemy_pursuer`, `style_terrain_patch_3x3`, `style_env_mockup`) — briefs and reference requirements only; no images were generated or claimed. Each is marked DRAFT/PENDING per the template's rule that nothing is READY before the style reference exists; the reference register and style-lock process (`style_lock_r01` on approval) are defined.
- Cross-checked against P1: every tell the gameplay rules rely on (pursuer rear-up, swooper wing-fold, ranged charge, boss wind-up and hazard ring) has a matching visual specification; hitbox overlays use SPEC §5 numbers unchanged.

## Explicitly not tested

No candidate art exists; identity, palette, and readability are unverified until the pack is produced and reviewed at logical and phone sizes. VALIDATION V1 remains PENDING.

## Open after this pass

- P3 asset briefs/texture budget, P5 technical spec, P6 readiness review, D09.

---

# Follow-up review — P3 asset production briefs + texture budget

Date: 2026-10-08. Scope: documents only.

## Completed checks

- `docs/ASSET_BRIEFS.md` written (Package P3): complete slice inventory with per-asset ID, canvas, pivot, density, frame counts and durations (each clip's durations sum to its stated total; combat clips reproduce SPEC §5's [75,75,50,50,62.5,62.5,62.5,62.5] = 500 ms, active [150, 250) ms), sockets/events, collision references, dependencies, and rejection rules — hero 113 body + 24 whip frames (ANIMATION_SPEC counts), pursuer 46, swooper 36, ranged 31 + projectile 3, boss 70 (enemy/boss counts proposed here with clip totals tied to GAMEPLAY_RULES tell/recovery timings), 14 terrain tiles, 4 backgrounds, 4 stage props, 18 UI assets, 6 VFX clips, audio deferred as an ID inventory. Manifest field definitions are stated against `templates/asset-manifest.example.json`.
- `docs/TEXTURE_BUDGET.md` reconciles AUDIT B2 with full arithmetic: slice total 278.97 MiB untrimmed → 102.68 MiB trimmed under stated per-class trim factors at 85% packing efficiency = 8 atlas pages all-resident (170.7 MiB mipmapped; 128.0 MiB without mips) — **the 128 MiB budget does not hold as written**. Peak-concurrency readings: boss-arena peak 7 pages (112.0 MiB without mips), mixed-beat peak 6 pages (96.0 MiB). The proposed smallest contract change (no mip chains on slice art + peak-concurrency residency ≤7 pages with the boss-gate swap) is recorded as PROPOSED for P6/user ratification; no ASSET_SPEC or TECHNICAL_CONSTRAINTS number was edited. AUDIT B2 status updated accordingly: reconciled on paper, unresolved in fact until real packed art is measured.

## Explicitly not tested

No art exists to trim, pack, or measure; every trim factor and the 0.85 packing efficiency are planning assumptions. VALIDATION V2/V8 remain PENDING.

## Open after this pass

- P5 technical spec, P6 readiness review (including ratification of the TEXTURE_BUDGET amendment), D09.

---

# Follow-up review — P5 technical / export specification

Date: 2026-10-08. Scope: documents only.

## Completed checks

- `docs/TECHNICAL_SPEC.md` written (Package P5): engine pinned to **Godot 4.7.2-stable** with matching export templates — verified by direct fetch of the official godotengine.org download archive page for 4.7.2-stable on 2026-10-08 (4.8 exists only as dev snapshots and is excluded); GDScript (not .NET) and the Compatibility renderer per D10 and the official web-export documentation; single-threaded web export as the baseline, with the COOP/COEP cross-origin-isolation requirement stated as the reason threaded builds are not the default.
- Scene/input/data boundaries specified per TECHNICAL_CONSTRAINTS' responsibility split (input layer, player state machine, combat hit-IDs, animation event reporting, level data, presentation, per-set asset loading), an 8-item web export checklist, a device/browser matrix anchored on **iPhone 17 / iOS Safari as must-support** (D14) with desktop Chrome/Firefox as dev references, and a performance measurement protocol (60 fps, p95 frame ≤20 ms, ≤30 MiB cold payload, ≤12 s at 20 Mbps/50 ms RTT — all PROPOSED, NOT-TESTED) re-anchored from the superseded Android-phone anchor. Android APK remains DEFERRED with a prerequisites list. AUDIT B4's follow-ups are recorded as delivered.

## Explicitly not tested

No engine project, export, or device run exists. Every performance figure is a hypothesis awaiting the §5 protocol on real hardware; VALIDATION V5–V9 remain PENDING.

## Open after this pass

- P6 readiness review (contradiction sweep + acceptance matrix, including joint ratification of the TEXTURE_BUDGET amendment and this spec's import settings), user confirmation of D07–D11, and D09.

---

# Follow-up review — P6 readiness review

Date: 2026-10-08. Scope: documents only.

## Completed checks

- `docs/READINESS_REVIEW.md` written (Package P6), completing the WORK_PACKAGES sequence P0–P6 on paper. Full contradiction sweep over every shared value in the document set (jump envelope, whip timeline/hitbox, HP and i-frame arithmetic, frame counts 113 + 24 and enemy totals 46/36/31+3/70, stage clearances, texture figures, Godot 4.7.2 pin, iPhone 17 anchor, decision statuses): 25 AGREE, 3 DISAGREE — all values re-derived; the texture pipeline (278.97 MiB untrimmed → 102.68 MiB trimmed; 8/7/6-page residency readings; 144 MiB sensitivity case) recomputed programmatically and matched exactly; the manifest example re-parsed (durations sum 500 ms, active [150, 250]); all relative Markdown links re-resolved (60 in the pre-existing set, 136 including the new documents), 0 broken; stale-identity grep re-run (B1/B11 hold).
- Two genuine inconsistencies in the newer package docs found and fixed: **SW-1** — `ASSET_BRIEFS.md` §10 claimed "18 assets" where its own table enumerates 13 asset IDs / 19 frames (the count TEXTURE_BUDGET's UI pixels are computed from); corrected in ASSET_BRIEFS, and the P3 REVIEW_RECORD entry above repeats the 18 figure — left unedited as dated history, superseded here. **SW-2** — `STAGE_DESIGN.md` §5's R1 "lane covers ground modules 66–78" overlapped §6's safe-zone guarantee for the checkpoint apron (modules 63–66); the §5 cell now states the shots pass 198–223 u above the ground route and cannot hit a ground hunter, per §3. A third disagreement (TECHNICAL_CONSTRAINTS' and VALIDATION V5's Android hardware anchors vs the confirmed D14 iPhone 17 target) is recorded as resolved by the documented supersession in TECHNICAL_SPEC §4–5, without editing the historical files. `DECISIONS.md` was not edited; no confirmed requirement was rewritten.
- The WORK_PACKAGES "definition of specification-ready" applied item by item in READINESS_REVIEW §2: all six PASS on paper (first minute explainable from STAGE_DESIGN §7; full asset enumeration in ASSET_BRIEFS §§2–12; rendering vs collision separated per ASSET_SPEC §2 and per-asset collision references; attack timing derivable from SPEC §5 / ASSET_SPEC §3 / the manifest example alone; exact target device named in D14 + TECHNICAL_SPEC §4; proposal status readable from DECISIONS.md and every package header).
- Revised acceptance matrix (READINESS_REVIEW §3): VALIDATION gates **V1–V9 all remain PENDING**, each with the evidence that would close it. AUDIT roll-up (READINESS_REVIEW §5): B1, B4, B5, B7–B12 resolved-on-paper; B6 resolved-on-paper with greybox confirmation owed (V6); B2 reconciled on paper but open with the user (ratification) and with the implementation phase (measurement, V2/V8); B3 open with the user (D09). No audit item remains open with a package.
- Ratification list stated for the user (READINESS_REVIEW §4): **R1** the TEXTURE_BUDGET §5 amendment (no mip chains; ≤7-page peak-concurrency residency; 112.0 MiB peak) ratified jointly with TECHNICAL_SPEC §2's import settings — without it the 128 MiB budget fails as written (170.7 MiB all-resident mipmapped); **R2** D09 (confirm the contact-hurts/no-stomp baseline or request stomp kills); **R3** confirmation of the D07–D11 PROPOSED baselines and their P1–P5 derivatives; **R4** style-pack authorization at V1, after the implementation assignment. Production — Godot project, greybox, art, builds — requires a **separate explicit implementation assignment** per AGENTS.md and WORK_PACKAGES production gate 1; P6 does not grant or request it.

## Explicitly not tested

Unchanged from every prior entry: no engine project, export, art, animation, playtest, touch test, or device measurement exists. The iPhone 17 / iOS Safari target (D14), the Godot 4.7.2 pin, every performance figure, and every texture-budget number remain PROPOSED/NOT-TESTED hypotheses awaiting VALIDATION V1–V9 evidence.

## Open after this pass

- User ratifications R1–R3 (READINESS_REVIEW §4); D09 remains the only open interview question.
- The specification phase is complete on paper: P0–P6 delivered, AUDIT B1–B12 dispositioned, VALIDATION V0's document-side evidence assembled in READINESS_REVIEW §§1–2. The next step belongs to a future explicit implementation assignment (WORK_PACKAGES production gates 1–5), starting with locking the engine version and the proposed mechanics, then a greybox touch movement + whip test on iPhone 17 hardware.

---

# Follow-up review — art contract and lessons from the first implementation

Date: 2026-10-12. Scope: documents, `contract/art_contract.json`, `tools/`. Trigger: the user reviewed the first implementation (askjackb/gothic-whip-game, built autonomously 2026-10-08/09 from the drafts imported here) and its five rounds of user-found sprite defects, and asked for a specification concrete enough for autonomous full-quality builds. Decisions D20–D25 recorded from a scope interview the same day.

## Completed checks (all actually run)

- `node tools/contract-check.mjs`: PASS, 64 clips / 356 frames, 64 ASSET_BRIEFS rows cross-checked. Shown failing on two seeded mismatches (a changed walk duration in the JSON; a wrong stated total in the briefs).
- The check found four real specification defects on its first runs, all fixed: the ranged canvas (256×320, pivot 288) could not hold its 300 px figure; the pursuer canvas could not hold its rear-up tell; the boss canvas could not hold its wind-up; two ranged/swooper height bands were looser than their designs. The first three are exactly the clipping the first implementation shipped. TEXTURE_BUDGET re-run after the canvas changes: all page readings unchanged (8 / 7 / 6).
- `node tools/selftest.mjs`: PASS. A synthetic correct frame set for every clip audits with 0 DEFECT (also after a PNG round trip on disk), and 25 seeded defects are each reported by the rule aimed at them. Runtime about 40 s.
- `node tools/review-pack.mjs` on the synthetic set: 135 images; lineup and composite sheets inspected by eye (guides, sockets and hitboxes land where expected).
- All 172 relative Markdown links resolve; every JSON file parses.

## Explicitly not tested

- The tools have never been run on real painted art. Their thresholds come from the first implementation's audits, which were calibrated on that art set; the next build is the first real test, and every FLAG/DEFECT pattern it produces should be compared against what a reviewer sees.
- The independent-reviewer protocol (prompts/ART_REVIEW.md) has not been exercised on a real pack.
- Gameplay tests T-01…T-09 are specified, not implemented (they belong to a build).
- No engine, device or browser work was done.

## Swooper cruise follow-up — 2026-10-15

Fresh `/root/swooper_static_key_review_r01` accepted the single source key; fresh `/root/swooper_cruise_review_r01` independently accepted the complete cruise clip after blind observations, native frames/onions, registered style references, and actual desktop/phone-sized engine captures. Scoped verdict: `swooper_cruise | PASS | no failing frames | continuous articulated cruise beat with stable identity/body pivot`. Zero automated defects/flags. The held tail makes the labelled scripted fallback somewhat mechanical; this remains disclosed quality debt. Full output is retained in `art/review-swooper-cruise-r01/review_verdict.md`; six other swooper clips remain pending. No physical device approval is inferred.

## Swooper perch idle follow-up — 2026-10-15

Fresh `/root/swooper_idle_review_r01` completed blind observations, every native frame/onion/seam, five style references, and all 28 engine captures. `swooper_perch_idle | PASS | no failing frames | restrained stationary hover and continuous cruise handoff`; unchanged cruise reference also PASS. Zero defects/flags. Exact approved-frame reuse is accepted under D23, with the held shroud retained as disclosed quality debt. Full output: `art/review-swooper-idle-r01/review_verdict.md`. This does not approve five absent swooper action clips or physical-device behavior.

## Swooper dive warning follow-up — 2026-10-15

Fresh `/root/swooper_fold_key_review_r02` accepted the static folded key, then fresh `/root/swooper_telegraph_review_r01` reviewed the complete warning after blind observations, all native tiles/onions, five registered style references, and engine captures. `swooper_dive_telegraph | PASS | no failing frames | narrow fold held through the full 600 ms warning`; unchanged cruise also PASS. Zero defects/flags. The overlapping far wing is accepted as pose occlusion; subtle scripted acting remains disclosed quality debt. The outgoing dive capture switches to its geometric preview placeholder, explicitly outside scope and unapproved. Full verdict: `art/review-swooper-telegraph-r01/review_verdict.md`. Physical-device and remaining clip approval are not inferred.

## Swooper active dive follow-up — 2026-10-15

Fresh `/root/swooper_dive_review_r01` independently reviewed blind sheets, every source tile/onion, five style references and all actual before-tell/dive/recovery-entry captures. `swooper_dive | PASS | no failing frames | short pitching attack with local wing/cloth response`; unchanged cruise and warning references also PASS. The two A11 height flags at f001/f002 were accepted as visible pitching with conserved body dimensions and under 2% size changes. The outgoing recovery placeholder remains explicitly unapproved and pending. Full verdict: `art/review-swooper-dive-r01/review_verdict.md`. Scripted quality debt remains disclosed; no physical-device approval inferred.

## Swooper climbing recovery follow-up — 2026-10-15

Fresh `/root/swooper_recovery_review_r01` reviewed blind sheets, all 18 source tiles/onions/seam, four painted source keys, five registered style references and all 32 actual native/phone captures. `swooper_recovery_climb | PASS | no failing frames | bank/righting bridge, stronger wing pumping and continuous dive/cruise handoffs`; unchanged dive and cruise also PASS. All six A11 flags were accepted as legitimate pitch or projected membrane-area changes, with stable body scale/attachments. Coarse six-frame cadence and scripted/reused frames remain disclosed D23 quality debt. Full output: `art/review-swooper-recovery-r01/review_verdict.md`. Hurt/death, remaining inventory and physical-device gates are not approved by this scoped review.

## Swooper conditional hurt follow-up — 2026-10-15

Fresh `/root/swooper_hurt_review_r01` reviewed all 17 source tiles, sheets, painted keys, five style references and all 28 native/phone captures. `swooper_hurt | PASS | no failing frames | hood recoil, asymmetric banking stagger and exact recovery handoff`; cruise/recovery references also PASS. All five A11 flags were accepted as articulation and projected area changes. Review-order deviations are explicitly disclosed in the full verdict, `art/review-swooper-hurt-r01/review_verdict.md`. Approval covers the conditional test-only 2 HP nonlethal branch; normal production 1 HP still enters death_fall. Scripted quality debt, missing death art and physical-device gates remain unapproved.

## Swooper lethal fall follow-up — 2026-10-15

Fresh static reviewer r05 accepted the folded death key after rejected drafts were retained. Full motion r01 rejected unreadable final ash; r02 independently inspected all13 native source tiles, every sheet/onion/seam, five style references and all36 actual captures, then returned:

| Clip | Result | Failing frames | Finding | Correction |
|---|---|---|---|---|
| swooper_cruise | PASS | None | Connected articulated wingbeat and continuous seam | None |
| swooper_death_fall | PASS | None | Banking collapse, folded limp body, erosion and visible falling/settling ash in both facings/sizes | None |

Both A11 flags (folded membrane area12.6%; dissolve70.8%) were visually accepted. Full verdict: `art/review-swooper-death-r02/review_verdict.md`. All7clips/36frames now have exact runtime bytes, scoped approval and both-face native/phone coverage (`evidence/swooper-inventory.json`). D23 scripted/reused quality debt remains disclosed. This does not approve physical devices or other actors/inventory.

## Ranged rooted idle follow-up — 2026-10-16

Static r01 rejected a pinned aiming arm and post cap above the hood. Fresh static r02 accepted their correction. The first motion reviewer was interrupted with no verdict; fresh replacement `/root/ranged_idle_review_r02` saved blind observations first, opened all6 tiles/onion pairs, five style references and all32 native/phone captures, and returned:

| Clip | Result | Failing frames | Defect | Correction |
|---|---|---|---|---|
| ranged_idle | PASS | None | None in scoped idle | None |

Zero automated defects/flags. Full output: `art/review-ranged-idle-r01/review_verdict.md`. The900ms rooted loop and actual stage base(4608,432) are verified in both facings. Local scripted animation remains D23 quality debt. Outgoing aim is an explicitly unapproved placeholder; other ranged clips/projectile and physical-device gates remain pending.

## Ranged aim follow-up — 2026-10-16

Static r05 passed after retained duplicate-arm/lane failures. Motion r02 rejected a cross-clip repaint of the stationary body. The r03 candidate retains idle identity outside the local arm corridor; a scoped regression fails all6old frames and passes all6new frames. One reviewer stopped for failed blind-note persistence; fresh `/root/ranged_aim_review_r04` verified saved blind notes before intent, then inspected all12tiles, onions/seam, five style references and all32 native/phone captures.

| Clip | Result | Failing frames | Finding | Correction |
|---|---|---|---|---|
| ranged_idle | PASS | None | Coherent rooted breathing reference | None |
| ranged_aim | PASS | None | Connected raising arm, growing diamond, stable identity and mirrored muzzle alignment | None |

Zero audit defects/flags. Full output: `art/review-ranged-aim-r03/review_verdict.md`. Six150ms frames/900ms warning and fire-frame1 birth are engine-verified. D23 local rig remains disclosed quality debt. Fire/projectile placeholder graphics and physical-device gates remain unapproved.

## Ranged firing follow-up — 2026-10-16

Fresh full review r02 rejected charge pixels embedded in the body-only hand. A local generated clean-hand correction rederived only fire frames1–2; original frame0 remains exact. The scoped final-charge regression fails on157bright pixels in the retained rejected frame and passes with0in the correction. Fresh `/root/ranged_fire_review_r03` saved blind descriptions before intent, opened all15native frames/onions, five style references, corrected sources and all20current engine captures.

| Clip | Result | Failing frames | Finding | Correction |
|---|---|---|---|---|
| ranged_idle | PASS | None | Coherent rooted reference | None |
| ranged_aim | PASS | None | Continuous arm raise and growing diamond | None |
| ranged_fire | PASS | None | Exact incoming endpoint, charge contraction/disappearance and connected local recoil | None |

Zero audit defects/flags. Full verdict: `art/review-ranged-fire-r02/review_verdict.md`. Actual native/phone captures verify all3frames, bothfacings, fixed root, frame1shot and200ms handoff within a120Hz tick. D23 scripted debt remains. Recovery/projectile graphics and physical-device gates remain unapproved.

## Ranged recovery follow-up — 2026-10-16

Fresh `/root/ranged_recover_review_r01` saved blind descriptions first, then inspected all16native tiles/onions/seam, five style references, sources/derivation and all36actual captures.

| Clip | Result | Failing frames | Finding | Correction |
|---|---|---|---|---|
| ranged_idle | PASS | None | Rooted breathing reference | None |
| ranged_fire | PASS | None | Clean connected recoil endpoint | None |
| ranged_recover | PASS | None | Progressive connected arm lowering and plausible final settle, exact incoming/outgoing endpoint reuse | None |

Zero audit defects/flags. Full verdict: `art/review-ranged-recover-r01/review_verdict.md`. Actual700ms recovery, seven frames, bothfacings/sizes, fixed root and no extra shot pass. D23 local scripted/reused debt remains; hurt/death/projectile and external-device gates remain pending.

## Ranged nonlethal hurt follow-up — 2026-10-16

Fresh `/root/ranged_hurt_review_r01` saved blind observations before intent and inspected all15native tiles/onions, five style references, generated/corrected sources and all20runtime captures.

| Clip | Result | Failing frames | Finding | Correction |
|---|---|---|---|---|
| ranged_idle | PASS | None | Coherent rooted reference | None |
| ranged_aim | PASS | None | Continuous arm and diamond cue | None |
| ranged_hurt | PASS | None | Protective connected arm fold, small upper recoil and exact idle finish | None |

Zero audit defects/flags. Full verdict: `art/review-ranged-hurt-r01/review_verdict.md`. Real player input verifies the first whip interrupts aim at2HP→1HP without a shot, three60ms frames/180ms return, and second whip0HP/death. Phone read relies chiefly on the arm fold. D23 scripted debt remains; death art/projectile/device gates remain unapproved.

## Ranged supported death follow-up — 2026-10-16

Generated sheet registration drift, stretched local bridge and faint/floating ash drafts remain preserved. Fresh `/root/ranged_death_review_r05` saved blind descriptions before intent, then inspected all15native tiles/onions/seam, five style locks, painted intermediate/slump/ash sources and all40runtime captures.

| Clip | Result | Failing frames | Finding | Correction |
|---|---|---|---|---|
| ranged_idle | PASS | None | Coherent rooted reference | None |
| ranged_hurt | PASS | None | Connected protective fold/release | None |
| ranged_death | PASS | None | Progressive supported limp collapse, erosion and grounded painted ash visible at phone onset in both facings | None |

A11f005 accepted as intentional eroded-body→ash completion. Full verdict: `art/review-ranged-death-r05/review_verdict.md`. Late fade/cleanup were inspected, distinct from onset visibility. All6body clips/31frames now have exact runtime bytes, scoped approvals and both-facing native/phone frame coverage (`evidence/ranged-inventory.json`). Actual two-whip production2HP lethal path, final hold/cleanup and no dead contact pass. D23 debt, projectile art and physical-device/player gates remain explicitly pending.

## Ranged projectile and complete ranged inventory — 2026-10-16

Fresh `/root/projectile_grave_shot_review_r01` saved blind tile descriptions before intent, opened all3native frames/onion including seam, five style locks, charge/fire/source references and all40actual captures.

| Clip | Result | Failing frames | Finding | Correction |
|---|---|---|---|---|
| projectile_grave_shot | PASS | None | Open four-point phosphor diamond with coherent80ms phases/240msloop, matching charge/socket, phone-readable in both facings | None |

Zero audit defects/flags. Full verdict: `art/review-projectile-grave-shot-r01/review_verdict.md`. Measured source extents51/56/51px fit60px maximum; no guide or rectangle residue. Actual muzzle/phase/wrap/280u/s/640u, standing non-displacing hit and crouch clearance pass. Combined inventory verifies6body clips/31frames plus3projectile frames, exact runtime bytes, scoped approvals and allframes bothfacings/native+phone (`evidence/ranged-complete-inventory.json`). Projectile frames are directly generated; prior body D23 debt and physical-device/player gates remain disclosed.

## Boss walk reference — 2026-10-16

Fresh `/root/boss_walk_review_r01` saved and reread blind lineup/strip observations before intent, then inspected all8native tiles/onions, five style references, derivation and all36actual captures. `boss_walk`: PASS, no failing frames, zero audit defects/flags. Full verdict: `art/review-boss-walk-r01/review_verdict.md`. Alternating support/swing,640ms seam,70u/s stance travel and both-facing phone read pass. Quiet upper body and crowded mid-stride ankles are accepted quality limits; D23 debt remains. This approves8/70boss frames only; other actions and handoffs remain pending.

## Boss waiting idle — 2026-10-16

Fresh `/root/boss_idle_review_r01` saved/reread blind lineup and both strip descriptions before intent, then inspected16native frames/onions, five style references and all40actual captures. `boss_idle`: PASS; `boss_walk`: PASS as scoped support/handoff reference. No failing frames or audit defects/flags. Full verdict: `art/review-boss-idle-r01/review_verdict.md`. Grounded1s breathing loop and activation→walk pass. Phone PNGs are698×393 despite852×393viewport metadata: readability approved only at actual image size; exact output-width/device validation remains pending. D23 debt remains; nine other boss clips unapproved.

## Boss brief hurt — 2026-10-19

Fresh `/root/boss_hurt_review_r02` saved/reread blind lineup/strip observations before intent, then inspected19native tiles/onions, five style references and all20actual captures. `boss_hurt`: PASS; idle/walk reference compatibility PASS. Zero audit defects/flags. Full verdict: `art/review-boss-hurt-r01/review_verdict.md`. Three70/70/60ms grounded recoil frames,exact neutral finish,bothfaces and actual698×393phone-pixel read pass. Actual whip8HP→7HP/200ms walk return and separate explicit strike fixture6HP/noninterruption pass; strike art not approved. Phone width metadata limitation,D23 debt and eight other boss clips remain pending.

## Boss telegraphed turn — 2026-10-19

Fresh `/root/boss_turn_review_r02` saved/reread blind lineup/strip notes before intent, then inspected20native tiles/onions,five style references and all24actual captures. `boss_turn`: PASS with idle/walk references. Full verdict: `art/review-boss-turn-r04/review_verdict.md`. Frontal chest/hip rotation,inward gauntlet path and exact neutral handoffs read as a supported four-key turn; runtime single150ms facing event/300ms return pass in both directions. Current audit0defects/flags; failed head/mass drafts and aborted service-error review remain retained. Reused midpoint relies on the actual runtime flip. D23 and physical-device/phone-width limits remain; seven boss clips are pending.

## Boss complete strike cycle — 2026-10-19

Fresh isolated /root/boss_strike_review_r06 saved/read blind observations before intent, then inspected all45native tiles, nine onions, five style locks, provenance and all152actual runtime captures. Windup7frames,execute4,recover6 and9supplemental posture-hurt frames PASS. Full verdict: art/review-boss-strike-r04/review_verdict.md. Earlier weak recovery and discontinuous execution FAIL verdicts/captures remain retained. Four50ms execution keys now descend into progressive knee loading; recovery remains supported. The optional contextual strike classification is narrowly accepted by direct head/anatomy inspection; mandatory contract unchanged. Scripted rigidity and angular armor remain D23 quality debt. Phone images698×393,not physical-device evidence. Mandatory boss inventory40/70; hazard/death remain pending.

## Implementation checkpoint presentation —2026-10-20

Fresh independent reviewer: `/root/checkpoint_review_r01`; full verdict `art/review-checkpoint-r01/review_verdict.md`.

| Clip | Result | Failing frames | Correction |
|---|---|---|---|
| prop_checkpoint | PASS | None | None required |
| vfx_checkpoint_activate | PASS | None | None required |

All10delivered frames, both onion sheets, five style references and56actual engine images inspected. Scoped audit0DEFECT/0FLAG. REVIEW: PASS. This approves these two assets only; other inventory/device/player gates remain pending.

## Implementation tutorial target —2026-10-20

Fresh independent `/root/effigy_review_r01`: full verdict `art/review-effigy-r01/review_verdict.md`.

| Clip | Result | Failing frames | Correction |
|---|---|---|---|
| prop_effigy | PASS | None | None required |

Single delivered frame, five style references and36actual native/phone PNGs inspected. Scoped audit0DEFECT/0FLAG. REVIEW: PASS, limited to this prop.

## Implementation boss gates —2026-10-20

Initial fresh r01 reviewer FAILED two cross-shaped spandrel ornaments (ART_BIBLE §5); only those two local patches were changed. Fresh `/root/boss_gate_review_r02` full verdict: `art/review-boss-gate-r02/review_verdict.md`.

| Clip | Result | Failing frames | Correction |
|---|---|---|---|
| prop_boss_gate | PASS | None | None required after r02 local ornament edit |

Delivered panel, five style references and38actual native/phone images inspected. Scoped audit0DEFECT/0FLAG. REVIEW: PASS for this prop/presentation only.

## Implementation exit door —2026-10-20

Fresh final reviewer `/root/exit_review_r02`; full verdict `art/review-exit-r02/review_verdict.md`. A new review followed the shader sampling correction.

| Clip | Result | Failing frames | Correction |
|---|---|---|---|
| prop_exit | PASS | None | None required |

Delivered frame, five style references and20final native/phone PNGs inspected. Scoped audit0DEFECT/0FLAG. REVIEW: PASS for this prop/presentation only.

## Implementation complete terrain kit —2026-10-20

Fresh independent `/root/terrain_review_r01`: full verdict `art/review-terrain-r01/review_verdict.md`. All14raw tiles/strips, five style references, five repeat samples and all20actual native/phone captures inspected.

| Asset | Verdict | Failing frame/sample | Finding | Smallest correction |
|---|---|---|---|---|
| terrain_cap_left | PASS | — | Worn cap and dark left boundary read as exterior top corner. | — |
| terrain_cap_mid | PASS | — | Repeated coping stays continuous; body joints match reference masonry. | — |
| terrain_cap_right | PASS | — | Right cap terminates coherently without losing walkable edge. | — |
| terrain_side_left | PASS | — | Exposed left border remains readable through vertical repeats; FLAG adjudicated below. | — |
| terrain_side_right | PASS | — | Repeated right face remains a vertical edge, not a bright false ledge. | — |
| terrain_fill_center | PASS | — | Repeated gray body and dark module joints stay within approved material grammar. | — |
| terrain_bottom_left | PASS | — | Left border meets distinct underside band in a closed corner. | — |
| terrain_bottom_mid | PASS | — | Bottom band reads as underside rather than another walkable cap. | — |
| terrain_bottom_right | PASS | — | Closed right underside corner matches adjacent bottom band. | — |
| terrain_inner_left | PASS | — | Left concavity reads in stepped board silhouette with continuous coping. | — |
| terrain_inner_right | PASS | — | Opposite concavity turns cleanly at the board step. | — |
| terrain_plat_end_left | PASS | — | Cropped left end closes long and single-cell platforms. | — |
| terrain_plat_mid | PASS | — | Top32 crop retains shallow fascia and continuous landing line. | — |
| terrain_plat_end_right | PASS | — | Cropped right end closes long and joined single-cell spans. | — |


Scoped opaque-static audit0DEFECT/1FLAG. The side_left vertical repeat diagnostic was independently accepted as a masonry joint after comparison with the approved patch and actual phone images. REVIEW: PASS for these fourteen static assets. Collision/rules source hashes unchanged; physical-device and traversal claims excluded.

## Implementation camera and phone landing clearance —2026-10-20

Initial fresh r01 review FAILED distant-camera retry entry and ground fallback beneath controls. Both corrected with regression coverage. Fresh `/root/playfield_review_r02` saved/read blind notes, inspected all20actual native/phone PNGs and all five style references. Full verdict `art/review-playfield-r02/review_verdict.md`: REVIEW: PASS for camera presentation; no failing scoped samples. Existing animation approvals and physical-device/player gates remain independent.

## Implementation four background panels —2026-10-20

Initial r01review failed missing-subject attack evidence; corrected fixtures are independently re-reviewed. Fresh `/root/background_review_r02` full verdict `art/review-background-r02/review_verdict.md`: REVIEW: PASS. All4raw frames/strips,5style references,2triple repeats,4seam/midpoint crops and30actual stage/attack/boss-fixture PNGs inspected.

| Asset | Verdict | Findings | Failing images |
|---|---|---|---|
| bg_sky | PASS | Dark violet painted cloud field matches the environment reference, stays behind all play information, and has no stars, warm distraction, pixel grid or photorealistic mismatch. Opaque static texture is appropriate. | None |
| bg_distant_silhouette | PASS | Teal mist and repeated spires establish distance with lower contrast than near masonry. Both wrap and midpoint join continue clouds, mist and silhouettes without a hard rectangular or material seam. Bilateral motifs are discernible when deliberately studied in the wide repeat, but remain plausible ruined-city rhythm and do not become a distracting joint in supplied stage captures. | None |
| bg_midground_arch | PASS | Matte charcoal/violet stone, pointed arches and tracery match the locked mockup and terrain family. Full strip/repeat clearly exposes reflected architecture; this is visible reuse, not an invisible organic panorama. The midpoint is a coherent broken central pier and the wrap forms a coherent paired-arch pier: no split blocks, lighting jump, clipped contour, material discontinuity or bright vertical seam. Its repetition is noticeable in the scene but does not impair depth or play readability. | None |
| bg_foreground_frame | PASS | Sparse near-black violet branch corners with a genuinely open transparent center, no opaque backing or visible extraction halo. Mirroring is apparent but harmless for corner framing. Visible segments remain high at screen edges, away from actors, landing lines and tells. | None |


Noticeable mirrored scenery remains an accepted quality limitation. No actor animation or physical-device approval inferred.

## Implementation health UI pair —2026-10-20

Fresh `/root/ui_health_review_r01`; complete verdict `art/review-ui-health-r01/review_verdict.md`.

| Asset | Verdict | Failing samples | Correction |
|---|---|---|---|
| ui_health_full | PASS | None | None required |
| ui_health_empty | PASS | None | None required |

Both raw frames/strips, five style references,25actual fixture PNGs and3browser PNGs individually inspected, including CSS-size reductions. All5→0filled/hollow counts and live health text pass; portrait row hidden. Scoped audit0DEFECT/0FLAG. REVIEW: PASS for health presentation only; physical-device and combat/animation claims excluded.

## Painted controls r01

Fresh `/root/ui_controls_review_r01`: REVIEW: PASS for all six assets/twelve states. All12raw frames,5style references,19engine captures and4browser PNGs inspected after saved/read blind notes. Compact CROUCH plate overhang adjudicated legible and separated. Complete verdict: art/review-ui-controls-r01/review_verdict.md. Static UI only; no device/traversal approval.

## Checkpoint HUD r01

Fresh `/root/ui_checkpoint_review_r01`: REVIEW: PASS for off/on icons. Both raw and delivered frames,5style references,21engine views and4browser PNGs individually inspected after saved/read blind observations. Hollow/filled32x24CSS distinction, actual state mapping, whole text, safe spacing and portrait hiding pass. No unresolved flags. Full verdict: art/review-ui-checkpoint-r01/review_verdict.md.

## Completion UI r01

Fresh `/root/ui_completion_review_r01`: REVIEW: PASS for retry/victory and supplied menu integration. Both raw/delivered frames,5references,21engine and5browser views individually inspected after saved/read blind phase.32CSS retry,48CSS crown/laurel, live captions, scrolling, actual clicks/reset and hidden competing controls pass. No unresolved flags. Full verdict: art/review-ui-completion-r01/review_verdict.md.

## Rotate UI r01

Fresh `/root/ui_rotate_review_r01`: REVIEW: PASS after raw/delivered art,5references,9engine and6browser PNGs individually inspected after blind saved/read observations. Device silhouettes and clockwise arrow read at320CSS phone size;20CSS live wording, safe placement, portrait-only visibility and explicit landscape resume pass. No blockers or unresolved flags. Full verdict: art/review-ui-rotate-r01/review_verdict.md.

## Linear sampling integration r01

Fresh `/root/linear_sampling_review_r01`: REVIEW: PASS for supplied rendering integration after all18blind and18mapped actual views,8browser PNGs, both packed exit states and5references inspected. Small UI/held states, alpha edges, depth/effects, menus and orientation pass. Neutral-surround exit fixture accepted for sampling/state contrast only; complete scenes provide context. Whole-product/source-animation/device gates separate. Full verdict: art/review-linear-sampling-r01/review_verdict.md.

## Canonical supplemental delivery repair

Twelve restored canonical files match both art/review-boss-hazard-r02/frames and game/assets/boss byte-for-byte. No art/runtime/build bytes changed.409frame inventory and expanded68clip audit pass numeric checks;34flags remain for fresh complete review. Complete r01 pack omitted the four contexts and cannot receive acceptance.

## Final handoff choices and verification — 2026-10-21

The pinned upstream contract stays unchanged. Additional boss hurt contexts retain the previously declared supplemental contract. Static props, opaque terrain/background panels and UI use their own honest scopes rather than weakening timed transparent-sprite rules. The full 409-frame production inventory now checks canonical files, runtime files and packed coverage.

Routine technical choices: Godot 4.7.2 Compatibility, single-threaded web export, five shared lossless atlas pages, no mip chains and linear filtering. Native/phone fixtures and desktop browser emulation are labeled by actual dimensions/density; none substitutes for physical iPhone acceptance. Maximum lossless WebP encoder effort (100) was selected after measuring an oversized cold payload. The export helper invalidates only the nine shipped generated texture caches; all nine decoded RGBA hashes remain identical. Source PNGs, pivots, gameplay constants, hitboxes and timing are unchanged by compression.

The continuous stage acceptance driver reads terrain and live AI, sends ordinary input and reaches the actual unlocked exit. Its early controller failures are retained; the final run does not alter health, enemies or collision. An automated speedrun is not evidence of unfamiliar-player pacing or touch comfort.

All 100 per-asset derivation records, including source/method/reason, are handed off in `evidence/release-derivations.json`; authoritative records remain in `art/frames/derivations.json`. Scripted animation, reversed/reused frames, mirroring and repeated scenery remain explicit quality debt. Existing failed art reviews and raw rejected outputs remain available. Every accepted FLAG requires the final independent review's individual reason.

Measured final public desktop proxy: 28.324 MiB/17.474 seconds, matching local/deployed PCK. Payload hypothesis passes; 12-second readiness hypothesis fails. Physical iPhone/Safari touch and cold/warm performance, plus three unfamiliar players, remain NOT-TESTED under the no-human-interaction instruction. No device approval or full-spec acceptance is inferred. APK and production audio remain deferred.

Same-step damage interruption was subsequently corrected in its own commit: incoming contact/projectile damage now resolves before any outgoing whip hit.64checks (eight old failures), main1,241assertions, continuous completion and12affected regressions pass; current PCK passes64damage/2,433atlas checks and browser smoke. The art files, authored motion timing and supplied independent-review images are unchanged.

## Complete independent art review r02

Fresh `/root/complete_review_r02`: REVIEW: PASS. Saved/read blind descriptions precede metadata. All five actor lineups, 68 main strips, 11 static lineups/36 static strips, 67 main onions, three attack composites, static onions/repeats, five style references and all 70 supplied integration images were inspected. All 68 source-reel entries ran at gameplay cadence; every frame index was observed, and temporal samples were inspected and retained. This includes the four restored supplemental boss hurt contexts.

All 34 main flags plus one terrain seam diagnostic were individually accepted with visual reasons in `art/review-complete-r02/accepted_flags.json`. Per-clip/asset decisions and complete methods are in `review_verdict.md`; playback harness, logs and 68 temporal sheets are retained. No failing frames or further art corrections were named. Scripted/reused methods and repeated scenery remain quality debt. The verdict approves supplied visual evidence only; it excludes gameplay, device/performance, audio, unfamiliar-player and whole-playthrough acceptance. Earlier r01 FAIL remains intact.
