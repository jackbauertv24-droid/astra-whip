# Independent review — ranged idle / aim r02

Blind observations were saved first in `blind_observations.md`, after opening the lineup and both strips and before reading intent, audit, index or contracts. I did not read previous reviewer outputs or builder notes. This verdict covers only the two delivered clips and the aim handoff/socket, not outgoing fire or projectile artwork.

| Clip | Verdict | Failing frames | Finding | Smallest correction |
|---|---|---|---|---|
| ranged_idle | PASS | — | Complete rooted hooded figure, one visible bare arm, coherent subtle breathing/sway and a small loop seam. | None. |
| ranged_aim | FAIL | Entry into f000 from idle; fixed-region repaint persists f000–f005 | The forearm action itself works, but entry switches the stationary hood, robe and rooted stone base to a visibly brighter, differently outlined painting. The grounded base widens and its carving/root pattern changes although these parts are supposed to remain fixed. | Preserve the idle source's fixed hood/post/robe/base pixels and composite the corrected locally articulated arm and charge over that identity. Blend the shoulder attachment locally if needed; do not resize the actor. |

## Identity, anatomy and size

Every frame has the complete hood-to-root figure. The absence of separate legs is appropriate to the declared legless, ground-length rooted robe; this is not a torso cutoff. Both sources and both clips are recognisably the same enemy, with the same concealed face, leaf-cloth construction, post, long pale arm and slab. All source frames face right. The one exposed arm remains connected at shoulder and elbow; I see no duplicate limb, residual hand, warm effect remnant, severed fingers, rectangle backing or clipped silhouette.

All twelve frames are 300 source pixels high with the lowest ink at y320. There is no whole-actor shrinking or growing during either clip. Aim's increasing width comes from the extending forearm and growing charge. Within aim, hood/post/base are stationary: comparison against f000 finds zero changed pixels in y<90, x<110, or y>270 for all later aim frames.

The cross-clip entry nevertheless changes the stationary painting. Idle's figure bbox is x69–196; aim f000 is x69–203, and its hood width changes from71 to75. In the base band y270–320, idle f000 versus aim f000 has503 pixels that change ink membership (alpha threshold40); the hood band y21–89 has446. This is not just a charge-light change: root/slab contours and internal carving are redrawn. The lineup, native frame composites and the captured before-idle→aim pair show the accompanying brightness/leaf-detail step. The audit size tolerance permits these differences, but it does not establish continuity of a fixed rooted construction. This is the blocking defect.

## Motion and charge

Inspected all twelve individual native frame PNGs through lossless original-size, correctly alpha-composited contact sheets, plus both supplied onions. Idle pairs0→1,1→2,2→3,3→4,4→5 and5→0 show small coherent motion without a limb jump or scale change. Aim pairs0→1,1→2,2→3,3→4 and4→5 form a readable continuous forearm lift: the last pair holds the arm while the charge finishes growing. There is no aim loop seam because it is nonlooping.

The green cue stays with the moving fingers, grows across all six frames, and resolves into a hollow four-point diamond rather than a sphere. Early frames have soft wisps and a very small incomplete angular shape, which is acceptable as gathering energy; by the latter half the shape is explicit. It never gains a hard rectangular boundary. No fade is required inside this charge-up clip: it should build to the outgoing shot. Finger/halo occlusion is credible, including the low forearm passing in front of the robe. The arm action and halo growth pass independently of the entry defect.

## Engine evidence and socket

Inspected all16 PNG captures in each of `evidence/ranged-aim-native` and `evidence/ranged-aim-phone`: both before-idles, frames00–05 in each facing, and both outgoing fire-f00 captures. Used lossless contextual crops retaining the whole actor at the capture's original pixel size; also opened a complete phone gameplay capture. Both capture.json files were read. Native viewport is1280×720; phone viewport is852×393. Neither is a physical-device capture.

Both facings retain a planted base at world(4608,432). The exposed pale arm separates from the foliage and the final diamond reads in both directions at both sizes. At phone size the initial glimmer is slight, but the progressive arm silhouette plus the later diamond provides a readable warning across the captured approximately0.908-second aim. The fixed-body repaint at idle entry remains visible as a brighter, more sharply defined robe; it is less pronounced on phone but does not disappear.

Socket calculation: source(208,155) minus pivot(128,320) gives(80,−165)px, or(40,−82.5)u at2px/u. From root(4608,432), predicted birth is(4648,349.5) facing right and(4568,349.5) facing left. Both capture records report exactly these positions at fire elapsed0.05/frame1. Aim ends with its charge center at source(208,155), so the aim endpoint and projectile birth lane match. The fire-f00 screenshots contain placeholder body graphics: their appearance is explicitly outside this review and is not accepted here. This evidence establishes the endpoint/socket handoff, not a finished artistic fire transition.

## D23 method, style and audit disposition

Read `tools/prepare-ranged-aim.mjs`, `art/production-candidates/ranged-aim-r02/derivation.json`, pack index/manifest, ART_CONTRACT, ART_BIBLE, relevant ASSET_BRIEFS and machine contract. The derivation honestly declares scripted fallback, source, method and reason. It rotates/blends the local forearm about(143,130), adds a rigid foreground forearm layer for robe occlusion, and separately scales extracted painted charge0.25→1 about the moving hand. The declared angles55,40,25,12,0,0 agree with the observed lift. This is effect growth, not actor resizing. There is no global actor scale or per-frame recentering in the script. The technique is acceptable under D23, but deriving the full fixed body from the separate aim painting causes the entry defect above. Scripted-animation quality debt must remain disclosed.

Opened all five `art/style-lock.json` reference images, and both supplied ranged source keys, with sprites composited over neutral grey using alpha. Matte painted rendering, muted decayed cloth, pale flesh, stone and gothic concealment fit the style family. No gore, franchise emblem or unrelated visual treatment is apparent.

Audit disposition: `audit.md` and `audit.json` report0 DEFECT and0 FLAG for2 clips; findings list is empty. There are therefore no automated flags to accept or reject. The independent entry-continuity failure is additional to that clean audit. Missing unrelated clips in the pack index are outside this two-clip review.

## Limitations and access

All required image and document assets were accessible. Python executables were unavailable; a Node PNG helper produced lossless review composites instead, without changing any source art. No art edits were made. Motion was evaluated through every native frame, onions and timed capture sequence rather than physical-device playback. The engine evidence does not approve outgoing placeholder art, projectile appearance, later recover/hurt/death clips, or a full release. No prior verdict was opened to justify this result.

REVIEW: FAIL (1 clips)

Capture archive note: reviewed r02 captures were subsequently preserved unchanged as evidence/ranged-aim-r02-native and evidence/ranged-aim-r02-phone. The unsuffixed folders now hold the next candidate.
