# Independent pursuer action review r01

Scope: three new action clips. Patrol and approach are unchanged calibration and handoff references. The other 59 inventory clips are outside this review. Blind observations were written and verified as a 3480-byte file before reading the contract, clip metadata, index or audit. No earlier verdict or builder notes were consulted.

| Clip | Verdict | Failing frames/transitions | Finding | Smallest correction |
|---|---|---|---|---|
| pursuer_lunge_windup | PASS | — | Complete same-size creature compresses by articulated hips, knees and elbows, with grounded rear/near-front support; four poses make a readable350ms tell. | None. |
| pursuer_lunge | FAIL | F2 → pursuer_recovery F0 | The far forepaw is explicitly planted at local(176.8,224) in both frames, while the root advances another19.50u between the sampled F2 and recovery entry. It therefore finishes the lunge by dragging the same planted paw forward about39source px; the supported stance path stops one interval early. | Compensate the final interval at the handoff, or visibly release this paw into a short airborne finish and land another paw at recovery entry. Preserve body proportions and the existing earlier stance compensation. |
| pursuer_recovery | PASS | — | The four recovery poses replant, unfold the knees/elbows and rise into the approach entry without scaling or identity change. The incoming lunge contact defect is assigned to lunge above. | None within recovery; coordinate any changed incoming contact with its F0. |

## Evidence and observations

Opened the lineup and all five strips, then all five onion sheets. Opened every native new frame separately: windupF0–F3, lungeF0–F2 and recoveryF0–F3. All retain the long hanging head, olive ragged dorsal layers, pale articulated limbs and full four-limb anatomy. No missing torso/feet, costume swap, detached debris, clipped silhouette or hard background rectangle was visible. Sources face right. Both mirrored capture sets preserve anatomy and physical size. The five style-lock reference images were opened; the creature retains the reference's gaunt horror identity and illustrated rendering.

Every adjacent onion pair was inspected, including both calibration loop seams. The windup lowers the chest by bending rather than shrinking. The lungeF0→F1 extension andF1→F2 tuck remain recognizably one body, and recoveryF0→F1→F2→F3 unfolds the limbs. No limb teleport or size pop was found. WindupF3→lungeF0 visibly reaches the far forelimb forward to land; lungeF2→recoveryF0 preserves the body pose and lowers other paws; recoveryF3→approachF0 matches the tall gait entry. Approach poses were compared with windup entry; both share the same body and scale, with a brief gait-to-tell change rather than a redraw.

The moving-root evidence exposes a defect the local onions do not: far-forepaw coordinates are260,218.4,176.8source px over lungeF0/F1/F2. At the captured root positions1050.8334,1072.4996,1094.1659u, the corresponding world contact positions are1116.8334,1117.6996,1118.5659u. Those first two differences are small sampling offsets. Recovery begins at root1113.6655u with that paw still176.8source px: world contact1138.0655u, an additional19.4996u forward. Left-facing evidence mirrors the same problem. The last frame is held while translation continues, then the same supporting paw remains on the ground at recovery entry. This is skating at the terminal support transition, not an anatomy/scale failure.

Both capture logs ended PASS before inspection. Inspected all48captures through unchanged-scale crop sheets saved alongside this report: engine/phone × right/left,12tiles each. Tile order is windupF0–F3, lungeF0–F2, recoveryF0–F3, approachF0. The crops retain complete creatures and ground contacts; left sheets were recropped after the first crop range excluded part of the leftward travel. Full engine and phone screenshots were also opened for context. The amber compressed tell remains visible at phone size; the lower travelling silhouette and subsequent rise remain distinguishable. The terminal support drift exists in both sizes and facings.

Read capture metadata for both display runs and the actual-AI capture harness. It triggers windup by placing the hunter inside range during approach simulation, then advances the state machine; it does not force-select each action frame. Both facings record350ms windup,241.667ms lunge,600ms recovery and260u/s. Actual recorded lunge displacement is62.832/62.833u, within one120Hz simulation step of the62.4u target. The logs'62.4u wording is the target, not the exact recorded displacement.

Read the art contract, art bible, animation spec, relevant pursuer briefs/gameplay rules, machine contract, clips/derivations metadata and rig contact records. Counts, timings and nonloop flags agree for the new clips. Scripted cutout derivations are declared; the articulated joint motion itself reads as intentional compression/extension/recovery rather than a static picture being translated. The terminal planted contact still fails the animation spec's rejection of skating feet and the requested actual moving-root support criterion.

## Audit findings

The supplied audit reports0DEFECT and0FLAG over the five included clips. There are no FLAGs to accept. Whip composites and effects are not applicable to these creature clips. Patrol and approach remain reference clips; this review does not supersede their prior acceptance.

REVIEW: FAIL (1 clips)
