class_name ActorVisual
extends AnimatedSprite2D
# Preview art follows authoritative gameplay clocks; release debt is documented.
const WALK_CADENCE = 2.0
var actor: String
var specs: Dictionary
var played: Dictionary = {}
func configure(kind: String) -> void:
 actor = kind
 specs = JSON.parse_string(FileAccess.get_file_as_string("res://data/art_contract.json"))["clips"]
 sprite_frames = SpriteFrames.new()
 sprite_frames.remove_animation("default")
 for id in specs:
  if not id.begins_with(actor + "_"): continue
  if Rules.mutation("T-09") and id == "hero_crouch_enter": continue
  var spec: Dictionary = specs[id]
  sprite_frames.add_animation(id)
  sprite_frames.set_animation_loop(id, spec.loop)
  sprite_frames.set_animation_speed(id, 1000)
  for i in spec.ms.size():
   var ms = spec.ms[i]
   var path = "res://assets/hero/" + id + "/f%03d.png" % i
   var texture: Texture2D
   if actor == "hero" and ResourceLoader.exists(path):
    texture = load(path)
   elif actor == "hero" and id == "hero_attack_ground":
    var keys = ["rest","windup","strike","strike","follow","follow","rest","rest"]
    texture = load("res://assets/hero/attack_" + keys[i] + ".png")
   elif actor == "hero" and id == "hero_attack_crouch":
    texture = load("res://assets/hero/hero_crouch_idle/f000.png")
   elif actor == "hero" and id == "hero_attack_air":
    texture = load("res://assets/hero/hero_jump_rise/f000.png")
   elif actor == "hero":
    texture = load("res://assets/hero/neutral.png")
   elif actor == "pursuer":
    texture = load("res://assets/style/pursuer.png")
   var placeholder = PlaceholderTexture2D.new()
   placeholder.size = Vector2(1, 1)
   sprite_frames.add_frame(id, texture if texture else placeholder, maxf(1, float(ms)))
 visible = actor in ["hero", "pursuer"]
 scale = Vector2(0.5, 0.5)
 offset = Vector2(0, -192) if actor == "hero" else Vector2(32, -96)
 follow("idle", 0)
func playback_rate(state: String) -> float:
 return WALK_CADENCE if actor == "hero" and state == "walk" else 1.0
func follow(state: String, elapsed: float) -> void:
 var id = actor + "_" + state
 if not sprite_frames.has_animation(id): return
 played[id] = true
 if animation != id: animation = id
 pause()
 if get_parent().get("facing") != null: flip_h = get_parent().facing < 0
 var ms = elapsed * 1000.0 * playback_rate(state)
 var durations: Array = specs[id].ms
 var total = 0.0
 for d in durations: total += float(d)
 if specs[id].loop and total > 0: ms = fmod(ms, total)
 var index = 0
 while index < durations.size() - 1 and ms >= float(durations[index]):
  ms -= float(durations[index])
  index += 1
 set_frame_and_progress(index, clampf(ms / maxf(1.0, float(durations[index])), 0, 1))
