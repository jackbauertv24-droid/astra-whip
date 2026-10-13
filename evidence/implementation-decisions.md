# Implementation decisions

- Build title and repository: Astra Whip, directly requested by the user.
- Original upstream spec is pinned in README; copied documents are reference
  material. Runtime code lives only in this separate implementation repository.
- Use Godot 4.7.2-stable official, release hash ed1daf0bf; 120 Hz physics reduces
  discretization error without changing any of the specified movement constants.
- Stage ground is y=560; the specification's row coordinates map directly to it.
  All 104 modules and all encounter bounds are authored in scripts/stage.gd.
- Bridge modules 9–13, walkway modules 45–47/49–52/54–56, the recovery tread at 55,
  and elevated treads/platform at 70–73 are explicitly one-way thin surfaces.
  They preserve the intended recovery routes and avoid the documented low-ceiling
  crouch trap. Ground and ascent blocks remain solid. Clearance ignores one-way
  surfaces, independently of physical landing collision.
- Ranged fire retains the specified 200 ms fire clip in addition to 900 ms aim
  and 700 ms recovery; the prose's 1600 ms cycle omits that clip. The authoritative
  clip inventory is followed (1800 ms full cycle).
- Swooper patrol speed is 65 u/s (unspecified by the spec); altitude, dive speed,
  and animation phase durations retain the supplied values.
- Boss alternates close strikes and hazards, with a hazard fallback when out of
  close range for two seconds. The zone tracks until the frame-7 lock event.
- Audio assets are explicitly deferred in ASSET_BRIEFS section 12. Music and SFX
  buses/volume controls are present; no borrowed or purportedly generated audio.
- Greybox frames are explicitly PlaceholderTexture2D resources. Their inventory,
  timing and selection can be tested before artwork exists. This does not satisfy
  art, visual animation quality, or mobile performance acceptance.
- No physical iPhone or unfamiliar-player study is available in this environment.
  Those validation gates will remain PENDING and are not replaced by headless tests.
