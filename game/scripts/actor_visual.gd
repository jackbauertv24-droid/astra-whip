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
var body_clips: Dictionary = {}
var pivot_offset = Vector2.ZERO
func preserve_death_entry() -> void:
 # Keep the exact lethal-contact paint for the first authored90ms. The next
 # loading frame then carries standing or supported entry into the same fall.
 if actor!="boss" or not body_clips.get("boss_death",false): return
 if not body_clips.get(str(animation),false): return
 var entry=sprite_frames.get_frame_texture(animation,frame)
 sprite_frames.set_frame("boss_death",0,entry,90)
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
  var delivered = 0
  for i in spec.ms.size():
   var ms = spec.ms[i]
   var path = "res://assets/" + actor + "/" + id + "/f%03d.png" % i
   var texture: Texture2D
   if PackedArt.exists(path):
    texture = PackedArt.texture(path)
    if texture != null: delivered += 1
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
  body_clips[id] = delivered == spec.ms.size()
 if actor == "boss" and FileAccess.file_exists("res://data/boss_hurt_contexts.json"):
  var contexts: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://data/boss_hurt_contexts.json"))
  for context in contexts:
   var entry: Dictionary = contexts[context]
   var id: String = entry.id
   specs[id] = {"ms":entry.ms,"loop":false}
   sprite_frames.add_animation(id)
   sprite_frames.set_animation_loop(id,false)
   sprite_frames.set_animation_speed(id,1000)
   var delivered = 0
   for i in entry.ms.size():
    var path = "res://assets/boss/"+id+"/f%03d.png" % i
    var texture: Texture2D
    if PackedArt.exists(path): texture = PackedArt.texture(path)
    if texture != null: delivered += 1
    var placeholder = PlaceholderTexture2D.new()
    placeholder.size = Vector2.ONE
    sprite_frames.add_frame(id,texture if texture else placeholder,float(entry.ms[i]))
   body_clips[id] = delivered == entry.ms.size()
 visible = actor in ["hero", "pursuer"]
 scale = Vector2(0.5, 0.5)
 offset = pivot_offset
 if actor == "hero":
  weapon = Sprite2D.new()
  weapon.centered = false
  var shader = Shader.new()
  shader.code = "shader_type canvas_item; uniform vec2 hand_socket; uniform vec2 texture_origin; void fragment(){ COLOR.a *= smoothstep(7.5, 8.5, distance(UV / TEXTURE_PIXEL_SIZE - texture_origin, hand_socket)); }"
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
    if PackedArt.exists(path): textures.append(PackedArt.texture(path))
   weapon_sets[state] = textures
 follow("idle", 0)
func clip_id(state: String) -> String:
 if actor == "boss" and state == "hurt":
  var context = get_parent().get("hurt_pose_context")
  if context != null and context != "": return "boss_hurt_"+str(context)
 return actor+"_"+state
func has_body_layer(state: String) -> bool:
 return body_clips.get(clip_id(state),false)
func has_weapon_layer(state: String) -> bool:
 return actor == "hero" and weapon_sets.has(state) and weapon_sets[state].size() == specs["hero_" + state].ms.size() and socket_sets.get("hero_" + state, []).size() == specs["hero_" + state].ms.size()
func playback_rate(state: String) -> float:
 if actor == "pursuer" and state == "approach_walk": return approach_cadence
 return WALK_CADENCE if actor == "hero" and state == "walk" else 1.0
func follow(state: String, elapsed: float) -> void:
 var id = clip_id(state)
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
   var texture_origin=Vector2.ZERO
   if weapon.texture is AtlasTexture: texture_origin=weapon.texture.region.position-weapon.texture.margin.position
   weapon.material.set_shader_parameter("texture_origin",texture_origin)
   weapon.material.set_shader_parameter("hand_socket", Vector2(hand_sockets[index][0], hand_sockets[index][1]))
