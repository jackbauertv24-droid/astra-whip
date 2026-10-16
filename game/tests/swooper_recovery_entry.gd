extends SceneTree
const DT = 1.0/120.0
var checks = 0
var failures = 0
func _initialize() -> void:
 call_deferred("run")
func check(condition: bool,label: String) -> void:
 checks+=1
 if not condition:
  failures+=1
  printerr("FAIL ",label)
func run() -> void:
 var world = load("res://main.tscn").instantiate()
 world.testing = true
 root.add_child(world)
 world.simulate_enemies = false
 world.hero.reset_at(Vector2(1250,Rules.GROUND))
 world.camera_x = 1800
 var foe
 for actor in world.foes:
  if actor.kind == "swooper":
   foe = actor
   break
 foe.bounds = Vector2(1400,2200)
 foe.floor_y = Rules.GROUND
 for sample in [{"state":"cruise","altitude":180},{"state":"dive_telegraph","altitude":175},{"state":"recovery_climb","altitude":120}]:
  foe.position = Vector2(1800,Rules.GROUND-sample.altitude)
  foe.facing = 1
  foe.hp = 2 # Explicit conditional nonlethal branch, not production basic HP.
  foe.enter(sample.state)
  foe.take_hit()
  var start_y: float = foe.position.y
  check(foe.hp==1 and foe.state=="hurt","nonlethal damage interrupts "+sample.state)
  for tick in 30:
   if foe.state!="hurt": break
   foe.simulate(DT)
  check(foe.state=="recovery_climb" and absf(foe.position.y-start_y)<.01,"hurt holds altitude until recovery "+sample.state)
  foe.simulate(DT)
  check(absf(foe.position.y-start_y)<2,"no recovery teleport from "+sample.state)
  var expected = lerpf(start_y,Rules.GROUND-182.5,DT/.9)
  check(absf(foe.position.y-expected)<.01,"recovery starts at hit altitude "+sample.state)
  for tick in 115:
   if foe.state!="recovery_climb": break
   foe.simulate(DT)
  check(foe.state=="cruise" and absf(foe.position.y-(Rules.GROUND-182.5))<.01,"recovery reaches patrol altitude "+sample.state)
 foe.position = Vector2(1800,Rules.GROUND-182.5)
 foe.hp = 1
 foe.enter("dive")
 foe.simulate(.24)
 check(foe.state=="recovery_climb" and absf(foe.position.y-(Rules.GROUND-64))<.01,"normal lethal-HP dive still enters from64u")
 foe.simulate(DT)
 check(absf(foe.position.y-lerpf(Rules.GROUND-64,Rules.GROUND-182.5,DT/.9))<.01,"normal dive recovery trajectory unchanged")
 print("SWOOPER RECOVERY ENTRY: ",checks," checks, ",failures," failures")
 quit(0 if failures==0 else 1)
