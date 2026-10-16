extends SceneTree
var checks = 0
var failures = 0
func _initialize() -> void:
 call_deferred("run")
func check(ok: bool,label: String) -> void:
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL ",label)
func run() -> void:
 var world = load("res://main.tscn").instantiate()
 world.testing = true
 root.add_child(world)
 world.simulate_enemies = false
 var foe
 for actor in world.foes:
  if actor.kind=="ranged": foe=actor
 foe.position=Vector2(1800,Rules.GROUND)
 world.camera_x=1800
 for direction in [1,-1]:
  world.hero.reset_at(Vector2(1800+direction*1000,Rules.GROUND))
  foe.facing=direction
  foe.enter("fire")
  world.projectiles.clear()
  foe.simulate(.049)
  check(world.projectiles.is_empty(),"no early birth")
  foe.simulate(.0011)
  check(world.projectiles.size()==1,"one shot after50ms")
  var birth: Vector2 = world.projectiles[0].pos
  check(birth.distance_to(foe.position+Vector2(direction*40,-82.5))<.001,"unchanged muzzle")
  check(absf(world.projectiles[0].start-birth.x)<.001,"range origin is muzzle")
  foe.simulate(.02)
  check(world.projectiles.size()==1,"no duplicate shot")
  world.step(1.0)
  check(world.projectiles.size()==1 and absf(world.projectiles[0].pos.x-birth.x-direction*280)<.01,"280u per second")
  world.step(359.0/280)
  check(world.projectiles.size()==1,"alive at639u from muzzle")
  world.step(2.0/280)
  check(world.projectiles.is_empty(),"expired beyond640u from muzzle")
  for low in [false,true]:
   world.hero.reset_at(Vector2(1800+direction*200,Rules.GROUND))
   # Settle on actual floor before collision; hold crouch through simulation.
   for tick in 3: world.hero.simulate(1.0/120)
   if low:
    world.hero.controls.set_action("crouch",true)
    world.hero.enter("crouch_idle")
   foe.enter("fire")
   foe.simulate(.05)
   for tick in 110: world.step(1.0/120)
   check(world.hero.health==(Rules.HEALTH if low else Rules.HEALTH-1),"crouch clears / standing receives projectile")
   if not low: check(world.projectiles.is_empty(),"hit consumes shot")
   world.projectiles.clear()
 print("RANGED PROJECTILE: ",checks," checks, ",failures," failures")
 quit(0 if failures==0 else 1)
