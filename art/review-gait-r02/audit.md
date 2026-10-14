# Art audit

Contract 0.2.0; 2 clips audited; **1 DEFECT, 1 FLAG**.

DEFECTs block approval. Every FLAG must be adjudicated by the independent reviewer (ART_CONTRACT §9).

| Rule | Severity | Count |
|---|---|---:|
| A-07 | DEFECT | 1 |
| A-11 | FLAG | 1 |

## Findings

- **A-07 DEFECT** `hero_walk` f004: no lower body: boot ratio 0.68 > 0.6 and leg dip 0.55 > 0.5 (figure cut off above the legs?)
- **A-11 FLAG** `hero_walk` f002: jump from frame 1: size 6.1%, height 1.8%
