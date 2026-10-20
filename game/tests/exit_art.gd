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
  printerr("FAIL exit art: "+message)
func advance(ticks:int):
 for tick in ticks:
  await physics_frame
  world.step(DT)
func run():
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 check(world.exit_marker.texture.get_size()==Vector2(192,320),"brief full canvas")
 check(world.exit_marker.offset==Vector2(0,-128) and world.exit_marker.scale==Vector2(.5,.5),"floor anchor at96,288")
 check(world.exit_marker.position==Vector2(6612,Rules.GROUND),"door grounded at exit")
 check(not world.exit_material.get_shader_parameter("unlocked"),"initial cool state")
 var original=world.exit_marker.texture
 world.hero.reset_at(Vector2(6610,Rules.GROUND))
 world.step(0)
 check(not world.complete,"locked exit cannot complete")
 world.hero.reset_at(Vector2(6000,Rules.GROUND))
 var boss=world.foes.filter(func(foe):return foe.kind=="boss")[0]
 boss.hp=1
 boss.take_hit()
 # Isolate the supported lethal branch; production8HP is covered by run.gd.
 var all_foes:Array=world.foes
 world.foes=[boss]
 world.simulate_enemies=true
 await advance(129)
 check(not world.exit_unlocked and not world.exit_material.get_shader_parameter("unlocked"),"cool through full death delay")
 await advance(1)
 check(world.exit_unlocked and world.exit_material.get_shader_parameter("unlocked"),"death unlock applies Ember immediately")
 check(world.exit_marker.texture==original,"one painted frame retained")
 world.testing=false
 world.set_pause(true)
 world._physics_process(.2)
 check(bool(world.exit_material.get_shader_parameter("unlocked")),"pause preserves unlocked presentation")
 world.testing=true
 world.set_pause(false)
 world.foes=all_foes
 world.simulate_enemies=false
 world.hero.reset_at(Vector2(6550,Rules.GROUND))
 world.hero.controls.set_action("right",true)
 await advance(30)
 check(world.complete,"actual walking into unlocked door completes")
 check(world.hero.controls.held.is_empty() and world.hero.controls.edges.is_empty() and world.hero.controls.touches.is_empty(),"completion clears input")
 world.restart()
 check(not world.complete and not world.exit_unlocked and not world.exit_material.get_shader_parameter("unlocked"),"completion retry relocks cool door")
 check(world.hero.position==Vector2(160,Rules.GROUND),"completion retry starts whole stage")
 print("RESULT exit art: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
