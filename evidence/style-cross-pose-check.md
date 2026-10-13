# Additional style cross-pose measurement

Measured with tools/lib/measure.mjs, contract ink threshold 40:

| Candidate | Height | Ink area | S | Head width |
|---|---:|---:|---:|---:|
| neutral r04 normalized | 224 | 12943 | 113.7673 | 38 |
| attack key r01 normalized | 224 | 18769 | 137 | 49 |

The attack's size/reference ratio is 1.2042, outside the production strike
0.92–1.08 band. Height alone concealed the drift. This candidate cannot seed
production animation unchanged, regardless of the style-only audit (which
includes only style_hero_neutral in the machine contract). Preserve it; regenerate
the pose against the neutral identity and anatomy, retaining the neutral head
size. Do not weaken the contract or stretch individual body parts.

Correction measurements (r05 neutral, r02 attack, 2026-10-13):
neutral H=224, S=115.139, head=39, foot=448;
attack H=206, S=121.223, head=40, foot=448.
Size ratio 1.0529 is inside the production strike band. Head width differs by
2.56%, inside the standing identity tolerance. Files and prompts are preserved.
