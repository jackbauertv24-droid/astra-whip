extends SceneTree
var world
var samples=[]
func sample(out:String,name:String,kind:String):
 if "--negative-framing" in OS.get_cmdline_user_args():world.camera.position.x=world.hero.position.x+1280
 if absf(world.hero.position.x-world.camera.position.x)>600:
  printerr("FAIL background capture:hero outside frame "+name)
  quit(1)
  return
 if kind.begins_with("actual") and not world.hero.active():
  printerr("FAIL background capture:attack not active "+name)
  quit(1)
  return
 world.background_art.update_camera()
 world.queue_redraw()
 await process_frame
 await RenderingServer.frame_post_draw
 var image=root.get_texture().get_image()
 image.save_png(out+"/"+name+".png")
 samples.append({"file":name+".png","hero":[world.hero.position.x,world.hero.position.y],"camera":[world.camera.position.x,world.camera.position.y],"image_size":[image.get_width(),image.get_height()],"framing_visible":world.background_art.framing.visible,"kind":kind})
func _initialize():call_deferred("run")
func run():
 var out=OS.get_cmdline_user_args()[0]
 DirAccess.make_dir_recursive_absolute(out)
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 world.menu_back.visible=false
 for f in [{"name":"threshold","x":160,"y":560},{"name":"bridge","x":480,"y":560},{"name":"lower-return","x":700,"y":688},{"name":"court","x":1600,"y":560},{"name":"stairs","x":2880,"y":432},{"name":"upper-platforms","x":3264,"y":432},{"name":"fallback","x":3520,"y":496},{"name":"checkpoint","x":4000,"y":560},{"name":"mixed","x":4800,"y":560},{"name":"arena","x":5900,"y":560}]:
  world.hero.reset_at(Vector2(f.x,f.y))
  for i in 4:
   await physics_frame
   world.step(1.0/120)
  world.camera_x=clampf(float(f.x)+100,640,6016)
  world.camera.position=Vector2(world.camera_x,world.playfield_camera_target())
  await sample(out,f.name,"fixed stage inspection, not traversal")
 world.restart()
 world.hero.reset_at(Vector2(160,560))
 world.camera_x=640
 world.camera.position=Vector2(640,world.playfield_camera_target())
 world.hero.controls.set_action("whip",true)
 for i in 25:
  await physics_frame
  world.step(1.0/120)
 world.hero.controls.set_action("whip",false)
 await sample(out,"ground-whip","actual input-driven active whip")
 world.hero.reset_at(Vector2(160,560))
 world.hero.controls.set_action("jump",true)
 for i in 22:
  await physics_frame
  world.step(1.0/120)
 world.hero.controls.set_action("jump",false)
 world.hero.controls.set_action("whip",true)
 for i in 24:
  await physics_frame
  world.step(1.0/120)
 world.hero.controls.set_action("whip",false)
 await sample(out,"air-whip","actual jump plus active air whip")
 world.hero.reset_at(Vector2(6000,560))
 for i in 4:
  await physics_frame
  world.step(1.0/120)
 world.camera_x=6016
 world.camera.position=Vector2(6016,world.playfield_camera_target())
 var boss=world.foes.filter(func(foe):return foe.kind=="boss")[0]
 for state in ["strike_windup","hazard_windup","hazard_execute"]:
  boss.enter(state)
  boss.elapsed=.6 if state=="strike_windup" else (.8 if state=="hazard_windup" else .15)
  boss.hazard_x=6000
  boss.visual.follow(state,boss.elapsed)
  boss.queue_redraw()
  await sample(out,state,"explicit boss state fixture; production8HP, not AI traversal")
 var file=FileAccess.open(out+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"physical_device":false,"samples":samples}," "))
 print("PASS background capture:10stage views,2actual hero attacks,3explicit boss state fixtures")
 quit()
