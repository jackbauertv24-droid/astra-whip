class_name Hunter
extends CharacterBody2D
signal died
var controls = Controls.new()
var world: Node2D
var state = "idle"
var state_time = 0.0
var facing = 1
var pending_facing = 1
var health = Rules.HEALTH
var invulnerable = 0.0
var attack_time = -1.0
var hit_ids: Dictionary = {}
var coyote = 0.0
var jump_buffer = 0.0
var crouched = false
var heavy_pending = false
var death_emitted = false
var shape: CollisionShape2D
var visual: ActorVisual
var history: Dictionary = {}
func _ready() -> void:
 collision_layer = 2
 collision_mask = 1
 floor_snap_length = 2.0
 shape = CollisionShape2D.new()
 shape.shape = RectangleShape2D.new()
 add_child(shape)
 body(false)
 visual = ActorVisual.new()
 add_child(visual)
 visual.configure("hero")
func body(low: bool) -> void:
 crouched = low
 var size = Rules.CROUCH if low and not Rules.mutation("T-01") else Rules.STAND
 shape.shape.size = size
 shape.position.y = -size.y / 2
func enter(next: String) -> void:
 if state == next: return
 state = next
 state_time = 0.0
 history[state] = true
 if state == "crouch_enter" or state == "crouch_idle" or state == "attack_crouch": body(true)
 if state == "death":
  controls.clear()
  attack_time = -1
  hit_ids.clear()
  velocity.x = 0
func clearance() -> bool:
 var rect = Rect2(position + Vector2(-20, -104), Vector2(40, 103))
 for surface in world.surfaces:
  if surface.kind == "one_way" and not Rules.mutation("T-02"): continue
  if rect.intersects(surface.rect): return false
 return true
func active() -> bool:
 var start = 0.3 if Rules.mutation("T-05") else Rules.WINDUP
 return attack_time >= start and attack_time < Rules.ACTIVE_END and health > 0
func whip_rect() -> Rect2:
 return Rect2(position + Vector2(40 if facing == 1 else -168, -48 if crouched else -82), Vector2(128, 28 if crouched else 36))
func body_rect() -> Rect2:
 return Rect2(position + Vector2(-20, -60 if crouched else -104), Rules.CROUCH if crouched else Rules.STAND)
func hit_target(id: int) -> bool:
 if not active() or hit_ids.has(id): return false
 hit_ids[id] = true
 return true
func damage(kind: String, source_x: float) -> void:
 if invulnerable > 0 or health <= 0: return
 health -= 1
 invulnerable = Rules.INVULN
 attack_time = -1.0
 hit_ids.clear()
 if health <= 0:
  enter("death")
  return
 if Rules.mutation("T-06"):
  enter("idle")
  return
 if kind == "heavy":
  if is_on_floor():
   velocity.x = 0
   enter("knockdown")
  else:
   heavy_pending = true
   velocity.x = -Rules.KNOCK_SPEED if source_x >= position.x else Rules.KNOCK_SPEED
   enter("knockback")
 elif kind == "projectile" and is_on_floor():
  velocity.x = 0
  enter("hurt_recoil")
 else:
  velocity.x = -Rules.KNOCK_SPEED if source_x >= position.x else Rules.KNOCK_SPEED
  enter("knockback")
func reset_at(point: Vector2) -> void:
 position = point
 velocity = Vector2.ZERO
 health = 1 if Rules.mutation("T-07") else Rules.HEALTH
 invulnerable = 0
 attack_time = -1
 hit_ids.clear()
 controls.clear()
 coyote = 0
 jump_buffer = 0
 heavy_pending = false
 death_emitted = false
 body(false)
 enter("idle")
 state_time = 0
