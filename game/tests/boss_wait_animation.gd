extends SceneTree
var checks = 0
var failures = 0
func check(ok: bool, message: String) -> void:
 checks += 1
 if not ok:
  failures += 1
  printerr("FAIL boss waiting animation: "+message)
func _initialize() -> void:
 call_deferred("run")
func run() -> void:
 var world = load("res://main.tscn").instantiate()
 root.add_child(world)
 world.testing = true
 world.simulate_enemies = false
 world.set_pause(false)
 var boss
 for foe in world.foes:
  if foe.kind=="boss": boss = foe
 check(boss!=null,"stage boss exists")
 check(boss.visual.has_body_layer("idle"),"all eight idle resources load")
 var origin: Vector2 = boss.position
 for direction in [1,-1]:
  world.arena_active = false
  boss.facing = direction
  boss.enter("idle")
  boss.simulate(0)
  check(boss.visual.frame==0,"waiting starts at frame0")
  for frame in range(1,8):
   boss.simulate(.125)
   check(boss.state=="idle" and boss.visual.frame==frame,"inactive arena advances idle frame%d" % frame)
  boss.simulate(.125)
  check(boss.visual.frame==0 and boss.state=="idle","1000ms waiting wrap")
  check(boss.position==origin and boss.hp==8,"waiting preserves root and production health")
  check(boss.visual.flip_h==(direction<0),"waiting facing follows actor")
  world.arena_active = true
  boss.simulate(1.0/120)
  check(boss.state=="walk" and boss.visual.frame==0,"activation naturally enters walk")
 print("RESULT boss waiting animation: %d checks, %d failures" % [checks,failures])
 quit(1 if failures else 0)
