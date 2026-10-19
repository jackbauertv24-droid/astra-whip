extends SceneTree
var checks=0
var failures=0
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL touch cancellation: "+message)
func _initialize(): call_deferred("run")
func touch(world,index:int,action:String,down:bool,canceled:bool=false):
 var event=InputEventScreenTouch.new()
 event.index=index
 event.position=world.touch_buttons[action].get_global_rect().get_center()
 event.pressed=down
 event.canceled=canceled
 root.push_input(event,true)
func run():
 root.size=Vector2i(1280,720)
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 for frame in 5: await process_frame
 world.set_pause(false)
 world.hero.controls.set_action("left",true,"keyboard")
 touch(world,1,"jump",true)
 touch(world,2,"whip",true)
 check(world.hero.controls.is_held("left"),"keyboard initially held")
 check(world.hero.controls.is_held("jump"),"first finger initially held")
 check(world.hero.controls.is_held("whip"),"second finger initially held")
 touch(world,2,"whip",false)
 check(world.hero.controls.is_held("left") and world.hero.controls.is_held("jump"),"ordinary release preserves other sources")
 check(not world.hero.controls.is_held("whip"),"ordinary release clears its source")
 touch(world,2,"whip",true)
 touch(world,1,"jump",false,true)
 check(world.hero.controls.held.is_empty(),"cancellation clears all sources")
 check(world.hero.controls.edges.is_empty(),"cancellation clears buffered edges")
 var stale_drag=InputEventScreenDrag.new()
 stale_drag.index=2
 stale_drag.position=world.touch_buttons.right.get_global_rect().get_center()
 root.push_input(stale_drag,true)
 check(world.hero.controls.held.is_empty(),"canceled finger drag cannot reactivate input")
 touch(world,3,"right",true)
 check(world.hero.controls.is_held("right"),"fresh touch works after cancellation")
 check(not world.hero.controls.is_held("left") and not world.hero.controls.is_held("whip"),"stale sources remain released")
 touch(world,3,"right",false)
 check(world.hero.controls.held.is_empty(),"fresh release clears hold")
 print("RESULT touch cancellation: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
