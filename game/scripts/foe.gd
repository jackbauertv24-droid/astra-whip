class_name Foe
extends Node2D
var kind = "pursuer"
var state = "idle"
var elapsed = 0.0
var hp = 1
var facing = -1
var bounds = Vector2.ZERO
var floor_y = Rules.GROUND
var spawn = Vector2.ZERO
var world: Node2D
var visual: ActorVisual
var hazard_x = 0.0
var cycles = 0
var shot = false
var history: Dictionary = {}
func _ready() -> void:
 visual = ActorVisual.new()
 add_child(visual)
 visual.configure(kind)
 hp = 8 if kind == "boss" else (2 if kind == "ranged" else 1)
 spawn = position
 enter("perch_idle" if kind == "swooper" else "idle")
func enter(next: String) -> void:
 state = next
 elapsed = 0
 history[next] = true
 shot = false
func contact_rect() -> Rect2:
 match kind:
  "boss": return Rect2(position + Vector2(-60, -176), Vector2(120,176))
  "ranged": return Rect2(position + Vector2(-36,-150), Vector2(72,150))
  "swooper": return Rect2(position-Vector2.ONE*Rules.SWOOPER_RADIUS,Vector2.ONE*Rules.SWOOPER_RADIUS*2)
 return Rect2(position + Vector2(-48,-52), Vector2(96,52))
func overlaps_rect(rect: Rect2) -> bool:
 if kind != "swooper": return contact_rect().intersects(rect)
 var closest = Vector2(clampf(position.x,rect.position.x,rect.end.x),clampf(position.y,rect.position.y,rect.end.y))
 return position.distance_squared_to(closest) < Rules.SWOOPER_RADIUS*Rules.SWOOPER_RADIUS
func take_hit() -> void:
 if hp <= 0: return
 hp -= 1
 if hp <= 0:
  enter("death_fall" if kind == "swooper" else "death")
 elif kind != "boss" or state != "strike_execute": enter("hurt")
func simulate(dt: float) -> void:
 elapsed += dt
 var h: Hunter = world.hero
 var dx = h.position.x - position.x
 var distance = absf(dx)
 var direction = 1 if dx >= 0 else -1
 if hp <= 0:
  if kind == "swooper": position.y = minf(floor_y, position.y + 180 * dt)
  if kind == "boss" and elapsed >= 1.08: world.exit_unlocked = true
  visual.follow(state, elapsed)
  queue_redraw()
  return
 # No enemy anticipation starts off camera or across a safe apron.
 var visible_threat = absf(position.x - world.camera_x) < 580
 match kind:
  "pursuer":
   match state:
    "idle":
     if elapsed >= 0.9: enter("patrol_walk")
    "patrol_walk":
     position.x += facing * Rules.PURSUER_PATROL_SPEED * dt
     if position.x <= bounds.x: facing = 1
     if position.x >= bounds.y: facing = -1
     if visible_threat and distance < 400 and absf(h.position.y - floor_y) < 70: enter("alert")
    "alert":
     facing = direction
     if elapsed >= 0.3: enter("approach_walk")
    "approach_walk":
     facing = direction
     position.x += facing * Rules.PURSUER_APPROACH_SPEED * dt
     if distance < 120: enter("lunge_windup")
     elif distance > 400: enter("patrol_walk")
    "lunge_windup":
     if elapsed >= 0.35: enter("lunge")
    "lunge":
     position.x += facing * 260 * dt
     if elapsed >= 0.24: enter("recovery")
    "recovery":
     if elapsed >= 0.6: enter("approach_walk")
    "hurt":
     if elapsed >= 0.18: enter("approach_walk")
   position.x = clampf(position.x,bounds.x,bounds.y)
  "swooper":
   match state:
    "perch_idle":
     if elapsed >= 0.9: enter("cruise")
    "cruise":
     position.x += facing * 65 * dt
     position.y = floor_y - 182.5 + sin(elapsed * 2) * 7.5
     if position.x <= bounds.x: facing = 1
     if position.x >= bounds.y: facing = -1
     if visible_threat and distance < 300 and elapsed > 1: enter("dive_telegraph")
    "dive_telegraph":
     facing = direction
     if elapsed >= 0.6: enter("dive")
    "dive":
     position.x += facing * 300 * dt
     position.y = lerpf(floor_y - 182.5, floor_y - 64, minf(1,elapsed/0.12))
     if elapsed >= 0.24: enter("recovery_climb")
    "recovery_climb":
     position.y = lerpf(floor_y-64,floor_y-182.5,minf(1,elapsed/0.9))
     if elapsed >= 0.9: enter("cruise")
    "hurt":
     if elapsed >= 0.18: enter("recovery_climb")
   position.x = clampf(position.x,bounds.x,bounds.y)
  "ranged":
   facing = direction
   match state:
    "idle":
     if visible_threat and distance < 640: enter("aim")
    "aim":
     if elapsed >= 0.9: enter("fire")
    "fire":
     if elapsed >= 0.05 and not shot:
      shot = true
      world.projectiles.append({"pos":position+Vector2(facing*40,-82.5),"start":position.x,"dir":facing})
     if elapsed >= 0.2: enter("recover")
    "recover":
     if elapsed >= 0.7: enter("idle")
    "hurt":
     if elapsed >= 0.18: enter("idle")
  "boss":
   if not world.arena_active: return
   match state:
    "idle":
     if elapsed >= 1: enter("walk")
    "walk":
     if facing != direction: enter("turn")
     elif distance < 150 and cycles % 2 == 0: enter("strike_windup")
     elif elapsed > 2.0 or cycles % 2 == 1:
      hazard_x = h.position.x
      enter("hazard_windup")
     else: position.x += facing * 70 * dt
    "turn":
     if elapsed >= 0.15: facing = direction
     if elapsed >= 0.3: enter("walk")
    "strike_windup":
     if elapsed >= 0.7: enter("strike_execute")
    "strike_execute":
     if elapsed < 0.1:
      var strike = Rect2(position + Vector2(0 if facing == 1 else -100, -150), Vector2(100,150))
      if strike.intersects(h.body_rect()): h.damage("heavy",position.x)
     if elapsed >= 0.2:
      cycles += 1
      enter("strike_recover")
    "strike_recover":
     if elapsed >= 1.1: enter("walk")
    "hazard_windup":
     # Zone follows until frame 7 (1050 ms), then locks before eruption.
     if elapsed < 1.05: hazard_x = h.position.x
     if elapsed >= 1.2: enter("hazard_execute")
    "hazard_execute":
     var hazard = Rect2(Vector2(hazard_x-80,floor_y-46), Vector2(160,46))
     if hazard.intersects(h.body_rect()): h.damage("contact",hazard_x)
     if elapsed >= 0.4:
      cycles += 1
      enter("hazard_recover")
    "hazard_recover":
     if elapsed >= 0.9: enter("walk")
    "hurt":
     if elapsed >= 0.2: enter("walk")
   position.x = clampf(position.x, 5700, 6460)
 if overlaps_rect(h.body_rect()):
  h.damage("contact", position.x)
 if h.active() and overlaps_rect(h.whip_rect()) and h.hit_target(get_instance_id()): take_hit()
 visual.follow(state,elapsed)
 queue_redraw()
