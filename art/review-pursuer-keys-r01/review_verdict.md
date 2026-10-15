# STATIC KEY REVIEW

Reviewer: /root/pursuer_pose_keys_r01; 2026-10-15. Independent of image creation and processing.

**Result: PASS for all eight isolated candidate source keys. Animation/motion has not been approved.** This is not gait, clip, production-inventory, or release acceptance. No timings or clip metadata were supplied or inferred.

The blind observations were saved in `blind_observations.md` before reading documentation. Reviewed `docs/ART_CONTRACT.md`, `docs/ART_BIBLE.md`, `art/style-lock.json`, supplied `style-reference.png`, and the registered `art/candidates/style_enemy_pursuer.png`. No other review directories or builder notes were inspected.

Each isolated key retains the reference's small angular draped head, gaunt shoulder/hip masses, long clawed forelimbs, folded hindlimbs, pallid matte flesh and ragged olive cloth-like hide. The low body comes from articulation rather than visibly shortening the limbs. All show a complete coherent four-limbed wrong creature, facing right, without a dog/pet read, exposed wounds, gore, baked floor shadow, or clipped extremity. Shaded ribs and muscles read as intact skin. The reference's rear-up posture is an identity reference, not a required pose for these low keys.

| Key | Verdict | Isolated anatomy and identity finding | Exact blocking defect / smallest fix |
|---|---|---|---|
| f000 | PASS | Two rear chains and two front chains remain readable; planted rear foot and downward near forearm are coherent. Head, hide and limb proportions match reference identity. | None; no fix required. |
| f001 | PASS | Folded hind leg beneath hip is distinguishable from backward supporting leg; both forearms connect plausibly beneath shoulders. | None; no fix required. |
| f002 | PASS | Extended rear chain, folded opposite hind leg, supporting far forearm and reaching near forearm form four plausible limbs. | None; no fix required. |
| f003 | PASS | Long forward forearm has a readable elbow/wrist chain; opposite arm hangs separately beneath shoulder; both rear chains remain complete. | None; no fix required. |
| f004 | PASS | Lower head and folded rear leg remain consistent with the reference creature; hanging far hand and forward near hand are distinct. | None; no fix required. |
| f005 | PASS | Tightly folded raised hind limb still has a readable thigh, shin and hanging foot; opposite hind leg and both front chains are coherent. | None; no fix required. |
| f006 | PASS | Backward hind limb and tucked opposite limb remain recognizable; front hands overlap slightly but remain two coherent attached chains. | None; no fix required. |
| f007 | PASS | Raised rear foot hangs from a plausible bent rear chain; opposite foot lies beneath belly; front limbs preserve shoulder/elbow/wrist anatomy. | None; no fix required. |

Measured directly from delivered PNGs using alpha >=40, independently of builder summaries:

| Key | Canvas | Ink bounds (inclusive) | Ink height | Lowest ink row |
|---|---|---|---|---|
| f000 | 320×256 | 69,113–277,224 | 112 px | 224 |
| f001 | 320×256 | 68,114–270,224 | 111 px | 224 |
| f002 | 320×256 | 61,113–261,224 | 112 px | 224 |
| f003 | 320×256 | 63,113–281,224 | 112 px | 224 |
| f004 | 320×256 | 78,113–276,224 | 112 px | 224 |
| f005 | 320×256 | 93,113–278,224 | 112 px | 224 |
| f006 | 320×256 | 64,113–266,223 | 111 px | 223 |
| f007 | 320×256 | 69,113–271,224 | 112 px | 224 |

All eight have transparent corners, no nontransparent pixels in the two-pixel canvas border, no visible magenta contamination, and exactly one 8-connected ink component: no detached debris. Alpha edges look clean in the viewed source images. The low 112 px envelope is met to one pixel, and foot lines are within the contract ±2 px of y=224. Figures are placed compatibly with the requested ground pivot (128,224); a PNG itself does not encode runtime pivot metadata, so runtime registration is not certified by this review.

**STATIC KEY REVIEW ONLY. Animation/motion, timing, gait, adjacent-frame continuity, loop seams, state coverage and production inventory remain unapproved.**
