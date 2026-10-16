# Independent ranged idle review — replacement session r02

Reviewer: fresh independent agent `/root/ranged_idle_review_r02`, 2026-10-15. This replaces a prior reviewer session interrupted without a verdict. I did not read its blind observations, any prior review verdicts, or builder notes. No builder verdict was supplied. I did not generate or edit the art.

Blind observations were saved in `blind_observations_r02.md` for the lineup tile and every strip tile before reading index, audit, intent, contracts or references. I then inspected the onion sheet (all six pairs including F5→F0), all six individual native PNG frames, the source identity key and its normalization record, all five registered style-lock image references, pack metadata/derivations, and `tools/prepare-ranged-idle.mjs`. Authorities consulted: `docs/ART_CONTRACT.md`, `docs/ART_BIBLE.md`, `docs/ASSET_BRIEFS.md`, `contract/art_contract.json`, and `prompts/ART_REVIEW.md`.

| Clip | Result | Failing frames | Defect | Smallest correction |
|---|---|---|---|---|
| `ranged_idle` | PASS | None | None found in the scoped idle | None required |

The figure remains the same full-length, right-facing hooded rooted creature in F0–F5: the shadowed face, thin exposed pale arm, drooping fingers, post, ragged olive layers and broad grounded base keep their proportions and construction. Its painted matte material and pallid/decay colors fit the five style-lock references. Concealment and decay remain within the bible's dread/no-gore treatment. There is no stretched torso, cropped hood, detached limb, debris, hard background rectangle, or visible anatomy/scale swap. A robe-to-ground actor is the declared anatomy here; a missing separate pair of legs is not a defect.

Motion is quiet but connected. F0→F1 and F1→F2 ease the hanging arm outward with a small chest/hood lift; F2→F3 completes the breath as the arm starts returning; F3→F4 and F4→F5 settle it with a small counter-sway in cloth; F5→F0 closes with an equally small return. Every onion pair reads as one supported body, with no displaced shoulder connection, hand teleport, costume replacement, or global size pulse. The post and stone footing remain registered throughout. The six-frame cycle reads as subtle breathing and arm/cloth response appropriate to a stationary threat, and does not require an aiming gesture during idle.

The D23 derivation is explicitly recorded as `scripted_fallback` from `ranged-identity-r02/key.png`: localized chest expansion/lift, hood lift, elbow/wrist sway and cloth response. Its resulting action passes the idle intent; the method itself is not the basis for approval. The source's one bounded uniform normalization is 1.016949 from pivot (128,322) to (128,320), targeting 300 px height, with no debris removed. The animation script introduces no whole-body scaling/translation or per-frame normalization. This remains disclosed scripted-animation quality debt.

I opened both `evidence/ranged-idle-native/capture.json` and `evidence/ranged-idle-phone/capture.json`, and every PNG in each folder: F0–F5, wrap F0, and outgoing aim preview in both right and left facings (16 PNGs per folder). Native captures are 1280×720; phone metadata reports viewport 852×393 with the scene fitted into the delivered phone images. In both sets the full rooted silhouette and pale arm separate from the dark masonry, the base sits on the platform, and mirrored hood/arm/post construction remains plausible. Phone-size motion is necessarily restrained, but the figure and facing remain readable without zoom; it neither disappears into the pillar nor changes registration at wrap.

The manifests specify six 150 ms frames and `loop: true`, totaling 900 ms. Both engine capture records show idle frames advancing at approximately 0, 150, 300, 450, 600 and 758 ms, then wrapping to F0 at approximately 908 ms; the small sampling offset is consistent with capture tick granularity. All samples keep the production 2 HP actor at (4608,432). These records support the actual 900 ms loop and fixed root in both facings, rather than a static presentation of six source files.

Audit adjudication: `audit.md` and `audit.json` report 0 DEFECT and 0 FLAG, with an empty findings array. There are no flags to accept or reject. All six reported ink heights are 300 px and foot lines are 320; the visual checks above independently cover continuity, identity, intent and scene readability.

Approval is strictly for `ranged_idle`. The outgoing aim previews were inspected and visibly switch to placeholder art; `outgoing_art_approved: false` correctly marks them as unapproved and outside this verdict. This does not approve that handoff's finished art, remaining ranged clips, the 63 clips absent from this scoped pack, physical-device testing (`physical_device: false` in both records), or full-project/release gates. No attack/composite or effect acceptance is applicable to this idle-only pack.

REVIEW: PASS
