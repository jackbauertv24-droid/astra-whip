extends SceneTree
const DT=1.0/120
func _initialize() -> void:
 call_deferred("capture")
func fail(message: String) -> void:
 printerr("FAIL ranged death: ",message)
 quit(1)
func capture() -> void:
 var output=OS.get_cmdline_user_args()[0]
 DirAccess.make_dir_recursive_absolute(output)
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 world.menu_back.visible=false
 var foe
 for actor in world.foes:
  if actor.kind=="ranged" and foe==null: foe=actor
  else: actor.visible=false
 var origin: Vector2=foe.position
 var records=[]
 for direction in [1,-1]:
  world.projectiles.clear()
  foe.position=origin
  foe.hp=2
  foe.enter("idle")
  world.hero.reset_at(origin+Vector2(direction*72,0))
  world.hero.facing=-direction
  world.camera_x=origin.x
  for tick in 4:
   world.step(DT)
   foe.simulate(DT)
  world.hero.controls.set_action("whip",true)
  for tick in 40:
   world.step(DT)
   foe.simulate(DT)
   if foe.hp==1: break
  world.hero.controls.set_action("whip",false)
  if foe.hp!=1 or foe.state!="hurt":
   fail("first actual whip at production2HP")
   return
  for tick in 90:
   world.step(DT)
   foe.simulate(DT)
   if world.hero.attack_time<0: break
  if foe.state!="aim" or not world.projectiles.is_empty():
   fail("natural second aim before lethal strike")
   return
  var label="right" if direction>0 else "left"
  world.camera.position=Vector2(origin.x,360)
  await process_frame
  await RenderingServer.frame_post_draw
  root.get_texture().get_image().save_png(output+"/before-aim-"+label+".png")
  world.hero.controls.set_action("whip",true)
  for tick in 40:
   await physics_frame
   world.step(DT)
   foe.simulate(DT)
   if foe.hp==0: break
  world.hero.controls.set_action("whip",false)
  if foe.hp!=0 or foe.state!="death" or not world.projectiles.is_empty():
   fail("second actual whip kills and interrupts aim")
   return
  var seen={}
  var samples=[]
  for tick in 64:
   if tick>0:
    await physics_frame
    world.step(DT)
    foe.simulate(DT)
   world.camera.position=Vector2(origin.x,360)
   if foe.position.distance_to(origin)>.001 or foe.hp!=0 or not world.projectiles.is_empty():
    fail("death root/HP/shot")
    return
   if foe.state!="death" or not foe.visual.has_body_layer("death"):
    fail("painted death state")
    return
   if not seen.has(foe.visual.frame):
    seen[foe.visual.frame]=true
    var filename="death-%s-f%02d.png"%[label,foe.visual.frame]
    await process_frame
    await RenderingServer.frame_post_draw
    root.get_texture().get_image().save_png(output+"/"+filename)
    samples.append({"state":foe.state,"file":filename,"frame":foe.visual.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"alpha":foe.visual.modulate.a})
   if foe.elapsed>=.49: break
  if seen.size()!=6 or foe.visual.frame!=5:
   fail("six80ms frames and held final")
   return
  for target in [.65,1.0,1.225]:
   while foe.elapsed<target:
    world.step(DT)
    foe.simulate(DT)
   var filename="hold-%s-%04d.png"%[label,int(target*1000)]
   await process_frame
   await RenderingServer.frame_post_draw
   root.get_texture().get_image().save_png(output+"/"+filename)
   samples.append({"state":foe.state,"file":filename,"frame":foe.visual.frame,"elapsed":foe.elapsed,"alpha":foe.visual.modulate.a,"visible":foe.visual.visible})
  if foe.visual.visible:
   fail("cleanup after1.2s")
   return
  var health_before: int=world.hero.health
  world.hero.position=origin
  foe.simulate(DT)
  if world.hero.health!=health_before:
   fail("dead contact damage")
   return
  records.append({"direction":direction,"production_start_hp":2,"first_actual_hit_hp":1,"second_actual_hit_hp":foe.hp,"samples":samples,"nominal_clip_seconds":.48,"cleanup_seconds":1.2,"dead_contact_damage":false})
 var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"records":records}," "))
 print("PASS ranged death: actual two-whip production2HP kill,all6frames bothfacings,fixed root,final hold/cleanup,no shot/no dead contact")
 quit()
