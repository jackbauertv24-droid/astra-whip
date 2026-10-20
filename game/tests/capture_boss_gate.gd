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
 return {"file":name,"open_fraction":world.gate_open_fraction,"target_open":world.gate_target_open,"collision_layers":world.gates.map(func(gate):return gate.node.collision_layer),"arena_active":world.arena_active,"exit_unlocked":world.exit_unlocked,"boss_hp":target.hp,"boss_death_elapsed":target.elapsed if target.hp==0 else -1.0,"hero_position":[world.hero.position.x,world.hero.position.y],"paused":world.paused,"image_size":[image.get_width(),image.get_height()]}
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
 world.hero.reset_at(Vector2(5650,Rules.GROUND))
 await advance(4)
 var samples=[await snap(output,"before-entry.png")]
 world.hero.controls.set_action("right",true)
 for tick in 10:
  await advance(1)
  if world.arena_active:break
 world.hero.controls.set_action("right",false)
 var seen={}
 for tick in 32:
  if tick>0:await advance(1)
  var bucket=int(round(world.gate_open_fraction*4))
  if not seen.has(bucket):
   seen[bucket]=true
   samples.append(await snap(output,"closing-%02d.png"%bucket))
  if world.gate_open_fraction==0:break
 for direction in [-1,1]:
  world.hero.reset_at(Vector2(5680 if direction<0 else 6460,Rules.GROUND))
  world.hero.controls.set_action("left" if direction<0 else "right",true)
  await advance(60)
  world.hero.controls.set_action("left" if direction<0 else "right",false)
  samples.append(await snap(output,"blocked-"+("left" if direction<0 else "right")+".png"))
 # Isolated standing contact fixture, all eight production HP earned by whips.
 target.hp=8
 var hits=[]
 for hit in 8:
  if not await actual_hit(1):
   printerr("FAIL gate capture actual8HP boss prelude")
   quit(1)
   return
  hits.append(target.hp)
 await advance(129)
 samples.append(await snap(output,"before-unlock.png"))
 seen={}
 for tick in 33:
  await advance(1)
  var bucket=int(round(world.gate_open_fraction*4))
  if not seen.has(bucket):
   seen[bucket]=true
   samples.append(await snap(output,"opening-%02d.png"%bucket))
   if bucket==2:
    var fraction:float=world.gate_open_fraction
    world.set_pause(true)
    world.menu.visible=false
    world.menu_scroll.visible=false
    world.menu_back.visible=false
    world.testing=false
    world._physics_process(.2)
    world.testing=true
    if world.gate_open_fraction!=fraction:
     printerr("FAIL gate capture pause")
     quit(1)
     return
    samples.append(await snap(output,"paused-opening.png"))
    world.set_pause(false)
  if world.gate_open_fraction==1:break
 samples.append(await snap(output,"fully-open.png"))
 for direction in [-1,1]:
  world.hero.reset_at(Vector2(5680 if direction<0 else 6460,Rules.GROUND))
  world.hero.controls.set_action("left" if direction<0 else "right",true)
  await advance(60)
  world.hero.controls.set_action("left" if direction<0 else "right",false)
  samples.append(await snap(output,"passed-"+("left" if direction<0 else "right")+".png"))
 world.restart()
 target=world.foes.filter(func(foe):return foe.kind=="boss")[0]
 for foe in world.foes:foe.visible=false
 samples.append(await snap(output,"restart-raised.png"))
 var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"physical_device":false,"viewport":root.size,"actual_hits":hits,"fixture":"isolated standing boss contacts, production8HP; actual entry/block/unlock/pass","samples":samples}," "))
 print("PASS boss gate capture:entry,close,blocking,8actualwhips,1080msdeathunlock,open,pause,pass,restart")
 quit()
