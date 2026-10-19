extends SceneTree
var failures=0
var checks=0
func check(ok: bool,message: String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL portrait pause: "+message)
func resize_to(size: Vector2i):
 root.size=size
 for frame in 5: await process_frame
func _initialize():
 call_deferred("run")
func run():
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 for size in [Vector2i(393,852),Vector2i(375,667)]:
  await resize_to(Vector2i(852,393))
  world.set_pause(false)
  world.hero.controls.set_action("right",true,"portrait-test")
  check(not world.paused,"landscape can explicitly resume")
  await resize_to(size)
  check(world.paused,"physical portrait pauses despite landscape logical viewport")
  check(not world.hero.controls.is_held("right"),"orientation transition clears held controls")
  var prompt=world.get("rotate_prompt")
  check(prompt!=null and prompt.visible,"visible rotate prompt")
  check(not world.menu.visible,"portrait prompt replaces landscape menu")
  world.set_pause(false)
  check(world.paused,"resume cannot run gameplay behind portrait prompt")
  await resize_to(Vector2i(852,393))
  check(world.paused and world.menu.visible,"landscape return waits for explicit resume")
  check(prompt!=null and not prompt.visible,"rotate prompt hides after landscape return")
  world.set_pause(false)
  check(not world.paused,"explicit landscape resume succeeds")
 print("RESULT portrait pause: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
