extends SceneTree
func _initialize():call_deferred("run")
func run():
 var output=OS.get_cmdline_user_args()[0]
 if "--unpacked" in OS.get_cmdline_user_args():
  PackedArt.manifest={"frames":{},"pages":[]}
  PackedArt.textures.clear()
  print("GATE_RENDER_SOURCE_MODE unpacked")
 DirAccess.make_dir_recursive_absolute(output)
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.set_pause(false)
 world.menu_back.visible=false
 world.hero.visible=false
 for foe in world.foes:foe.visible=false
 world.camera_x=6144
 world.camera.position=Vector2(6144,360)
 var pages=[]
 for fraction in [0.0,.125,.25,.5,.75,.875,1.0]:
  world.gate_open_fraction=fraction
  world.queue_redraw()
  await process_frame
  await RenderingServer.frame_post_draw
  var name="slice-%03d.png"%int(fraction*1000)
  root.get_texture().get_image().save_png(output+"/"+name)
  pages.append({"file":name,"entries":[{"gate":"left","open_fraction":fraction},{"gate":"right","open_fraction":fraction}]})
 var file=FileAccess.open(output+"/index.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"samples":14,"pages":pages}," "))
 print("PASS gate render:14partial-region samples,7images")
 quit()
