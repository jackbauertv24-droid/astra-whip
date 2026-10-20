extends "res://tests/whip_impact.gd"
var target
var view_x=6144.0
var contact_attack_time=-1.0
func advance(ticks:int):
 for tick in ticks:
  await physics_frame
  world.step(DT)
  if is_instance_valid(target): target.simulate(DT)
  world.camera_x=view_x
  world.camera.position=Vector2(view_x,360)
  world.queue_redraw()
func fail(message:String):
 printerr("FAIL whip impact capture: "+message)
 quit(1)
func snap(output:String,name:String)->Dictionary:
 world.camera_x=view_x
 world.camera.position=Vector2(view_x,360)
 world.queue_redraw()
 await process_frame
 await RenderingServer.frame_post_draw
 var image=root.get_texture().get_image()
 image.save_png(output+"/"+name)
 var layer=world.impact_layer
 var burst=layer.bursts[0] if not layer.bursts.is_empty() else {}
 var p:Vector2=burst.get("position",Vector2.ZERO)
 var age:float=burst.get("age",-1.0)
 var scale=float(image.get_height())/720.0
 return {"file":name,"hero_state":world.hero.state,"hero_position":[world.hero.position.x,world.hero.position.y],"attack_time":world.hero.attack_time,"sequence_elapsed":world.hero.attack_time-contact_attack_time if contact_attack_time>=0 else -1.0,"target_hp":target.hp if is_instance_valid(target) else -1,"burst_count":layer.bursts.size(),"effect_frame":layer.frame_at(age),"effect_age":age,"effect_position":[p.x,p.y],"effect_image_point":[image.get_width()*.5+(p.x-view_x)*scale,image.get_height()*.5+(p.y-360)*scale],"reduced_effects":world.reduced_effects,"paused":world.paused,"effigy_alive":world.effigy,"image_size":[image.get_width(),image.get_height()]}
func sequence(output:String,label:String,mode:String)->Array:
 contact_attack_time=-1.0
 var samples=[await snap(output,"before-"+label+".png")]
 world.hero.controls.set_action("whip",true)
 for tick in 40:
  await advance(1)
  if not world.impact_layer.bursts.is_empty(): break
 world.hero.controls.set_action("whip",false)
 if world.impact_layer.bursts.size()!=1:
  fail("actual contact must create exactly one burst "+label)
  return []
 contact_attack_time=world.hero.attack_time
 var seen={}
 for tick in 40:
  if tick>0: await advance(1)
  var layer=world.impact_layer
  if layer.bursts.is_empty(): break
  var frame=layer.frame_at(layer.bursts[0].age)
  if not seen.has(frame):
   seen[frame]=true
   samples.append(await snap(output,"impact-%s-f%02d.png"%[label,frame]))
   if frame==2 and mode=="ground":
    world.reduced_effects=true
    world.step(0)
    samples.append(await snap(output,"reduced-"+label+".png"))
    world.reduced_effects=false
    world.step(0)
   if frame==3 and mode in ["ground","crouch","air"]:
    var age:float=layer.bursts[0].age
    world.set_pause(true)
    # Hide menu surfaces only in this isolated clock/paint capture.
    world.menu.visible=false
    world.menu_scroll.visible=false
    world.menu_back.visible=false
    world.testing=false
    world._physics_process(.12)
    world.testing=true
    if layer.bursts[0].age!=age:
     fail("paused clock advanced")
     return []
    samples.append(await snap(output,"paused-"+label+".png"))
    world.set_pause(false)
 if seen.size()!=6 or not world.impact_layer.bursts.is_empty():
  fail("all six frames and280ms expiry "+label)
  return []
 samples.append(await snap(output,"expired-"+label+".png"))
 return samples
func run():
 var output=OS.get_cmdline_user_args()[0]
 DirAccess.make_dir_recursive_absolute(output)
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 world.menu_back.visible=false
 var swooper
 for foe in world.foes:
  if foe.kind=="boss": boss=foe
  elif foe.kind=="swooper": swooper=foe
  foe.visible=false
 var records=[]
 for direction in [1,-1]:
  for mode in ["ground","crouch","air"]:
   target=boss
   boss.visible=true
   await setup(direction,mode)
   var samples=await sequence(output,("right" if direction>0 else "left")+"-"+mode,mode)
   if samples.is_empty() or boss.hp!=7:
    fail("production8HP single hit")
    return
   records.append({"direction":direction,"mode":mode,"target_kind":"boss","start_hp":8,"end_hp":boss.hp,"samples":samples})
 boss.visible=false
 for direction in [1,-1]:
  target=swooper
  swooper.visible=true
  world.impact_layer.clear()
  world.hero.reset_at(Vector2(6000,Rules.GROUND))
  world.hero.facing=direction
  swooper.hp=1
  swooper.position=world.hero.position+Vector2(direction*177,-64)
  swooper.floor_y=Rules.GROUND
  swooper.bounds=Vector2(5700,6460)
  swooper.enter("perch_idle")
  await advance(4)
  var samples=await sequence(output,("right" if direction>0 else "left")+"-circle","circle")
  if samples.is_empty() or swooper.hp!=0:
   fail("actual circular grazing hit")
   return
  records.append({"direction":direction,"mode":"ground","target_kind":"swooper","start_hp":1,"end_hp":0,"fixture":"low perch isolates circular grazing contact","samples":samples})
 swooper.visible=false
 target=null
 view_x=640
 for direction in [1,-1]:
  world.impact_layer.clear()
  world.effigy=true
  world.arena_active=false
  world.hero.reset_at(Vector2(416-direction*112,Rules.GROUND))
  world.hero.facing=direction
  await advance(4)
  var samples=await sequence(output,("right" if direction>0 else "left")+"-effigy","effigy")
  if samples.is_empty() or world.effigy:
   fail("actual effigy destruction")
   return
  records.append({"direction":direction,"mode":"ground","target_kind":"effigy","samples":samples})
 var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"physical_device":false,"viewport":root.size,"records":records}," "))
 print("PASS whip impact capture:10actual-contact fixtures,all6frames,bothfacings,ground/crouch/air,circle/effigy,pause,reduced effects,expiry")
 quit()
