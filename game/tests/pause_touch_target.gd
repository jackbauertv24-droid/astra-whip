extends SceneTree
var failures=0
var checks=0
func check(ok: bool,message: String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL pause touch target: "+message)
func _initialize():
 call_deferred("run")
func run():
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 var records=[]
 for size in [Vector2i(1280,720),Vector2i(852,393),Vector2i(667,375),Vector2i(393,852)]:
  root.size=size
  for frame in 4: await process_frame
  var scale=root.get_stretch_transform().get_scale()
  var rect=world.pause_button.get_global_rect()
  var pixels=rect.size*scale
  var view=root.get_visible_rect()
  check(pixels.x>=63.99 and pixels.y>=63.99,"64px pause/resume target at "+str(size)+" got "+str(pixels))
  check(view.encloses(rect),"target stays inside content viewport "+str(size))
  for paused in [true,false]:
   world.set_pause(paused)
   # Dispatch through the GUI hit test at the enlarged lower edge.
   var point=rect.position+Vector2(rect.size.x*.5,rect.size.y-2)
   var event=InputEventMouseButton.new()
   event.button_index=MOUSE_BUTTON_LEFT
   event.position=point
   event.pressed=true
   root.push_input(event,true)
   await process_frame
   event=InputEventMouseButton.new()
   event.button_index=MOUSE_BUTTON_LEFT
   event.position=point
   event.pressed=false
   root.push_input(event,true)
   await process_frame
   check(world.paused!=paused,"lower-edge GUI click toggles pause/resume "+str(size))
  records.append({"window":[size.x,size.y],"scale":[scale.x,scale.y],"target_px":[pixels.x,pixels.y]})
 print("PAUSE_TARGET_SAMPLES ",JSON.stringify(records))
 print("RESULT pause touch target: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
