# Boss death visibility

The boss inherited a generic one-second fade despite its twelve90ms authored death frames. At900ms the body was already at10% opacity, muting the collapse and final ash before the1080ms exit unlock. Preserve full source opacity through1080ms, then fade the held final frame during the existing120ms cleanup interval. The root, HP, collision, death clock and exit deadline remain unchanged.

Regression:136 checks across both facings, every90ms frame interval,1079/1080ms exit boundary and1140/1200/1201ms cleanup boundary. Before:30 failures; after:0. The exported PCK also passes136 checks. This fixture substitutes the approved idle texture into the missing death clip to exercise the production painted-body branch; it is NOT completion or approval of the death art. The12 source death frames are still pending independent review.

Additional gameplay and hazard checks, contract checks and25 defect self-tests are recorded under boss-death-visibility-*.log. The pushed export hash is boss-death-visibility-web.sha256.
