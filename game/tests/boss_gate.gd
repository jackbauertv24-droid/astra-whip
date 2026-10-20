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
  printerr("FAIL boss gate: "+message)
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
 check(world.gate_texture!=null and world.gate_texture.get_size()==Vector2(128,320),"painted gate full canvas")
 check(Vector2(world.gate_spec.anchor[0],world.gate_spec.anchor[1])==Vector2(64,288),"brief base pivot")
 check(world.gates.size()==2,"both original arena gates")
 check(world.gate_open_fraction==1 and world.gate_target_open==1,"initial gates fully raised")
 world.hero.reset_at(Vector2(5650,Rules.GROUND))
 world.hero.controls.set_action("right",true)
 for tick in 10:
  await advance(1)
  if world.arena_active:break
 world.hero.controls.set_action("right",false)
 check(world.arena_active and world.gate_target_open==0,"actual entry lowers gates")
 check(world.gate_open_fraction>0 and world.gate_open_fraction<1,"close is a slide")
 for gate in world.gates:check(gate.node.collision_layer==1 and gate in world.surfaces,"collision closes immediately")
 var age:float=world.gate_open_fraction
 world.testing=false
 world.set_pause(true)
 world._physics_process(.2)
 check(world.gate_open_fraction==age,"pause freezes slide")
 world.testing=true
 world.set_pause(false)
 await advance(30)
 check(world.gate_open_fraction==0,"closed presentation settles")
 world.hero.reset_at(Vector2(5680,Rules.GROUND))
 world.hero.controls.set_action("left",true)
 await advance(60)
 world.hero.controls.set_action("left",false)
 check(world.hero.position.x>=5631,"left closed gate blocks actual walking")
 world.hero.reset_at(Vector2(6460,Rules.GROUND))
 world.hero.controls.set_action("right",true)
 await advance(60)
 world.hero.controls.set_action("right",false)
 check(world.hero.position.x<=6509,"right closed gate blocks actual walking")
 world.exit_unlocked=true
 await advance(1)
 check(world.gate_target_open==1 and world.gate_open_fraction>0 and world.gate_open_fraction<1,"unlock raises visible gate")
 for gate in world.gates:check(gate.node.collision_layer==0 and not gate in world.surfaces,"unlock removes collision immediately")
 await advance(29)
 check(world.gate_open_fraction==1,"250ms open slide completes")
 world.hero.reset_at(Vector2(6460,Rules.GROUND))
 world.hero.controls.set_action("right",true)
 await advance(60)
 world.hero.controls.set_action("right",false)
 check(world.hero.position.x>6544,"open right gate permits actual walking")
 world.restart()
 check(world.gate_open_fraction==1 and world.gate_target_open==1 and not world.arena_active,"restart resets raised gates")
 for gate in world.gates:check(gate.node.collision_layer==0,"restart clears collision")
 print("RESULT boss gate: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
