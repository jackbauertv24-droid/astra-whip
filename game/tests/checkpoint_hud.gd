extends SceneTree
var checks=0
var failures=0
var samples=[]
var output=""
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL checkpoint HUD: "+message)
func _initialize():call_deferred("run")
func capture(world,label:String):
 if output=="":return
 world.camera_x=clampf(world.hero.position.x+100,640,Rules.WIDTH-640)
 world.camera.position=Vector2(world.camera_x,world.playfield_camera_target())
 world.background_art.update_camera()
 world.queue_redraw()
 await process_frame
 await RenderingServer.frame_post_draw
 var image=root.get_texture().get_image()
 image.save_png(output+"/"+label+".png")
 samples.append({"file":label+".png","checkpoint":world.checkpoint,"health":world.hero.health,"image_size":[image.get_width(),image.get_height()],"density":world.ui_backing_ratio,"physical_device":false})
func inspect(world,active:bool,label:String):
 for i in 2:await process_frame
 check(world.checkpoint==active,"checkpoint state "+label)
 check(world.checkpoint_icon.texture==world.checkpoint_ui_frames[1 if active else 0],"paint matches checkpoint "+label)
 check(world.checkpoint_icon.tooltip_text==("Checkpoint lit" if active else "Checkpoint inactive"),"live accessible description "+label)
 var scale=world.ui_units_to_css_pixels()
 check((world.checkpoint_icon.size*scale).is_equal_approx(Vector2(32,24)),"32x24CSS indicator "+label)
 check(world.ui_safe_rect.grow(.01).encloses(world.checkpoint_icon.get_global_rect()),"indicator inside safe area")
 check(world.checkpoint_icon.mouse_filter==Control.MOUSE_FILTER_IGNORE,"indicator ignores touch")
 check(world.health_pips.all(func(pip):return not pip.get_global_rect().intersects(world.checkpoint_icon.get_global_rect())),"indicator clears health pips")
 check(not world.status.get_global_rect().intersects(world.checkpoint_icon.get_global_rect()),"live text clears indicator")
 check(not world.pause_button.get_global_rect().intersects(world.checkpoint_icon.get_global_rect()),"indicator clears pause")
 var font=world.status.get_theme_font("font")
 check(font.get_string_size(world.status.text,HORIZONTAL_ALIGNMENT_LEFT,-1,world.status.get_theme_font_size("font_size")).x<=world.status.size.x+.01,"whole live HUD wording fits "+label)
 check(world.status.text.contains("HEALTH %d/5"%world.hero.health),"health remains first and complete")
 await capture(world,label)
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
 check(world.checkpoint_ui_frames.size()==2 and world.checkpoint_ui_frames[0]!=world.checkpoint_ui_frames[1],"two distinct checkpoint sources")
 for texture in world.checkpoint_ui_frames:check(texture.get_size()==Vector2(128,96),"brief canvas")
 if "--negative-freeze-hud" in args:world.set_process(false)
 for c in [["native",Vector2i(1280,720),1.0,Vector4.ZERO],["phone",Vector2i(852,393),1.0,Vector4(44,0,44,21)],["compact",Vector2i(568,320),1.0,Vector4(44,0,44,21)],["density2",Vector2i(1704,786),2.0,Vector4(44,0,44,21)]]:
  root.size=c[1]
  for i in 5:await process_frame
  world.layout_ui_for_insets(c[3],c[2])
  world.complete=true
  world.restart()
  world.set_pause(false)
  world.menu_back.visible=false
  await inspect(world,false,c[0]+"-off")
  world.hero.reset_at(Vector2(4050,Rules.GROUND))
  world.hero.controls.set_action("right",true)
  for i in 80:
   await physics_frame
   world.step(1.0/120)
   if world.checkpoint:break
  world.hero.controls.set_action("right",false)
  await inspect(world,true,c[0]+"-on")
  check(world.respawn==Vector2(4128,Rules.GROUND),"actual grounded approach sets respawn")
  world.pit_fall()
  await inspect(world,true,c[0]+"-pit-pending")
  for i in 100:
   await physics_frame
   world.step(1.0/120)
  check(world.pit_timer<0 and world.hero.health==5,"pit timer actually retries")
  await inspect(world,true,c[0]+"-retry-on")
  world.complete=true
  world.restart()
  await inspect(world,false,c[0]+"-completion-reset")
 root.size=Vector2i(393,852)
 for i in 5:await process_frame
 world.update_ui_layout()
 for i in 2:await process_frame
 check(not world.checkpoint_icon.visible,"portrait hides checkpoint")
 await capture(world,"portrait-hidden")
 if output!="":FileAccess.open(output+"/capture.json",FileAccess.WRITE).store_string(JSON.stringify({"physical_device":false,"samples":samples}," "))
 print("RESULT checkpoint HUD: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
