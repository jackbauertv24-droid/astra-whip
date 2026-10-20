extends SceneTree
const DT=1.0/120
var world
var checks=0
var failures=0
func _initialize():call_deferred("run")
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL checkpoint art: "+message)
func advance(ticks:int):
 for tick in ticks:
  await physics_frame
  world.step(DT)
func prepare(direction:int):
 world.complete=true
 world.restart()
 world.hero.reset_at(Vector2(4128-direction*80,Rules.GROUND))
 world.hero.facing=direction
 await advance(4)
func approach(direction:int):
 world.hero.controls.set_action("right" if direction>0 else "left",true)
 for tick in 60:
  await advance(1)
  if world.checkpoint:break
 world.hero.controls.set_action("right" if direction>0 else "left",false)
func run():
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 var layer=world.checkpoint_layer
 check(world.checkpoint_frames.size()==2,"both static marker states load")
 check(world.checkpoint_frames[0]!=world.checkpoint_frames[1],"active marker distinct")
 check(Vector2(world.checkpoint_spec.canvas[0],world.checkpoint_spec.canvas[1])==Vector2(192,320) and Vector2(world.checkpoint_spec.anchor[0],world.checkpoint_spec.anchor[1])==Vector2(96,288),"marker brief geometry")
 check(layer.frames.size()==8,"eight activation phases load")
 check(layer.canvas_size==Vector2(256,384) and layer.anchor==Vector2(128,352),"effect brief geometry")
 check(layer.durations.all(func(ms):return int(ms)==90),"90ms phase durations")
 for f in 8:
  check(layer.frame_at(float(f*90)/1000+.0000001)==f,"phase start"+str(f))
  check(layer.frame_at(float((f+1)*90)/1000-.000001)==f,"phase end"+str(f))
 check(layer.frame_at(.72)==-1,"720ms expiry")
 for direction in [1,-1]:
  await prepare(direction)
  check(not world.checkpoint and layer.bursts.is_empty(),"initial inactive state")
  world.hero.position=Vector2(4128,Rules.GROUND-100)
  world.step(0)
  check(not world.checkpoint,"airborne passage does not activate")
  world.hero.reset_at(Vector2(4128-direction*80,Rules.GROUND))
  await approach(direction)
  check(world.checkpoint and world.respawn==Vector2(4128,Rules.GROUND),"actual approach captures checkpoint")
  check(layer.bursts.size()==1,"one activation burst")
  if layer.bursts.is_empty():continue
  check(layer.bursts[0].position==Vector2(4128,Rules.GROUND) and layer.bursts[0].age==0.0,"effect starts on capture at marker base")
  world.capture_checkpoint()
  check(layer.bursts.size()==1,"repeated capture is idempotent")
  world.testing=false
  world.set_pause(true)
  world._physics_process(.2)
  check(layer.bursts[0].age==0.0,"pause holds activation clock")
  world.testing=true
  world.set_pause(false)
  world.reduced_effects=true
  await advance(1)
  check(layer.reduced,"reduced effects applies")
  await advance(84)
  check(layer.bursts.size()==1,"effect persists before720ms")
  await advance(2)
  check(layer.bursts.is_empty(),"effect expires after720ms")
  world.capture_checkpoint()
  check(layer.bursts.is_empty(),"captured checkpoint cannot replay")
  world.hero.health=1
  world.restart()
  check(world.checkpoint and world.hero.position==Vector2(4128,Rules.GROUND) and world.hero.health==5,"retry preserves active marker/respawn and restores health")
  check(layer.bursts.is_empty(),"retry clears effect without replay")
  world.complete=true
  world.restart()
  check(not world.checkpoint and world.hero.position==Vector2(160,Rules.GROUND),"completion retry resets inactive marker")
 print("RESULT checkpoint art: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
