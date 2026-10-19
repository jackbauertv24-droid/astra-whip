extends SceneTree
const DT=1.0/120
var checks=0
var failures=0
func check(ok: bool,message: String) -> void:
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL boss recovery window: "+message)
func _initialize() -> void:
 call_deferred("run")
func run() -> void:
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 world.arena_active=true
 var boss
 for foe in world.foes:
  if foe.kind=="boss": boss=foe
 var origin: Vector2=boss.position
 for direction in [1,-1]:
  for recovery in ["strike_recover","hazard_recover"]:
   boss.position=origin
   boss.hp=8
   boss.facing=direction
   boss.cycles=0
   world.hero.reset_at(origin+Vector2(direction*145,0))
   world.hero.facing=-direction
   world.camera_x=origin.x
   if recovery=="strike_recover":
    boss.enter("walk")
    for tick in 130:
     world.step(DT)
     boss.simulate(DT)
     if boss.state==recovery: break
    check(boss.state==recovery,"natural700ms tell/200ms spaced strike enters recovery")
    check(world.hero.health==5,"145u spacing clears live100u strike")
   else:
    # Explicit hazard-recovery clock fixture; no claim of a full hazard encounter.
    boss.cycles=2
    boss.enter(recovery)
   var duration=1.1 if recovery=="strike_recover" else .9
   var attacks=0
   var wanted=2 if recovery=="strike_recover" else 1
   var early=false
   var hurt_seen=false
   var resumed=false
   var elapsed=0.0
   for tick in 150:
    var trigger=attacks<wanted and world.hero.attack_time<0
    if trigger: attacks+=1
    world.hero.controls.set_action("whip",trigger)
    world.step(DT)
    boss.simulate(DT)
    elapsed+=DT
    world.hero.controls.set_action("whip",false)
    if boss.state=="hurt": hurt_seen=true
    if hurt_seen and boss.state==recovery: resumed=true
    if elapsed<duration-DT-.0001 and boss.state not in [recovery,"hurt"]: early=true
    if elapsed>=duration-DT and boss.state not in [recovery,"hurt"]: break
   var label=recovery+" direction="+str(direction)
   check(hurt_seen,label+" actual whip produces hurt")
   check(resumed,label+" returns to interrupted recovery")
   check(not early,label+" no new movement/attack before deadline")
   check(absf(elapsed-duration)<=DT+.001,label+" original deadline preserved through hurt")
   check(boss.state=="walk",label+" outgoing walk")
   check(boss.hp==8-wanted,label+" actual whip damage")
   check(world.hero.attack_time<0,label+" full500ms whip commitments finish inside window")
   check(boss.position.distance_to(origin)<.01,label+" no early root advance")
   check(world.hero.health==5,label+" punish remains safe at145u")
   print("OBSERVED ",label," hp=",boss.hp," elapsed_ms=",elapsed*1000," outgoing=",boss.state," early=",early," resumed=",resumed)
 print("RESULT boss recovery window: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
