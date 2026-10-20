extends SceneTree
var checks=0
var failures=0
var output=""
var samples=[]
var world
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL painted controls: "+message)
func _initialize():call_deferred("run")
func settle():
 for i in 2:await process_frame
func capture(name:String):
 if output=="":return
 world.queue_redraw()
 await process_frame
 await RenderingServer.frame_post_draw
 var image=root.get_texture().get_image()
 image.save_png(output+"/"+name+".png")
 var states={}
 for action in world.painted_controls.entries:
  var e=world.painted_controls.entries[action]
  states[action]={"pressed":e.control.button_pressed,"painted_pressed":e.plate.texture==e.frames[1],"live_text":e.control.text}
 samples.append({"file":name+".png","image_size":[image.get_width(),image.get_height()],"density":world.ui_backing_ratio,"states":states,"physical_device":false})
func mouse(down:bool):
 var event=InputEventMouseButton.new()
 event.position=world.pause_button.get_global_rect().get_center()
 event.button_index=MOUSE_BUTTON_LEFT
 event.pressed=down
 root.push_input(event,true)
 await settle()
func run():
 var args=OS.get_cmdline_user_args()
 if args.size()>0 and not args[0].begins_with("--"):
  output=args[0]
  DirAccess.make_dir_recursive_absolute(output)
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 await process_frame
 if "--negative-freeze-paint" in args:world.set_process(false)
 for c in [["native",Vector2i(1280,720),1.0,Vector4.ZERO],["phone",Vector2i(852,393),1.0,Vector4(44,0,44,21)],["compact",Vector2i(568,320),1.0,Vector4(44,0,44,21)],["density2",Vector2i(1704,786),2.0,Vector4(44,0,44,21)]]:
  root.size=c[1]
  for i in 5:await process_frame
  world.layout_ui_for_insets(c[3],c[2])
  world.restart()
  world.set_pause(false)
  world.menu_back.visible=false
  await settle()
  var scale=world.ui_units_to_css_pixels()
  check(world.painted_controls.entries.size()==6,"six control assets")
  for action in world.painted_controls.entries:
   var e=world.painted_controls.entries[action]
   check(e.frames[0]!=e.frames[1],"separate normal/pressed source "+action)
   check(e.frames[0].get_size()==Vector2(128,128) and e.frames[1].get_size()==Vector2(128,128),"128px state canvas "+action)
   check(e.control.size.x*scale.x>=63.99 and e.control.size.y*scale.y>=63.99,"64CSS hit target "+action)
   check(e.control.get_theme_font_size("font_size")*scale.y>=15.99,"16CSS live label "+action)
   check(e.control.text==action.to_upper(),"wording is live Button text "+action)
   check(e.plate.mouse_filter==Control.MOUSE_FILTER_IGNORE,"paint does not intercept pointer "+action)
   check(e.plate.show_behind_parent,"paint stays behind live text "+action)
   check(world.ui_safe_rect.grow(.01).encloses(e.control.get_global_rect()),"target inside safe area "+action)
   check(e.plate.texture==e.frames[0],"initial normal paint "+action)
  await capture(c[0]+"-normal")
  for action in world.touch_buttons:
   var e=world.painted_controls.entries[action]
   world.hero.controls.set_action(action,true,"keyboard")
   await settle()
   check(e.control.button_pressed and e.plate.texture==e.frames[1],"held keyboard paints pressed "+action)
   if c[0] in ["native","phone"]:await capture(c[0]+"-pressed-"+action)
   world.hero.controls.set_action(action,true,"touch99")
   world.hero.controls.set_action(action,false,"keyboard")
   await settle()
   check(e.plate.texture==e.frames[1],"second held source keeps pressed paint "+action)
   world.hero.controls.set_action(action,false,"touch99")
   await settle()
   check(e.plate.texture==e.frames[0],"last release returns normal paint "+action)
  if c[0] in ["compact","density2"]:
   for action in world.touch_buttons:world.hero.controls.set_action(action,true,"fixture")
   await settle()
   await capture(c[0]+"-all-held")
   world.hero.controls.clear()
   await settle()
  await mouse(true)
  check(world.pause_button.button_pressed and world.painted_controls.entries.pause.plate.texture==world.painted_controls.entries.pause.frames[1],"actual pause mouse-down paints pressed")
  if c[0] in ["native","phone"]:await capture(c[0]+"-pressed-pause")
  await mouse(false)
  check(world.paused and world.pause_button.text=="RESUME","actual pause release opens menu/live resume")
  check(world.painted_controls.entries.pause.plate.texture==world.painted_controls.entries.pause.frames[0],"pause release returns normal paint")
  world.set_pause(false)
  var finger=InputEventScreenTouch.new()
  finger.index=4
  finger.pressed=true
  finger.position=world.touch_buttons.left.get_global_rect().get_center()
  root.push_input(finger,true)
  await settle()
  check(world.painted_controls.entries.left.plate.texture==world.painted_controls.entries.left.frames[1],"actual touch paints left")
  var drag=InputEventScreenDrag.new()
  drag.index=4
  drag.position=world.touch_buttons.right.get_global_rect().get_center()
  root.push_input(drag,true)
  await settle()
  check(world.painted_controls.entries.left.plate.texture==world.painted_controls.entries.left.frames[0] and world.painted_controls.entries.right.plate.texture==world.painted_controls.entries.right.frames[1],"drag transfers painted feedback")
  finger.pressed=false
  finger.canceled=true
  root.push_input(finger,true)
  await settle()
  check(world.painted_controls.entries.right.plate.texture==world.painted_controls.entries.right.frames[0],"cancellation clears paint")
 root.size=Vector2i(393,852)
 for i in 5:await process_frame
 world.update_ui_layout()
 await settle()
 check(world.pause_button.disabled,"portrait pause disabled")
 check(world.touch_buttons.values().all(func(button):return not button.visible),"portrait hides gameplay controls")
 await capture("portrait-disabled")
 if output!="":
  var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
  file.store_string(JSON.stringify({"physical_device":false,"samples":samples,"scope":"UI state/input fixtures; not traversal or physical-device proof"}," "))
 print("RESULT painted controls: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
