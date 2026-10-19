extends SceneTree
const DT=1.0/120
var checks=0
var failures=0
func check(ok: bool,message: String) -> void:
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL boss strike contact: "+message)
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
  boss.position=origin
  boss.hp=8
  boss.cycles=0
  boss.facing=direction
  world.hero.reset_at(origin+Vector2(direction*80,0))
  world.camera_x=origin.x
  for tick in 3: world.step(DT)
  boss.enter("walk")
  boss.simulate(0)
  check(boss.state=="strike_windup","natural close trigger")
  var safe_tell=true
  for tick in 90:
   world.step(DT)
   boss.simulate(DT)
   if world.hero.health!=5: safe_tell=false
   if boss.state=="strike_execute": break
  check(safe_tell and boss.state=="strike_execute","no heavy hit throughout700ms tell")
  check(boss.visual.frame==0,"live strike starts at frame0")
  boss.simulate(DT)
  check(world.hero.health==4,"live close strike deals one damage")
  check(world.hero.state=="knockdown","grounded heavy strike enters knockdown")
  check(world.hero.velocity.x==0,"grounded heavy hit does not slide")
  # Explicit trailing-frame fixture, beyond the first100ms active interval.
  world.hero.reset_at(origin+Vector2(direction*80,0))
  for tick in 3: world.step(DT)
  boss.enter("strike_execute")
  boss.elapsed=.1
  boss.simulate(DT)
  check(boss.visual.frame==2,"100ms ends the two live50ms frames")
  check(world.hero.health==5,"trailing strike frame has no heavy hit")
  check(boss.position==origin and boss.hp==8,"strike preserves root and production health")
 print("RESULT boss strike contact: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
