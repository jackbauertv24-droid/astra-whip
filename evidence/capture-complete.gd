extends SceneTree
const DT=1.0/120
var world
var output
var samples=[]
func _initialize():call_deferred("run")
func advance(ticks:int):
 for i in ticks:
  await physics_frame
  world.step(DT)
func snap(name:String):
 if absf(world.hero.position.x-world.camera.position.x)>600:
  printerr("FAIL complete capture:hero outside actual camera "+name)
  quit(1)
  return
 world.background_art.update_camera()
 world.queue_redraw()
 await process_frame
 await RenderingServer.frame_post_draw
 var image=root.get_texture().get_image()
 image.save_png(output+"/"+name+".png")
 samples.append({"file":name+".png","hero_state":world.hero.state,"hero_position":[world.hero.position.x,world.hero.position.y],"active":world.hero.active(),"image_size":[image.get_width(),image.get_height()],"physical_device":false})
func run():
 output=OS.get_cmdline_user_args()[0]
 DirAccess.make_dir_recursive_absolute(output)
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 for c in [["native",Vector2i(1280,720),Vector4.ZERO],["phone",Vector2i(852,393),Vector4(44,0,44,21)]]:
  root.size=c[1]
  for i in 5:await process_frame
  world.layout_ui_for_insets(c[2],1.0)
  world.complete=true
  world.restart()
  world.simulate_enemies=false
  world.set_pause(false)
  await advance(30)
  if world.hero.state!="idle":printerr("FAIL complete capture:standing not neutral");quit(1);return
  await snap(c[0]+"-standing")
  world.hero.controls.set_action("right",true)
  await advance(30)
  if world.hero.state!="walk":printerr("FAIL complete capture:walk not active");quit(1);return
  await snap(c[0]+"-walking")
  world.hero.reset_at(Vector2(160,Rules.GROUND))
  world.hero.controls.set_action("crouch",true)
  await advance(30)
  if world.hero.state!="crouch_idle":printerr("FAIL complete capture:crouch not active");quit(1);return
  await snap(c[0]+"-crouching")
  world.hero.reset_at(Vector2(160,Rules.GROUND))
  world.hero.controls.set_action("whip",true)
  await advance(25)
  if not world.hero.active():printerr("FAIL complete capture:strike not active");quit(1);return
  await snap(c[0]+"-mid-strike")
  world.hero.reset_at(Vector2(160,Rules.GROUND))
  world.hero.controls.set_action("jump",true)
  await advance(25)
  if world.hero.is_on_floor():printerr("FAIL complete capture:jump not airborne");quit(1);return
  await snap(c[0]+"-mid-air")
  world.restart()
  world.hero.reset_at(Vector2(6120,Rules.GROUND))
  world.simulate_enemies=true
  var boss=world.foes.filter(func(foe):return foe.kind=="boss")[0]
  var found=false
  for i in 300:
   await advance(1)
   if boss.state=="strike_windup" and boss.elapsed>=.5:
    found=true
    break
  if not found or boss.hp!=8:printerr("FAIL complete capture:production boss tell not reached");quit(1);return
  await snap(c[0]+"-boss")
 FileAccess.open(output+"/capture.json",FileAccess.WRITE).store_string(JSON.stringify({"scope":"actual input/AI state snapshots; not full playthrough or physical device","physical_device":false,"samples":samples}," "))
 print("PASS complete capture: ",samples.size(),"actual input/AI state PNGs")
 quit()
