extends "res://tests/enemy_defeat.gd"
var lethal_time=-1.0
func advance(ticks:int):
 for tick in ticks:
  await physics_frame
  world.step(DT)
  if is_instance_valid(target): target.simulate(DT)
  world.camera_x=origin.x
  world.camera.position=Vector2(origin.x,360)
  world.queue_redraw()
func fail(message:String):
 printerr("FAIL enemy defeat capture: "+message)
 quit(1)
func snap(output:String,name:String)->Dictionary:
 world.queue_redraw()
 await process_frame
 await RenderingServer.frame_post_draw
 var image=root.get_texture().get_image()
 image.save_png(output+"/"+name)
 var layer=world.defeat_layer
 var burst=layer.bursts[0] if not layer.bursts.is_empty() else {}
 var point:Vector2=burst.get("position",Vector2.ZERO)
 var age:float=burst.get("age",-1.0)
 var scale=float(image.get_height())/720
 return {"file":name,"target_kind":target.kind,"target_hp":target.hp,"state":target.state,"body_frame":target.visual.frame,"body_alpha":target.visual.modulate.a,"target_position":[target.position.x,target.position.y],"burst_count":layer.bursts.size(),"effect_frame":layer.frame_at(age),"effect_age":age,"effect_position":[point.x,point.y],"effect_image_point":[image.get_width()*.5+(point.x-origin.x)*scale,image.get_height()*.5+(point.y-360)*scale],"sequence_elapsed":target.elapsed if lethal_time>=0 else -1.0,"paused":world.paused,"reduced_effects":world.reduced_effects,"image_size":[image.get_width(),image.get_height()]}
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
  for kind in ["pursuer","swooper","ranged","boss"]:
   target=world.foes.filter(func(foe):return foe.kind==kind)[0]
   target.visible=true
   target.hp=8 if kind=="boss" else (2 if kind=="ranged" else 1)
   var initial:int=target.hp
   var hits=[]
   for hit in initial-1:
    if not await actual_hit(direction):
     fail("prelude actual whip "+kind)
     return
    hits.append(target.hp)
   await prepare(target,direction)
   var label=("right" if direction>0 else "left")+"-"+kind
   lethal_time=-1
   var samples=[await snap(output,"before-"+label+".png")]
   world.hero.controls.set_action("whip",true)
   for tick in 40:
    await advance(1)
    if target.hp==0:break
   world.hero.controls.set_action("whip",false)
   if target.hp!=0 or world.defeat_layer.bursts.size()!=1:
    fail("lethal actual whip "+kind)
    return
   hits.append(target.hp)
   lethal_time=world.hero.attack_time
   var seen={}
   for tick in 70:
    if tick>0:await advance(1)
    var layer=world.defeat_layer
    if layer.bursts.is_empty():break
    var frame=layer.frame_at(layer.bursts[0].age)
    if seen.has(frame):continue
    seen[frame]=true
    samples.append(await snap(output,"defeat-%s-f%02d.png"%[label,frame]))
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
      fail("paused age")
      return
     samples.append(await snap(output,"paused-"+label+".png"))
     world.set_pause(false)
   if seen.size()!=8 or not world.defeat_layer.bursts.is_empty():
    fail("eight phases and expiry")
    return
   samples.append(await snap(output,"expired-"+label+".png"))
   records.append({"direction":direction,"target_kind":kind,"initial_hp":initial,"actual_hits":hits,"fixture":"isolated standing/perch hits; each preserves remaining production HP","samples":samples})
   target.visible=false
 var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"physical_device":false,"viewport":root.size,"records":records}," "))
 print("PASS enemy defeat capture:8actual-lethal fixtures,8frames,bothfacings,all4archetypes,pause,reduced,expiry")
 quit()
