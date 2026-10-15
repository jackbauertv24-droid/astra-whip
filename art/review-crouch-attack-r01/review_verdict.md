# Independent crouched attack review

Scope: `hero_attack_crouch`, `whip_attack_crouch`, `style_hero_neutral` only. Reviewer did not produce or alter the art. Blind observations were saved before documents/metadata were read. The pack moved from `review-crouch-r01` to `review-crouch-attack-r01` during review; its image contents were unchanged. Historical reports were not inspected.

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| hero_attack_crouch | PASS | — | Complete bent body, stable hunter identity, same visible weapon arm throughout anticipation, extension and recovery. The A-11 flag is accepted below. | None required. |
| whip_attack_crouch | PASS | — | Continuous thin leather line, registered glove grip, active low reach, ordered recovery and compact final coil. | None required. |
| style_hero_neutral | PASS | — | Complete standing hunter from head to boots at the design height; matches the registered reference and crouched identity. | None required. |

## Identity and anatomy

Every body frame contains head, torso, folded hips/knees and booted lower legs; no torso-only substitute, squashed body, clipping, stray rectangle or debris is visible. The neutral reaches the blue guide and the crouched bodies reach the yellow guide by folding their legs. Head/face size and hair identity remain recognisable beside the standing reference. Linen sleeves, mantle, brown leather vest, belt, long skirt panels, bracers and boots remain consistent. All source frames face right. The raised knee and grounded trailing boot give the attack a planted low base; it does not rise into a standing strike. The separate crouch reference confirms the low stance, and the weapon-arm reference confirms the same near arm extending across the chest.

## Every adjacent pair and timing

- 0→1: the near weapon arm swings from low hip to a bent rear wind-up while the other hand stays on the raised knee; recognisable deliberate anticipation. The large excursion is reasonable over the two 75 ms anticipation tiles.
- 1→2: the same sleeve and shoulder extend forward. This is the fastest and largest arm/weapon change, but it reads as the committed snap into the active phase rather than an arm switch or body teleport.
- 2→3: a small downward follow-through and slightly greater whip extension preserve the active silhouette. Two distinct tiles sustain the 100 ms active phase without resetting the attack.
- 3→4: the elbow folds back over the raised knee; the chest/mantle turn back with it, and the extended whip rolls into a broad forward gathering loop. It is a brisk release after the strike, with the planted body remaining legible.
- 4→5: the hand draws inward and the broad loop becomes a smaller forward curl; the knee/boot base remains stable.
- 5→6: the weapon hand lowers behind the thigh and the loop gathers beside it. This is the second conspicuous weapon contraction, but its direction and the preceding curl make the gather readable.
- 6→7: a short settling hand movement and compact coil return to the ready pose. Reusing the ready endpoint reads as completion rather than padding a living loop.

Durations are 75/75/50/50/62.5/62.5/62.5/62.5 ms, total 500 ms. The action has clear anticipation, active extension and progressively quieter recovery. The ordered stills/onions and timestamped engine samples support this timing assessment; the evidence is a frame sequence, not a continuous video.

## Grip, reach and weapon shape

All eight native weapon images and all eight composites were opened. Cyan sockets coincide with the glove grip in every composite; the painted glove remains in front of the central handle rather than being crossed by a loose line. There is no second free handle or floating root. The line is braided brown leather with a visibly thinner tip, and it stays above the floor even during the low recovery. Active frames 2–3 cross the yellow low hitbox and extend beyond its far edge. Rest tiles 0 and 7 show a small coil next to the hip, far smaller than the hero. Forward distance increases through anticipation/extension and decreases through recovery; the roll into a loop makes the shortened reach read as gathering flexible material.

The native raster fallback remains somewhat cleaner and more regular than the painted body, but does not read as an energy beam, thick rope or unrelated weapon. This is acceptable within the declared scripted-fallback method, which remains known quality debt under §11.

## Audit FLAG adjudication

Production audit: 0 DEFECT, 1 FLAG. Supplemental strict audit (10 px root / 4 px tip) likewise has 0 DEFECT and the same single FLAG; this does not amend the production contract.

Accepted **A-11 hero_attack_crouch f004, from f003: size 7.6%, height 1.4%**. The onion shows the extended sleeve/arm folding across the torso and overlapping the raised knee while the mantle closes back. Head and boots keep their scale and the foot line stays fixed. The ink-area loss is accounted for by limb overlap and the narrower returned silhouette; it does not look like whole-body shrinking. No other flags were present in either audit JSON or Markdown report.

## Derivations and engine evidence

The declared reused body keys read as one ordered crouched action, including the reused ready endpoint. The declared scripted weapon fallback reads as a synchronized flexible whip. Other derivations listed by the broad index are outside this three-clip scope and are not approved here.

Opened every native snapshot (8 body, 8 weapon, 1 neutral), both onions, the composite, both additional identity references and all five style-lock reference images. Opened every engine capture: 16 at 1280×720 in `evidence/crouch-attack-engine-r01` and 16 at 698×393 in `evidence/crouch-attack-phone-r01`, eight per facing in each. Both capture logs end PASS. Both capture.json files record `attack_crouch`, 500 ms duration, active frames 2–3 and zero maximum mirrored socket error against tolerance 0.001. At phone size the planted low silhouette and raised/extended/returned arm phases remain readable; the thin whip loses some fine braid detail but its active line and recovery curl remain visible. Mirroring preserves attachment and anatomy. No scoped clip is missing evidence.

REVIEW: PASS
