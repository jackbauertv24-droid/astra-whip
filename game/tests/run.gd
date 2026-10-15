extends SceneTree
var world
var failures: Array = []
var checks = 0
var group = ""
const DT = 1.0 / 120.0
func _initialize() -> void:
 call_deferred("run")
func check(condition: bool, message: String) -> void:
 checks += 1
 if not condition:
  failures.append(group + ": " + message)
  printerr("FAIL ", group, ": ", message)
func tick(count: int) -> void:
 for i in count:
  await physics_frame
  world.step(DT)
func fresh(point: Vector2 = Vector2(160,560)) -> void:
 world.restart()
 world.simulate_enemies = false
 world.hero.reset_at(point)
 await tick(4)
func press(action: String, value: bool = true) -> void:
 world.hero.controls.set_action(action,value)
func report(id: String, start: int) -> void:
 print(id, ": ", "PASS" if failures.size()==start else "FAIL")
func run() -> void:
 world = load("res://main.tscn").instantiate()
 world.testing = true
 root.add_child(world)
 await physics_frame
 var h: Hunter = world.hero
 group = "T-01"
 var start = failures.size()
 await fresh()
 press("crouch")
 await tick(1)
 check(h.state=="crouch_enter" and h.shape.shape.size==Rules.CROUCH,"press entry must immediately install 40x60 body")
 await fresh(Vector2(160,480))
 press("crouch")
 for i in 100:
  await tick(1)
  if h.is_on_floor(): break
 check(h.crouched and h.shape.shape.size==Rules.CROUCH,"held-crouch landing body")
 await fresh(Vector2(160,520))
 press("whip")
 press("crouch")
 for i in 70:
  await tick(1)
  if h.is_on_floor(): break
 check(h.state=="attack_crouch" and h.shape.shape.size==Rules.CROUCH,"air attack landing body")
 check(h.attack_time>0,"landing preserves combat time")
 report(group,start)
 group = "T-02"
 start = failures.size()
 await fresh()
 var slab = world.add_surface(Rect2(100,508,160,8),"one_way")
 press("crouch")
 await tick(26)
 press("crouch",false)
 await tick(35)
 check(not h.crouched and h.shape.shape.size==Rules.STAND,"one-way slab cannot deny standing")
 check(h.history.has("crouch_exit"),"crouch exit must play")
 world.surfaces.erase(slab)
 slab.node.queue_free()
 await physics_frame
 report(group,start)
 group = "T-03"
 start = failures.size()
 # Probe every 32u along every authored surface, omitting tall boundary walls
 # and points whose standing body intersects a solid (not reachable standing).
 var samples = 0
 for row in Stage.SURFACES:
  for x in range(int(row[0])*64+20,int(row[1])*64-19,32):
   var point = Vector2(x,Rules.GROUND-float(row[2])*64)
   await fresh(point)
   # Vestibule is reachable only after boss defeat; reaching the exit is escape.
   if point.x > 6528:
    world.exit_unlocked = true
    world.set_gate(false)
   if not h.clearance(): continue
   samples += 1
   var original = h.position
   press("crouch")
   await tick(26)
   press("crouch",false)
   await tick(26)
   press("right")
   await tick(180)
   var moved = h.position.distance_to(original)>=64 or world.complete
   press("right",false)
   press("left")
   await tick(180)
   moved = moved or h.position.distance_to(original)>=64 or world.complete
   press("left",false)
   press("jump")
   await tick(50)
   # A jump counts as escape only if horizontal motion is possible afterwards.
   press("right")
   await tick(100)
   moved = moved or absf(h.position.x-original.x)>=64
   check(moved,"trapped sample "+str(point))
 print("T-03 reachable standing samples: ",samples)
 check(samples>200,"surface grid has meaningful coverage")
 report(group,start)
 group = "T-04"
 start = failures.size()
 await fresh()
 press("right")
 press("jump")
 var origin = h.position
 var highest = h.position.y
 var apex_time = 0.0
 var air_time = 0.0
 var landed = false
 for i in 140:
  await tick(1)
  air_time += DT
  if h.position.y<highest:
   highest=h.position.y
   apex_time=air_time
  if i>5 and h.is_on_floor():
   landed=true
   break
 var rise = origin.y-highest
 var travel = h.position.x-origin.x
 print("T-04 measured rise=",rise," apex=",apex_time," travel=",travel)
 check(landed,"jump must land")
 check(absf(rise-128)<=128*0.06,"rise 128 +/-6%")
 check(absf(apex_time-0.4)<=0.4*0.06,"apex 0.4 +/-6%")
 check(absf(travel-192)<=192*0.06,"travel 192 +/-6%")
 report(group,start)
 group = "T-05"
 start = failures.size()
 await fresh()
 press("whip")
 await tick(13)
 check(not h.active(),"inactive 100ms")
 await tick(12)
 check(h.active(),"active 200ms")
 check(h.hit_target(99) and not h.hit_target(99),"one hit per target per attack")
 await tick(12)
 check(not h.active(),"inactive 300ms")
 await tick(100)
 check(h.attack_time<0,"held whip cannot repeat")
 await fresh()
 press("whip")
 press("jump")
 await tick(90)
 check(h.is_on_floor() and h.position.y>559,"ground whip wins; jump buffer expires")
 report(group,start)
 group = "T-06"
 start = failures.size()
 for kind in ["projectile","contact","heavy"]:
  await fresh()
  h.attack_time=0.2
  h.damage(kind,200)
  var expected = {"projectile":"hurt_recoil","contact":"knockback","heavy":"knockdown"}[kind]
  check(h.state==expected,kind+" routes to "+expected)
  check(not h.active() and h.attack_time<0,"damage cancels outgoing attack")
  var hp=h.health
  h.damage(kind,200)
  check(h.health==hp,"invulnerability drops repeat damage")
  if kind=="heavy":
   await tick(44)
   check(h.state=="get_up","heavy progresses to get_up")
 for state in Rules.HERO_STATES:
  await fresh()
  h.enter(state)
  h.health=1
  h.invulnerable=0
  h.damage("heavy",200)
  check(h.state=="death" and h.health==0,"lethal priority from "+state)
 report(group,start)
 group = "T-07"
 start = failures.size()
 await fresh()
 world.capture_checkpoint()
 h.position=Vector2(2200,Rules.KILL_Y+1)
 h.invulnerable=1
 await tick(110)
 check(h.health==5 and h.position.distance_to(world.respawn)<2,"pit bypasses immunity and restarts at checkpoint with 5 HP")
 check(world.respawn.x==4128,"checkpoint owns respawn")
 world.simulate_enemies=true
 for foe in world.foes:
  if foe.kind=="boss":
   for i in 8: foe.take_hit()
 await tick(140)
 check(world.exit_unlocked,"boss death unlocks exit")
 h.position=Vector2(6610,Rules.GROUND)
 await tick(1)
 check(world.complete,"touch unlocked exit completes stage")
 world.restart()
 check(not world.complete and not world.checkpoint and world.respawn.x==160,"completion retry resets full stage")
 check(not world.exit_unlocked,"retry relocks exit")
 report(group,start)
 group = "T-08"
 start = failures.size()
 await fresh()
 press("left")
 press("right")
 check(h.controls.axis()==0,"opposing inputs neutral")
 world.set_pause(true)
 check(h.controls.held.is_empty(),"pause clears input")
 press("left")
 world._notification(Node.NOTIFICATION_APPLICATION_FOCUS_OUT)
 check(h.controls.held.is_empty() and world.paused,"focus loss clears input and pauses")
 press("whip")
 h.health=1
 h.damage("contact",200)
 check(h.controls.held.is_empty(),"death clears input")
 # Independent sources survive a different key/touch being released.
 h.controls.set_action("left",true,"a")
 h.controls.set_action("left",true,"b")
 h.controls.set_action("left",false,"a")
 check(h.controls.is_held("left"),"source-specific release")
 h.controls.clear()
 report(group,start)
 group = "T-09"
 start = failures.size()
 # Actual AnimatedSprite2D resource inventory; every state is selected through
 # the actor transition function, and each real player frame is stepped.
 for state in Rules.HERO_STATES:
  h.enter(state)
  h.visual.follow(state,0)
  var id="hero_"+state
  check(h.visual.sprite_frames.has_animation(id),"mapped clip exists "+id)
  check(h.visual.animation==id,"state selects clip "+id)
 for foe in world.foes:
  for state in Rules.ENEMY_STATES[foe.kind]:
   foe.enter(state)
   foe.visual.follow(state,0)
   check(foe.visual.animation==foe.kind+"_"+state,"enemy mapped clip "+foe.kind+"_"+state)
 for actor in [h]+world.foes:
  var v: ActorVisual=actor.visual
  for id in v.sprite_frames.get_animation_names():
   check(v.played.has(id),"no orphan clip "+id)
   var spec: Dictionary=v.specs[id]
   check(v.sprite_frames.get_frame_count(id)==spec.ms.size(),"frame count "+id)
   check(v.sprite_frames.get_animation_loop(id)==spec.loop,"loop "+id)
   var ms=0.0
   for index in spec.ms.size():
    var expected_rate = 2.0 if id == "hero_walk" else 1.0 # ANIMATION_SPEC permits travel-speed tuning.
    if id == "pursuer_approach_walk": expected_rate = 35.0 / 27.0
    v.follow(id.substr(v.actor.length()+1),(ms+0.01)/(1000.0*expected_rate))
    check(v.frame==index,"frame-step "+id+"/"+str(index))
    ms+=float(spec.ms[index])
 report(group,start)
 print("RESULT ",checks," assertions, ",failures.size()," failures; mutation=",OS.get_environment("ASTRA_MUTATION"))
 quit(0 if failures.is_empty() else 1)
