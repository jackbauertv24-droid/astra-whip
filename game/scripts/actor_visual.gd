class_name ActorVisual
extends AnimatedSprite2D
# Greybox clips use the same duration/count contract as production clips.
# Runtime art is deliberately absent until the art gates pass.
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
  for ms in spec.ms:
   var placeholder = PlaceholderTexture2D.new()
   placeholder.size = Vector2(1, 1)
   sprite_frames.add_frame(id, placeholder, maxf(1, float(ms)))
 visible = false
func follow(state: String, elapsed: float) -> void:
 var id = actor + "_" + state
 if not sprite_frames.has_animation(id): return
 played[id] = true
 if animation != id: play(id)
 var ms = elapsed * 1000.0
 var durations: Array = specs[id].ms
 var total = 0.0
 for d in durations: total += float(d)
 if specs[id].loop and total > 0: ms = fmod(ms, total)
 var index = 0
 while index < durations.size() - 1 and ms >= float(durations[index]):
  ms -= float(durations[index])
  index += 1
 set_frame_and_progress(index, clampf(ms / maxf(1.0, float(durations[index])), 0, 1))
