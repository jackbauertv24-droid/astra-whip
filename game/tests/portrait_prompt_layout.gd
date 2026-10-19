extends SceneTree
var checks=0
var failures=0
func check(ok: bool,message: String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL portrait prompt layout: "+message)
func _initialize():
 call_deferred("run")
func run():
 for size in [Vector2i(1280,720),Vector2i(393,852),Vector2i(375,667)]:
  root.size=size
  for frame in 3: await process_frame
  var world=load("res://main.tscn").instantiate()
  world.testing=true
  root.add_child(world)
  for frame in 4: await process_frame
  var rect=world.rotate_prompt.get_rect()
  var view=root.get_visible_rect()
  check(view.encloses(rect),"startup text box fits "+str(size)+" got "+str(rect))
  check(absf(rect.get_center().y-view.get_center().y)<=1,"startup text box centered "+str(size))
  var font_pixels=world.rotate_prompt.get_theme_font_size("font_size")*world.ui_units_to_css_pixels().y
  check(font_pixels>=19.99,"prompt type at least20px "+str(size))
  world.queue_free()
  await process_frame
 print("RESULT portrait prompt layout: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