func _draw() -> void:
 if hp <= 0 and elapsed > 1.2:
  visual.visible = false
  return
 var color = Color("8cc084") if kind == "ranged" else Color("a9a491")
 if state.contains("windup") or state in ["alert", "aim", "dive_telegraph"]: color = Color("e3a34a")
 if hp <= 0: color.a = maxf(0.1,1-elapsed)
 if kind == "swooper":
  visual.visible = visual.has_body_layer(state)
  if visual.visible:
   visual.modulate = Color(1,1,1,color.a)
   return
 var rect = contact_rect()
 rect.position -= position
 if kind == "pursuer":
  visual.modulate = color
 elif kind == "swooper":
  var flap = sin(elapsed * 15) * 12
  draw_colored_polygon(PackedVector2Array([Vector2(-42,-15-flap),Vector2(-15,14),Vector2(0,-8),Vector2(15,14),Vector2(42,-15-flap),Vector2(18,-5),Vector2(0,-23),Vector2(-18,-5)]),color)
  draw_circle(Vector2.ZERO,9,Color("27212e"))
  draw_circle(Vector2(-3,-4),2,Color("e3a34a"))
  draw_circle(Vector2(3,-4),2,Color("e3a34a"))
 elif kind == "ranged":
  draw_colored_polygon(PackedVector2Array([Vector2(-30,0),Vector2(-22,-110),Vector2(0,-154),Vector2(22,-110),Vector2(30,0)]),color.darkened(0.35))
  draw_circle(Vector2(0,-118),16,Color("27212e"))
  draw_line(Vector2(-8,-119),Vector2(8,-119),color,3)
  draw_line(Vector2(facing*12,-88),Vector2(facing*38,-70),color,7)
 else:
  draw_colored_polygon(PackedVector2Array([Vector2(-50,0),Vector2(-38,-116),Vector2(-58,-138),Vector2(-30,-160),Vector2(0,-179),Vector2(30,-160),Vector2(58,-138),Vector2(38,-116),Vector2(50,0)]),color.darkened(0.25))
  draw_rect(Rect2(-14,-154,28,18),Color("27212e"))
  draw_line(Vector2(-8,-145),Vector2(8,-145),Color("e3a34a"),3)
  draw_line(Vector2(facing*35,-95),Vector2(facing*70,-25),color,9)
  draw_line(Vector2(facing*70,-25),Vector2(facing*89,-66),color,12)
 if kind == "boss" and state.begins_with("hazard_") and state != "hazard_recover":
  draw_rect(Rect2(Vector2(hazard_x-position.x-80,floor_y-position.y- (46 if state == "hazard_execute" else 6)),Vector2(160,46 if state == "hazard_execute" else 6)),Color("e3a34a"),state=="hazard_execute",3)
