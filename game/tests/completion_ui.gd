extends SceneTree
var checks=0
var failures=0
var samples=[]
var output=""
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL completion UI: "+message)
func _initialize():call_deferred("run")
func settle():
 for i in 4:await process_frame
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
 samples.append({"file":label+".png","complete":world.complete,"checkpoint":world.checkpoint,"health":world.hero.health,"victory_visible":world.victory_row.is_visible_in_tree(),"image_size":[image.get_width(),image.get_height()],"density":world.ui_backing_ratio,"physical_device":false})
func click_retry(world):
 world.menu_scroll.ensure_control_visible(world.retry_button)
 await settle()
 var point=world.retry_button.get_global_rect().get_center()
 check(world.menu_scroll.get_global_rect().has_point(point),"scrolled retry centre visible")
 for down in [true,false]:
  var event=InputEventMouseButton.new()
  event.position=point
  event.button_index=MOUSE_BUTTON_LEFT
  event.pressed=down
  root.push_input(event,true)
  await process_frame
 await settle()
func run():
 var args=OS.get_cmdline_user_args()
 if args.size()>0 and not args[0].begins_with("--"):
  output=args[0]
  DirAccess.make_dir_recursive_absolute(output)
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 await settle()
 check(world.retry_button.icon.get_size()==Vector2(128,128),"retry brief source canvas")
 check(world.victory_icon.texture.get_size()==Vector2(128,128),"victory brief source canvas")
 if "--negative-freeze-ui" in args:world.set_process(false)
 for c in [["native",Vector2i(1280,720),1.0,Vector4.ZERO],["phone",Vector2i(852,393),1.0,Vector4(44,0,44,21)],["compact",Vector2i(568,320),1.0,Vector4(44,0,44,21)],["density2",Vector2i(1704,786),2.0,Vector4(44,0,44,21)]]:
  root.size=c[1]
  await settle()
  world.layout_ui_for_insets(c[3],c[2])
  world.complete=true
  world.restart()
  world.capture_checkpoint()
  world.hero.health=2
  world.set_pause(true)
  await settle()
  var scale=world.ui_units_to_css_pixels()
  check(not world.victory_row.visible,"victory hidden during ordinary pause")
  check(world.touch_buttons.values().all(func(button):return not button.visible),"pause menu hides competing gameplay controls")
  check(world.retry_button.get_theme_constant("icon_max_width")*scale.x>=31.99,"retry icon32CSS")
  check(world.retry_button.size.y*scale.y>=63.99,"retry64CSS touch target")
  check(world.retry_button.text=="RETRY FROM CHECKPOINT","retry wording live")
  check(world.victory_caption.text=="STAGE CLEAR","victory wording live")
  check((world.victory_icon.custom_minimum_size*scale).is_equal_approx(Vector2(48,48)),"victory48CSS")
  check(world.victory_icon.mouse_filter==Control.MOUSE_FILTER_IGNORE,"victory art ignores input")
  world.menu_scroll.ensure_control_visible(world.retry_button)
  await settle()
  await capture(world,c[0]+"-pause-retry")
  await click_retry(world)
  check(world.hero.health==5 and world.checkpoint and not world.complete,"actual pause retry restores checkpoint")
  world.set_pause(false)
  await settle()
  await capture(world,c[0]+"-checkpoint-retried")
  # Isolated unlocked-exit fixture; actual boss/death unlock is covered by exit_art.gd.
  world.exit_unlocked=true
  world.hero.reset_at(Vector2(6595,Rules.GROUND))
  world.hero.controls.set_action("right",true)
  for i in 8:
   await physics_frame
   world.step(1.0/120)
  world.hero.controls.set_action("right",false)
  await settle()
  check(world.complete and world.victory_row.is_visible_in_tree() and world.menu_scroll.visible and world.menu_back.visible,"actual unlocked exit shows victory")
  check(world.status.text=="STAGE CLEAR","completion HUD wording fits")
  check(world.touch_buttons.values().all(func(button):return not button.visible),"completion menu hides competing gameplay controls")
  check(world.status.get_theme_font("font").get_string_size(world.status.text,HORIZONTAL_ALIGNMENT_LEFT,-1,world.status.get_theme_font_size("font_size")).x<=world.status.size.x,"whole stage-clear text")
  world.menu_scroll.scroll_vertical=0
  await settle()
  await capture(world,c[0]+"-victory-top")
  world.menu_scroll.ensure_control_visible(world.retry_button)
  await settle()
  await capture(world,c[0]+"-victory-retry")
  await click_retry(world)
  check(not world.complete and not world.checkpoint and world.hero.health==5,"actual completion retry starts whole stage")
  check(not world.victory_row.visible,"retry clears victory art")
  world.set_pause(false)
  await settle()
  check(world.touch_buttons.values().all(func(button):return button.visible),"resume restores gameplay controls")
  await capture(world,c[0]+"-completion-retried")
 root.size=Vector2i(393,852)
 await settle()
 world.complete=true
 world.update_ui_layout()
 await settle()
 check(not world.victory_row.is_visible_in_tree(),"portrait hides completion menu")
 await capture(world,"portrait-hidden")
 if output!="":FileAccess.open(output+"/capture.json",FileAccess.WRITE).store_string(JSON.stringify({"physical_device":false,"source":"unlocked-exit/menu UI fixture, not full boss traversal","samples":samples}," "))
 print("RESULT completion UI: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
