extends "res://tests/enemy_defeat.gd"
func advance(ticks:int):
 for tick in ticks:
  await physics_frame
  var all_foes:Array=world.foes
  world.foes=[target] if is_instance_valid(target) else []
  world.step(DT)
  world.foes=all_foes
  world.camera_x=6144
  world.camera.position=Vector2(6144,360)
  world.queue_redraw()
func snap(output:String,name:String)->Dictionary:
 world.queue_redraw()
 await process_frame
 await RenderingServer.frame_post_draw
 var image=root.get_texture().get_image()
 image.save_png(output+"/"+name)
 return {"file":name,"exit_unlocked":world.exit_unlocked,"ember_tint":world.exit_material.get_shader_parameter("unlocked"),"complete":world.complete,"boss_hp":target.hp,"death_elapsed":target.elapsed if target.hp==0 else -1.0,"hero_position":[world.hero.position.x,world.hero.position.y],"facing":world.hero.facing,"paused":world.paused,"image_size":[image.get_width(),image.get_height()]}
func run():
 var output=OS.get_cmdline_user_args()[0]
 DirAccess.make_dir_recursive_absolute(output)
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=true
 world.set_pause(false)
 world.menu_back.visible=false
 target=world.foes.filter(func(foe):return foe.kind=="boss")[0]
 for foe in world.foes:foe.visible=foe==target
 target.hp=8
 var hits=[]
 for hit in 7:
  if not await actual_hit(1):
   printerr("FAIL exit capture actual prelude")
   quit(1)
   return
  hits.append(target.hp)
 var samples=[await snap(output,"locked-before-lethal.png")]
 world.hero.reset_at(Vector2(6550,Rules.GROUND))
 world.hero.facing=-1
 await advance(4)
 samples.append(await snap(output,"locked-near-left.png"))
 if not await actual_hit(1):
  printerr("FAIL exit capture actual lethal")
  quit(1)
  return
 hits.append(target.hp)
 samples.append(await snap(output,"death-start-locked.png"))
 await advance(129)
 samples.append(await snap(output,"before-unlock.png"))
 await advance(1)
 samples.append(await snap(output,"unlocked.png"))
 world.set_pause(true)
 world.menu.visible=false
 world.menu_scroll.visible=false
 world.menu_back.visible=false
 world.testing=false
 world._physics_process(.2)
 world.testing=true
 samples.append(await snap(output,"paused-unlocked.png"))
 world.set_pause(false)
 for direction in [1,-1]:
  world.hero.reset_at(Vector2(6550,Rules.GROUND))
  world.hero.facing=direction
  await advance(4)
  samples.append(await snap(output,"unlocked-near-"+("right" if direction>0 else "left")+".png"))
 world.hero.reset_at(Vector2(6550,Rules.GROUND))
 world.hero.facing=1
 world.hero.controls.set_action("right",true)
 for tick in 60:
  await advance(1)
  if world.complete:break
 if not world.complete:
  printerr("FAIL exit capture actual completion walk")
  quit(1)
  return
 samples.append(await snap(output,"completed.png"))
 world.restart()
 target=world.foes.filter(func(foe):return foe.kind=="boss")[0]
 for foe in world.foes:foe.visible=false
 world.hero.reset_at(Vector2(6550,Rules.GROUND))
 samples.append(await snap(output,"retry-relocked.png"))
 var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"physical_device":false,"viewport":root.size,"actual_hits":hits,"fixture":"isolated standing boss contacts preserving8HP; actual final approach/completion","samples":samples}," "))
 print("PASS exit capture:8actualwhips,locked,1080msdeathunlock,Embertint,bothfacings,pause,actualcompletion,retryrelock")
 quit()
