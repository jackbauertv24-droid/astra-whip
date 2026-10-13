# Art audit

Contract 0.2.0; 1 clips audited; **4 DEFECT, 0 FLAG**.

DEFECTs block approval. Every FLAG must be adjudicated by the independent reviewer (ART_CONTRACT §9).

| Rule | Severity | Count |
|---|---|---:|
| A-05 | DEFECT | 2 |
| A-08 | DEFECT | 1 |
| A-09 | DEFECT | 1 |

## Findings

- **A-05 DEFECT** `style_hero_neutral`: reference height 275.0 outside 217.3–230.7: every size check for hero is anchored on this clip
- **A-08 DEFECT** `style_hero_neutral`: reference head width 55.0 px = 0.246 × design height, outside 0.14–0.2
- **A-05 DEFECT** `style_hero_neutral` f000: height 275 px outside stand band 217.3–230.7
- **A-09 DEFECT** `style_hero_neutral` f000: ink 41 px below the pivot line
