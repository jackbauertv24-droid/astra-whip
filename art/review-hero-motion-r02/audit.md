# Art audit

Contract 0.2.0; 19 clips audited; **2 DEFECT, 12 FLAG**.

DEFECTs block approval. Every FLAG must be adjudicated by the independent reviewer (ART_CONTRACT §9).

| Rule | Severity | Count |
|---|---|---:|
| A-05 | DEFECT | 1 |
| A-08 | DEFECT | 1 |
| A-08 | FLAG | 4 |
| A-11 | FLAG | 8 |

## Findings

- **A-08 FLAG** `hero_walk` f006: head width 1.077 × standing reference (±0.05): single frame, reviewer adjudicates
- **A-05 DEFECT** `hero_stop_move` f001: height 190 px outside stride band 210.6–230.7
- **A-11 FLAG** `hero_stop_move` f001: jump from frame 0: size 6.4%, height 14.4%
- **A-11 FLAG** `hero_stop_move` f002: jump from frame 1: size 6.3%, height 17.9%
- **A-08 DEFECT** `hero_turn` f001: head width 1.154 × standing reference (±0.05): body parts changed size
- **A-08 FLAG** `hero_crouch_enter` f002: head width 1.077 × standing reference (±0.05): single frame, reviewer adjudicates
- **A-11 FLAG** `hero_crouch_enter` f002: jump from frame 1: size 8.8%, height 17.9%
- **A-08 FLAG** `hero_crouch_exit` f001: head width 1.077 × standing reference (±0.05): single frame, reviewer adjudicates
- **A-11 FLAG** `hero_crouch_exit` f002: jump from frame 1: size 9.6%, height 21.8%
- **A-11 FLAG** `hero_crouch_exit` f003: jump from frame 2: size 6.3%, height 17.9%
- **A-08 FLAG** `hero_land` f000: head width 1.103 × standing reference (±0.05): single frame, reviewer adjudicates
- **A-11 FLAG** `hero_knockdown` f001: jump from frame 0: size 6.3%, height 25.9%
- **A-11 FLAG** `hero_death` f001: jump from frame 0: size 6.3%, height 25.9%
- **A-11 FLAG** `hero_death` f005: jump from frame 4: size 6.6%, height 32.4%
