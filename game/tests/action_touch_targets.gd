extends SceneTree
var checks=0
var failures=0
func check(ok: bool,message: String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL action touch targets: "+message)
func _initialize(): call_deferred("run")
func run():
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 for c in [[Vector2i(1280,720),1.0],[Vector2i(852,393),1.0],[Vector2i(667,375),1.0],[Vector2i(568,320),1.0],[Vector2i(1704,786),2.0]]:
  root.size=c[0]
  for frame in 5: await process_frame
  world.layout_ui_for_insets(Vector4.ZERO,c[1])
  world.set_pause(false)
  for frame in 5: await process_frame
  var scale=world.ui_units_to_css_pixels()
  var rects=[]
  for action in world.touch_buttons:
   var control=world.touch_buttons[action]
   var rect=control.get_global_rect()
   rects.append(rect)
   var pixels=rect.size*scale
   check(pixels.x>=63.99 and pixels.y>=63.99,"64CSS target "+action+" "+str(c)+" got "+str(pixels))
   check(control.get_theme_font_size("font_size")*scale.y>=15.99,"16CSS label "+action)
   check(world.ui_safe_rect.grow(.01).encloses(rect),"action stays in safe bounds")
   for down in [true,false]:
    var event=InputEventScreenTouch.new()
    event.index=19
    event.pressed=down
    event.position=rect.position+Vector2(rect.size.x*.5,2)
    root.push_input(event,true)
    await process_frame
    check(world.hero.controls.is_held(action)==down,"upper-edge touch "+action+" "+str(down))
  for i in rects.size():
   for j in range(i+1,rects.size()): check(not rects[i].intersects(rects[j]),"action targets do not overlap")
  check(world.pause_button.get_theme_font_size("font_size")*scale.y>=15.99,"pause label reads at16CSS pixels")
  world.set_pause(true)
  var corner=world.pause_button.get_global_rect().position+Vector2(2,world.pause_button.size.y-2)
  for expected in [false,true]:
   for down in [true,false]:
    var click=InputEventMouseButton.new()
    click.position=corner
    click.button_index=MOUSE_BUTTON_LEFT
    click.pressed=down
    root.push_input(click,true)
    await process_frame
   check(world.paused==expected,"pause lower-left corner is not covered by menu")
 print("RESULT action touch targets: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
