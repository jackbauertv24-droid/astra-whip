extends "res://tests/checkpoint_art.gd"
var sequence_time=-1.0
func advance(ticks:int):
 for tick in ticks:
  await physics_frame
  world.step(DT)
  if sequence_time>=0:sequence_time+=DT
  world.camera_x=4128
  world.camera.position=Vector2(4128,360)
  world.queue_redraw()
func snap(output:String,name:String)->Dictionary:
 world.queue_redraw()
 await process_frame
 await RenderingServer.frame_post_draw
 var image=root.get_texture().get_image()
 image.save_png(output+"/"+name)
 var layer=world.checkpoint_layer
 var age:float=layer.bursts[0].age if not layer.bursts.is_empty() else -1.0
 return {"file":name,"checkpoint":world.checkpoint,"marker_state":1 if world.checkpoint else 0,"hero_position":[world.hero.position.x,world.hero.position.y],"hero_health":world.hero.health,"respawn":[world.respawn.x,world.respawn.y],"burst_count":layer.bursts.size(),"effect_frame":layer.frame_at(age),"effect_age":age,"effect_position":[layer.bursts[0].position.x,layer.bursts[0].position.y] if not layer.bursts.is_empty() else [],"sequence_elapsed":sequence_time,"reduced_effects":world.reduced_effects,"paused":world.paused,"image_size":[image.get_width(),image.get_height()]}
func run():
 var output=OS.get_cmdline_user_args()[0]
 DirAccess.make_dir_recursive_absolute(output)
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 world.menu_back.visible=false
 for foe in world.foes:foe.visible=false
 var records=[]
 for direction in [1,-1]:
  sequence_time=-1
  world.reduced_effects=false
  await prepare(direction)
  var label="right" if direction>0 else "left"
  var samples=[await snap(output,"before-"+label+".png")]
  await approach(direction)
  if not world.checkpoint or world.checkpoint_layer.bursts.size()!=1:
   printerr("FAIL checkpoint capture actual approach")
   quit(1)
   return
  sequence_time=0
  var seen={}
  for tick in 90:
   if tick>0:await advance(1)
   var layer=world.checkpoint_layer
   if layer.bursts.is_empty():break
   var frame=layer.frame_at(layer.bursts[0].age)
   if seen.has(frame):continue
   seen[frame]=true
   samples.append(await snap(output,"activation-%s-f%02d.png"%[label,frame]))
   if frame==3:
    world.reduced_effects=true
    world.step(0)
    samples.append(await snap(output,"reduced-"+label+".png"))
    world.reduced_effects=false
    world.step(0)
   if frame==4:
    var age:float=layer.bursts[0].age
    world.set_pause(true)
    world.menu.visible=false
    world.menu_scroll.visible=false
    world.menu_back.visible=false
    world.testing=false
    world._physics_process(.2)
    world.testing=true
    if layer.bursts[0].age!=age:
     printerr("FAIL checkpoint capture paused clock")
     quit(1)
     return
    samples.append(await snap(output,"paused-"+label+".png"))
    world.set_pause(false)
  if seen.size()!=8 or not world.checkpoint_layer.bursts.is_empty():
   printerr("FAIL checkpoint capture phases/expiry")
   quit(1)
   return
  samples.append(await snap(output,"expired-"+label+".png"))
  world.restart()
  for foe in world.foes:foe.visible=false
  samples.append(await snap(output,"retry-active-"+label+".png"))
  world.complete=true
  world.restart()
  world.hero.reset_at(Vector2(4048,Rules.GROUND))
  for foe in world.foes:foe.visible=false
  samples.append(await snap(output,"completion-reset-"+label+".png"))
  records.append({"direction":direction,"samples":samples})
 var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"physical_device":false,"viewport":root.size,"records":records}," "))
 print("PASS checkpoint capture:bothdirections,2marker states,8activation phases,pause,reduced,expiry,retry,completion reset")
 quit()
