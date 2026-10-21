extends SceneTree
var world
var output
var samples=[]
func _initialize():call_deferred("run")
func settle():
 for i in 4:await process_frame
func snap(name:String):
 world.camera_x=clampf(world.hero.position.x+100,640,Rules.WIDTH-640)
 world.camera.position=Vector2(world.camera_x,world.playfield_camera_target())
 world.background_art.update_camera()
 world.queue_redraw()
 await settle()
 await RenderingServer.frame_post_draw
 var image=root.get_texture().get_image()
 image.save_png(output+"/"+name+".png")
 samples.append({"file":name+".png","health":world.hero.health,"checkpoint":world.checkpoint,"complete":world.complete,"image_size":[image.get_width(),image.get_height()],"physical_device":false})
func run():
 output=OS.get_cmdline_user_args()[0]
 DirAccess.make_dir_recursive_absolute(output)
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 await settle()
 for c in [["native",Vector2i(1280,720),1.0,Vector4.ZERO],["phone",Vector2i(852,393),1.0,Vector4(44,0,44,21)]]:
  root.size=c[1]
  await settle()
  world.layout_ui_for_insets(c[3],c[2])
  world.complete=true
  world.restart()
  world.set_pause(false)
  await snap(c[0]+"-opening")
  for action in world.touch_buttons:world.hero.controls.set_action(action,true)
  await snap(c[0]+"-held-controls")
  world.hero.controls.clear()
  world.impact_layer.spawn_at(world.hero.position+Vector2(70,-64))
  world.impact_layer.advance(.08)
  await snap(c[0]+"-whip-impact")
  world.impact_layer.clear()
  world.defeat_layer.spawn_at(world.hero.position+Vector2(100,0))
  world.defeat_layer.advance(.2)
  await snap(c[0]+"-enemy-defeat")
  world.defeat_layer.clear()
  world.hero.reset_at(Vector2(4128,Rules.GROUND))
  world.step(0)
  world.checkpoint_layer.advance(.18)
  for i in 3:
   world.hero.invulnerable=0
   world.hero.damage("projectile",world.hero.position.x-40)
  await snap(c[0]+"-checkpoint-health2")
  world.set_pause(true)
  world.menu_scroll.ensure_control_visible(world.retry_button)
  await snap(c[0]+"-pause-retry")
  world.set_pause(false)
  world.exit_unlocked=true
  world.hero.reset_at(Vector2(6612,Rules.GROUND))
  world.step(0)
  world.menu_scroll.scroll_vertical=0
  await snap(c[0]+"-victory-top")
  world.menu_scroll.ensure_control_visible(world.retry_button)
  await snap(c[0]+"-victory-retry")
 for c in [["portrait",Vector2i(393,852),1.0],["portrait-density3",Vector2i(1179,2556),3.0]]:
  root.size=c[1]
  await settle()
  world.layout_ui_for_insets(Vector4.ZERO,c[2])
  await snap(c[0])
 FileAccess.open(output+"/capture.json",FileAccess.WRITE).store_string(JSON.stringify({"scope":"sampling integration still fixtures, not combat animation/traversal","physical_device":false,"samples":samples}," "))
 print("PASS sampling capture: ",samples.size()," actual PNGs")
 quit()
