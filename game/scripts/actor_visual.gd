class_name ActorVisual
extends AnimatedSprite2D
# Preview art follows authoritative gameplay clocks; release debt is documented.
const WALK_CADENCE = 2.0
var actor: String
var specs: Dictionary
var played: Dictionary = {}
var weapon: Sprite2D
var weapon_frames: Array[Texture2D] = []
var hand_sockets: Array = []
var weapon_sets: Dictionary = {}
var socket_sets: Dictionary = {}
var approach_cadence = 1.0
var pivot_offset = Vector2.ZERO
func configure(kind: String) -> void:
 actor = kind
 var contract_data: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://data/art_contract.json"))
 specs = contract_data.clips
 var actor_spec: Dictionary = contract_data.actors[actor]
 pivot_offset = Vector2(float(actor_spec.canvas[0])*0.5-float(actor_spec.pivot[0]),float(actor_spec.canvas[1])*0.5-float(actor_spec.pivot[1]))
 if actor == "pursuer":
  var patrol_ms = 0.0
  var approach_ms = 0.0
  for value in specs.pursuer_patrol_walk.ms: patrol_ms += float(value)
  for value in specs.pursuer_approach_walk.ms: approach_ms += float(value)
  approach_cadence = approach_ms * Rules.PURSUER_APPROACH_SPEED / (patrol_ms * Rules.PURSUER_PATROL_SPEED)
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
   var path = "res://assets/" + actor + "/" + id + "/f%03d.png" % i
   var texture: Texture2D
   if ResourceLoader.exists(path):
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
 offset = pivot_offset
 if actor == "hero":
  weapon = Sprite2D.new()
  weapon.centered = false
  var shader = Shader.new()
  shader.code = "shader_type canvas_item; uniform vec2 hand_socket; void fragment(){ COLOR.a *= smoothstep(7.5, 8.5, distance(UV * vec2(768.0, 512.0), hand_socket)); }"
  var material_instance = ShaderMaterial.new()
  material_instance.shader = shader
  weapon.material = material_instance
  add_child(weapon)
  if FileAccess.file_exists("res://data/hand_sockets.json"):
   socket_sets = JSON.parse_string(FileAccess.get_file_as_string("res://data/hand_sockets.json"))
  for state in ["attack_ground", "attack_crouch", "attack_air"]:
   var textures: Array[Texture2D] = []
   for i in specs["hero_" + state].ms.size():
    var path = "res://assets/hero/whip_" + state + "/f%03d.png" % i
    if ResourceLoader.exists(path): textures.append(load(path))
   weapon_sets[state] = textures
 follow("idle", 0)
func has_weapon_layer(state: String) -> bool:
 return actor == "hero" and weapon_sets.has(state) and weapon_sets[state].size() == specs["hero_" + state].ms.size() and socket_sets.get("hero_" + state, []).size() == specs["hero_" + state].ms.size()
func playback_rate(state: String) -> float:
 if actor == "pursuer" and state == "approach_walk": return approach_cadence
 return WALK_CADENCE if actor == "hero" and state == "walk" else 1.0
func follow(state: String, elapsed: float) -> void:
 var id = actor + "_" + state
 if not sprite_frames.has_animation(id): return
 played[id] = true
 if animation != id: animation = id
 pause()
 if get_parent().get("facing") != null: flip_h = get_parent().facing < 0
 offset.x = -pivot_offset.x if flip_h else pivot_offset.x
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
 if weapon:
  weapon.visible = has_weapon_layer(state)
  if weapon.visible:
   weapon_frames.assign(weapon_sets[state])
   hand_sockets = socket_sets["hero_" + state]
   weapon.texture = weapon_frames[index]
   weapon.position = Vector2(256 if flip_h else -256, -448)
   weapon.scale = Vector2(-1 if flip_h else 1, 1)
   weapon.material.set_shader_parameter("hand_socket", Vector2(hand_sockets[index][0], hand_sockets[index][1]))
