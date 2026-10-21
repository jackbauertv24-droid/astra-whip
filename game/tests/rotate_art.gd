extends SceneTree
var checks=0
var failures=0
var samples=[]
var output=""
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL rotate art: "+message)
func _initialize():call_deferred("run")
func settle():
 for i in 5:await process_frame
func capture(world,label:String):
 if output=="":return
 world.queue_redraw()
 await process_frame
 await RenderingServer.frame_post_draw
 var image=root.get_texture().get_image()
 image.save_png(output+"/"+label+".png")
 samples.append({"file":label+".png","portrait":world.is_portrait(),"graphic_visible":world.rotate_graphic.visible,"paused":world.paused,"image_size":[image.get_width(),image.get_height()],"density":world.ui_backing_ratio,"physical_device":false})
func run():
 var args=OS.get_cmdline_user_args()
 if args.size()>0 and not args[0].begins_with("--"):
  output=args[0]
  DirAccess.make_dir_recursive_absolute(output)
 var last_world
 for c in [["portrait393",Vector2i(393,852),1.0],["portrait375",Vector2i(375,667),1.0],["portrait320",Vector2i(320,568),1.0],["portrait-density2",Vector2i(786,1704),2.0],["portrait-density3",Vector2i(1179,2556),3.0],["portrait375-density2",Vector2i(750,1334),2.0],["landscape",Vector2i(1280,720),1.0],["landscape-density2",Vector2i(1136,640),2.0]]:
  if last_world!=null:
   last_world.queue_free()
   await process_frame
   last_world=null
  root.size=c[1]
  await settle()
  var world=load("res://main.tscn").instantiate()
  world.testing=true
  root.add_child(world)
  await settle()
  world.layout_ui_for_insets(Vector4(0,47,0,34) if world.is_portrait() else Vector4(44,0,44,21),c[2])
  await settle()
  if "--negative-hidden-graphic" in args:world.rotate_graphic.hide()
  var scale=world.ui_units_to_css_pixels()
  check(world.rotate_graphic.texture.get_size()==Vector2(192,128),"brief192x128 canvas")
  check(world.rotate_graphic.mouse_filter==Control.MOUSE_FILTER_IGNORE,"graphic ignores input")
  check(world.rotate_graphic.visible==world.is_portrait(),"portrait-only graphic "+c[0])
  check(world.rotate_prompt.text=="Rotate to landscape\nGame paused","wording live")
  check(world.rotate_prompt.get_theme_font_size("font_size")*scale.y>=19.99,"20CSS text")
  if world.is_portrait():
   check(world.paused and not world.menu_scroll.visible,"portrait pauses and hides menu")
   check(world.touch_buttons.values().all(func(button):return not button.visible),"portrait hides gameplay controls")
   var box=world.rotate_graphic.get_global_rect()
   check(world.ui_safe_rect.grow(.01).encloses(box),"graphic inside safe content "+c[0])
   check(box.size.y*scale.y>=47.99 and box.size.y*scale.y<=64.01,"readable48..64CSS height")
   check(is_equal_approx(box.size.x/box.size.y,1.5),"uniform3:2 aspect")
   var font=world.rotate_prompt.get_theme_font("font")
   var font_size=world.rotate_prompt.get_theme_font_size("font_size")
   var height=font.get_height(font_size)
   var text_width=font.get_string_size("Rotate to landscape",HORIZONTAL_ALIGNMENT_LEFT,-1,font_size).x
   var centre=world.rotate_prompt.get_global_rect().get_center()
   var ink=Rect2(centre-Vector2(text_width*.5,height),Vector2(text_width,height*2))
   check(not box.intersects(ink),"graphic clears live text")
   check(not box.intersects(world.pause_button.get_global_rect()),"graphic clears disabled pause")
   check(world.ui_safe_rect.grow(.01).encloses(ink),"whole wording inside safe content")
  await capture(world,c[0])
  last_world=world
 # Transition back from actual portrait with held input: explicit resume remains required.
 root.size=Vector2i(393,852)
 await settle()
 last_world.update_ui_layout()
 last_world.hero.controls.set_action("jump",true)
 last_world.update_orientation_ui()
 check(last_world.hero.controls.held.is_empty(),"portrait clears held input")
 root.size=Vector2i(852,393)
 await settle()
 last_world.update_ui_layout()
 check(last_world.paused and not last_world.rotate_graphic.visible,"landscape return hides art and waits for resume")
 last_world.set_pause(false)
 await settle()
 check(not last_world.paused and last_world.touch_buttons.values().all(func(button):return button.visible),"explicit landscape resume")
 await capture(last_world,"landscape-return-resumed")
 if output!="":FileAccess.open(output+"/capture.json",FileAccess.WRITE).store_string(JSON.stringify({"physical_device":false,"samples":samples}," "))
 print("RESULT rotate art: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
