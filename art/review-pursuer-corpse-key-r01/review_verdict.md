# Independent static key review

Reviewed by fresh agent `/root/pursuer_corpse_key_review_r01` under ART_CONTRACT §9 for D23 source-key approval. Scope: `f000.png` only. Blind observations were successfully saved to `blind_observations.md` before opening `key.json`, contracts, briefs, or references. No production files were edited.

## References and intended pose

Read `key.json`, `docs/ART_CONTRACT.md`, `docs/ART_BIBLE.md`, the pursuer brief in `docs/ASSET_BRIEFS.md`, and `art/style-lock.json`; visually inspected all five registered style references plus supplied `style-reference.png` and `low-reference.png`.

Intention: a complete, grounded, limp pursuer after collapse and before ash, with skull/cheek and chest down, hips fallen and four limbs plausibly folded or splayed.

## Visual verdict

**PASS for the static key.** The long low silhouette reads as a fallen body. The cheek/head is at ground level on the right, the chest has settled, and neither the hips nor the folded limbs hold the torso in a supported crouch. The heavy downward head fibers, flattened trunk, and limbs spread along the floor support the intended limp rest.

The creature retains the locked pursuer identity: elongated low head and hanging rag fibers, olive hide, gaunt pale jointed limbs, clawed extremities, and a layered angular back. It remains an unnatural quadruped rather than a dog or pet. All four limbs are represented: the far-left splayed extremity, the folded left-side limb ending near the lower left-middle, the small overlapping far-side extremity through the lower middle, and the large folded near forelimb ending at lower right. Their roots overlap within the collapsed torso, but no limb looks amputated or replaced by loose fragments. The two main folded joint structures have credible continuous bends. The tucked far-side foot is less prominent, which is plausible occlusion in this pose and is not a missing-limb defect.

Physical mass remains consistent with the supplied low reference: pale limb thickness, large joint size, and head mass do not read as a reduced copy. The wider footprint comes from the horizontal head, collapsed trunk and splayed/folded limbs. Painted matte detail, restrained olive/bone values, and illumination remain compatible with the style lock. No wounds, blood, exposed organs, dismemberment, or graphic gore are visible.

## Measured static checks

Measurements made directly from PNG pixels at alpha ≥40 using the repository PNG decoder:

| Image | Canvas | Ink bounding box (inclusive) | Ink area | S |
|---|---|---|---:|---:|
| Key | 320×256 | (30,152)–(304,224) | 10,636 | 103.131 |
| Supplied style reference | 320×256 | (86,70)–(224,224) | 9,141 | 95.609 |
| Supplied low reference | 320×256 | (88,113)–(277,224) | 10,451 | 102.230 |

Key S is 1.079× the style reference and 1.009× the low reference. The 73 px collapsed height is credible bending and settling, with preserved mass. The canvas matches the brief; the lowest ink row is exactly ground/pivot y=224. The declared pivot is (128,224), as required. Source faces right. All four corner alphas are zero, there are no visible-alpha exact magenta pixels, and all ink is one connected component: no detached debris. The figure has at least 15 px right margin and 30 px left margin, so there is no edge clipping. Visual edge inspection shows fine organic tips without an opaque rectangle, colored extraction halo, or obvious cut-off edges.

## Corrections and limits

No blocking static flaws found; no correction required. This approves only this static source key for subsequent derivation. It does not approve motion, animation, timing, a collapse transition, ash behavior, production inventory, or any derived frame. Those require their own review.

STATIC KEY REVIEW: PASS
