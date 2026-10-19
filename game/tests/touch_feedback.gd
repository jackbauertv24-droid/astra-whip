extends SceneTree
var checks=0
var failures=0
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL touch feedback: "+message)
func _initialize(): call_deferred("run")
func run():
 root.size=Vector2i(852,393)
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 for frame in 5: await process_frame
 world.set_pause(false)
 for action in world.touch_buttons:
  var control=world.touch_buttons[action]
  check(not control.button_pressed,"initially released "+action)
  world.hero.controls.set_action(action,true,"keyboard")
  await process_frame
  check(control.button_pressed,"keyboard shows pressed "+action)
  world.hero.controls.set_action(action,true,"touch9")
  world.hero.controls.set_action(action,false,"keyboard")
  await process_frame
  check(control.button_pressed,"second source keeps pressed "+action)
  world.hero.controls.set_action(action,false,"touch9")
  await process_frame
  check(not control.button_pressed,"last release removes pressed "+action)
 world.hero.controls.set_action("jump",true,"touch3")
 await process_frame
 world.set_pause(true)
 await process_frame
 check(not world.touch_buttons.jump.button_pressed,"pause clears feedback")
 world.set_pause(false)
 await process_frame
 check(not world.touch_buttons.jump.button_pressed,"resume has no stale feedback")
 var finger=InputEventScreenTouch.new()
 finger.index=4
 finger.pressed=true
 finger.position=world.touch_buttons.left.get_global_rect().get_center()
 root.push_input(finger,true)
 await process_frame
 check(world.touch_buttons.left.button_pressed,"actual touch lights left")
 var drag=InputEventScreenDrag.new()
 drag.index=4
 drag.position=world.touch_buttons.right.get_global_rect().get_center()
 root.push_input(drag,true)
 await process_frame
 check(not world.touch_buttons.left.button_pressed and world.touch_buttons.right.button_pressed,"drag transfers pressed feedback")
 finger.pressed=false
 finger.canceled=true
 root.push_input(finger,true)
 await process_frame
 check(not world.touch_buttons.right.button_pressed,"cancellation clears feedback")
 print("RESULT touch feedback: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