func simulate(dt: float) -> void:
 var grounded = is_on_floor()
 var axis = controls.axis()
 state_time += dt
 invulnerable = maxf(0, invulnerable - dt)
 coyote = Rules.COYOTE if grounded else maxf(0, coyote - dt)
 jump_buffer = maxf(0, jump_buffer - dt)
 if controls.pressed("jump"): jump_buffer = Rules.BUFFER
 if health <= 0:
  velocity.y += Rules.GRAVITY * dt
  if not grounded: state_time = 0
  move_and_slide()
  if state_time >= 1.3 and not death_emitted:
   death_emitted = true
   died.emit()
  finish()
  return
 if position.y > Rules.KILL_Y:
  health = 0
  enter("death")
  # Pit has no ground to collapse upon. World supplies the visible fade.
  world.pit_fall()
  finish()
  return
 var locked = state in ["hurt_recoil", "knockback", "knockdown", "get_up"]
 if locked:
  match state:
   "hurt_recoil":
    if state_time >= 0.2: enter("idle" if grounded else "fall")
   "knockback":
    if grounded and heavy_pending:
     heavy_pending = false
     velocity.x = 0
     enter("knockdown")
    elif state_time >= 0.3 and not heavy_pending:
     velocity.x = 0
     enter("idle" if grounded else "fall")
   "knockdown":
    if state_time >= 0.36: enter("get_up")
   "get_up":
    if state_time >= 0.45: enter("idle")
  velocity.y += Rules.GRAVITY * dt
  move_and_slide()
  if crouched and clearance(): body(false)
  finish()
  return
 if attack_time >= 0:
  attack_time += dt
  if attack_time >= Rules.ATTACK_END:
   attack_time = -1
   enter("crouch_idle" if crouched else ("idle" if grounded else "fall"))
 elif controls.pressed("whip"):
  attack_time = 0
  hit_ids.clear()
  enter("attack_air" if not grounded else ("attack_crouch" if crouched else "attack_ground"))
 if attack_time >= 0:
  if grounded: velocity.x = 0
  else: velocity.x = move_toward(velocity.x, axis * Rules.SPEED, Rules.AIR_ACCEL * dt)
 elif jump_buffer > 0 and coyote > 0 and clearance():
  body(false)
  velocity.y = Rules.JUMP * (0.6 if Rules.mutation("T-04") else 1.0)
  coyote = 0
  jump_buffer = 0
  enter("jump_takeoff")
  velocity.x = axis * Rules.SPEED
 elif grounded:
  if controls.is_held("crouch"):
   if not crouched: enter("crouch_enter")
   elif state == "crouch_enter" and state_time >= 0.2: enter("crouch_idle")
   velocity.x = 0
  elif crouched:
   velocity.x = 0
   if clearance():
    if state != "crouch_exit": enter("crouch_exit")
    elif state_time >= 0.2:
     body(false)
     enter("idle")
   else: enter("crouch_idle")
  else:
   velocity.x = axis * Rules.SPEED
   if Rules.mutation("T-03"): velocity.x = 0
   if axis != 0:
    if int(axis) != facing and state != "turn":
     pending_facing = int(axis)
     enter("turn")
    elif state == "turn":
     if state_time >= 0.075: facing = pending_facing
     if state_time >= 0.15: enter("walk")
    elif state in ["idle", "stop_move", "land"]: enter("start_move")
    elif state == "start_move" and state_time >= 0.15: enter("walk")
   else:
    if state in ["walk", "start_move", "turn"]: enter("stop_move")
    elif state_time >= (0.16 if state == "land" else 0.15): enter("idle")
 else:
  velocity.x = move_toward(velocity.x, axis * Rules.SPEED, Rules.AIR_ACCEL * dt)
  if state != "jump_takeoff" or state_time >= 0.12:
   enter("jump_rise" if velocity.y < -160 else ("jump_apex" if velocity.y <= 160 else "fall"))
 velocity.y += Rules.GRAVITY * dt
 move_and_slide()
 if not grounded and is_on_floor():
  if attack_time >= 0:
   enter("attack_crouch" if controls.is_held("crouch") else "attack_ground")
  elif controls.is_held("crouch"): enter("crouch_enter")
  else: enter("land")
 finish()
func finish() -> void:
 visual.follow(state, attack_time if attack_time >= 0 else state_time)
 controls.flush_edges()
 queue_redraw()
func _draw() -> void:
 var color = Color("cfc4a5") if invulnerable <= 0 else Color("ffffff")
 var size = Rules.CROUCH if crouched else Rules.STAND
 visual.modulate = color
 if not visual.visible:
  draw_rect(Rect2(Vector2(-20, -size.y), size), color)
  draw_line(Vector2(0,-size.y+15), Vector2(facing*28,-size.y+15), Color("c07f2e"), 4)
 if attack_time >= 0 and not visual.has_weapon_layer(state):
  var reach = 168.0 if active() else lerpf(20, 150, clampf(attack_time / 0.15, 0, 1))
  draw_line(Vector2(facing*20, -34 if crouched else -64), Vector2(facing*reach, -34 if crouched else -64), Color("8b959e"), 3)
