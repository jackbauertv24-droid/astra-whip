extends SceneTree
var checks=0
var failures=0
func check(ok: bool,message: String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL menu touch targets: "+message)
func click_at(point: Vector2):
 for down in [true,false]:
  var event=InputEventMouseButton.new()
  event.position=point
  event.button_index=MOUSE_BUTTON_LEFT
  event.pressed=down
  root.push_input(event,true)
  await process_frame
func _initialize():
 call_deferred("run")
func run():
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 var samples=[]
 for size in [Vector2i(1280,720),Vector2i(852,393),Vector2i(667,375)]:
  root.size=size
  for frame in 6: await process_frame
  world.set_pause(true)
  var scale=world.ui_units_to_css_pixels()
  var scroll=world.get("menu_scroll")
  check(scroll!=null,"scroll container exists "+str(size))
  if scroll!=null: check(world.menu_back.get_global_rect().grow(.01).encloses(scroll.get_global_rect()),"scroll area stays inside menu panel")
  check(root.get_visible_rect().encloses(world.menu_back.get_rect()),"menu panel fits viewport")
  for control in world.menu.get_children():
   if not (control is BaseButton or control is Range): continue
   world.set_pause(true)
   if scroll!=null: scroll.ensure_control_visible(control)
   for frame in 3: await process_frame
   var rect=control.get_global_rect()
   var pixels=rect.size*scale
   check(pixels.x>=63.99 and pixels.y>=63.99,"64px control "+control.get_class()+" at "+str(size)+" got "+str(pixels))
   var visible=rect.intersection(scroll.get_global_rect()) if scroll!=null else rect
   check(visible.size.x*scale.x>=63 and visible.size.y*scale.y>=63,"full target scrolls into view")
   if control is Range: control.value=.3
   var events={"count":0}
   if control is BaseButton: control.pressed.connect(func(): events.count+=1,CONNECT_ONE_SHOT)
   else: control.value_changed.connect(func(_value): events.count+=1,CONNECT_ONE_SHOT)
   var point=visible.position+visible.size*Vector2(.85,.5)
   await click_at(point)
   check(events.count>0,"real GUI interaction "+control.get_class())
   samples.append({"window":[size.x,size.y],"control":control.get_class(),"target_pixels":[pixels.x,pixels.y]})
  # A gesture over an interactive child must reach the scroll container.
  world.set_pause(true)
  if scroll!=null:
   scroll.scroll_vertical=0
   for frame in 3: await process_frame
   var gesture=InputEventPanGesture.new()
   gesture.position=world.menu.get_child(3).get_global_rect().get_center()
   gesture.delta=Vector2(0,1)
   root.push_input(gesture,true)
   for frame in 2: await process_frame
   check(scroll.scroll_vertical>0,"gesture over menu button scrolls")
   check(world.paused,"gesture does not activate menu button")
 print("MENU_TARGET_SAMPLES ",JSON.stringify(samples))
 print("RESULT menu touch targets: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
