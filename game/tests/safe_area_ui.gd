extends SceneTree
var checks=0
var failures=0
func check(ok: bool,message: String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL safe area UI: "+message)
func _initialize(): call_deferred("run")
func run():
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 var cases=[[Vector2i(1280,720),Vector4(48,32,48,28),1.0],[Vector2i(852,393),Vector4(44,0,44,21),1.0],[Vector2i(852,393),Vector4(100,24,100,32),1.0],[Vector2i(667,375),Vector4(44,0,44,21),1.0]]
 if world.has_method("layout_ui_for_insets"): cases.append([Vector2i(1704,786),Vector4(100,24,100,32),2.0])
 for c in cases:
  root.size=c[0]
  for frame in 5: await process_frame
  world.set_pause(true)
  if world.has_method("layout_ui_for_insets"): world.layout_ui_for_insets(c[1],c[2])
  world.status.text="ASTRA WHIP | HEALTH 5/5 | THE ASHEN THRESHOLD"
  for frame in 5: await process_frame
  var inset=c[1]
  var density=c[2]
  var safe=Rect2(Vector2(inset.x,inset.y)*density,Vector2(root.size)-Vector2(inset.x+inset.z,inset.y+inset.w)*density)
  var transform=root.get_final_transform()
  for control in [world.pause_button,world.menu_back,world.menu_scroll,world.status]:
   check(safe.grow(.05).encloses(transform*control.get_global_rect()),"chrome stays inside safe pixels "+str(c))
  var target=world.pause_button.size*root.get_stretch_transform().get_scale()/density
  check(target.x>=63.99 and target.y>=63.99,"pause retains64CSS pixels")
  world.set_pause(false)
  var rects=[]
  for action in world.touch_buttons:
   var rect=world.touch_buttons[action].get_global_rect()
   rects.append(rect)
   check(safe.grow(.05).encloses(transform*rect),"action inside safe area "+action+" "+str(c))
   for down in [true,false]:
    var event=InputEventScreenTouch.new()
    event.index=17
    event.pressed=down
    event.position=rect.position+Vector2(rect.size.x*.5,2)
    root.push_input(event,true)
    await process_frame
    check(world.hero.controls.is_held(action)==down,"relocated upper-edge touch "+action+" "+str(down))
  for i in rects.size():
   for j in range(i+1,rects.size()): check(not rects[i].intersects(rects[j]),"safe-area actions do not overlap")
 print("RESULT safe area UI: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
