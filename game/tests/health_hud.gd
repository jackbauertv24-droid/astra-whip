extends SceneTree
var checks=0
var failures=0
var samples=[]
var output=""
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL health HUD: "+message)
func _initialize():call_deferred("run")
func capture(world,label:String):
 if output=="":return
 world.queue_redraw()
 await process_frame
 await RenderingServer.frame_post_draw
 var image=root.get_texture().get_image()
 image.save_png(output+"/"+label+".png")
 samples.append({"file":label+".png","health":world.hero.health,"image_size":[image.get_width(),image.get_height()],"density":world.ui_backing_ratio,"source":"damage-method UI fixture, not combat traversal","physical_device":false})
func run():
 var args=OS.get_cmdline_user_args()
 if args.size()>0 and not args[0].begins_with("--"):
  output=args[0]
  DirAccess.make_dir_recursive_absolute(output)
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 await process_frame
 if "--negative-freeze-hud" in args:world.set_process(false)
 for c in [["native",Vector2i(1280,720),1.0,Vector4.ZERO],["phone",Vector2i(852,393),1.0,Vector4(44,0,44,21)],["compact",Vector2i(568,320),1.0,Vector4(44,0,44,21)],["density2",Vector2i(1704,786),2.0,Vector4(44,0,44,21)]]:
  root.size=c[1]
  for i in 5:await process_frame
  world.layout_ui_for_insets(c[3],c[2])
  world.restart()
  world.set_pause(false)
  world.menu_back.visible=false
  for i in 4:
   await physics_frame
   world.step(1.0/120)
  for health in range(5,-1,-1):
   if health<5:
    world.hero.invulnerable=0
    world.hero.damage("projectile",world.hero.position.x-40)
   for i in 2:await process_frame
   var filled=world.health_pips.filter(func(pip):return pip.texture==world.health_full).size()
   check(world.hero.health==health,"real damage updates health")
   check(world.health_pips.size()==5 and filled==health,"filled/empty health count "+c[0]+str(health))
   check(world.status.text.contains("HEALTH %d/5"%health),"live numeric health "+str(health))
   var scale=world.ui_units_to_css_pixels()
   for pip in world.health_pips:
    check(world.ui_safe_rect.grow(.01).encloses(pip.get_global_rect()),"pip inside safe area")
    check(pip.size.x*scale.x>=23.99 and pip.size.y*scale.y>=23.99,"24CSS readable pip")
    check(pip.mouse_filter==Control.MOUSE_FILTER_IGNORE,"decorative pip does not consume touch")
   check(world.status.get_theme_font_size("font_size")*scale.y>=15.99,"live HUD text16CSS")
   check(not world.status.get_global_rect().intersects(world.pause_button.get_global_rect()),"health text clears pause")
   await capture(world,c[0]+"-health-"+str(health))
  world.restart()
  for i in 2:await process_frame
  check(world.health_pips.all(func(pip):return pip.texture==world.health_full),"retry restores five filled pips")
 root.size=Vector2i(393,852)
 for i in 5:await process_frame
 world.update_ui_layout()
 for i in 2:await process_frame
 check(world.health_pips.all(func(pip):return not pip.visible),"portrait hides health graphics")
 check(not world.status.visible,"portrait hides live HUD text")
 await capture(world,"portrait-hidden")
 if output!="":
  var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
  file.store_string(JSON.stringify({"physical_device":false,"samples":samples}," "))
 print("RESULT health HUD: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
