extends SceneTree
const DT=1.0/120
func _initialize() -> void:
 call_deferred("capture")
func fail(message: String) -> void:
 printerr("FAIL ranged hurt: ",message)
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
  if foe.state!="aim" or foe.hp!=2:
   fail("natural aim before hit")
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
   if foe.hp==1: break
  world.hero.controls.set_action("whip",false)
  if foe.hp!=1 or foe.state!="hurt" or not world.projectiles.is_empty():
   fail("first actual whip interrupts aim into nonlethal hurt; hero="+str(world.hero.position)+" state="+world.hero.state+" attack="+str(world.hero.attack_time)+" health="+str(world.hero.health)+" foe="+foe.state+" hp="+str(foe.hp))
   return
  var seen={}
  var samples=[]
  var ticks=0
  for tick in 30:
   if tick>0:
    await physics_frame
    world.step(DT)
    foe.simulate(DT)
   world.camera.position=Vector2(origin.x,360)
   if foe.position.distance_to(origin)>.001 or foe.hp!=1 or not world.projectiles.is_empty():
    fail("root/HP changed or shot escaped interrupted aim")
    return
   if foe.state=="hurt":
    ticks=tick
    if seen.has(foe.visual.frame): continue
    seen[foe.visual.frame]=true
    if not foe.visual.has_body_layer("hurt") or not foe.visual.visible:
     fail("missing painted hurt")
     return
   elif foe.state!="idle":
    fail("outgoing state")
    return
   var filename="%s-%s-f%02d.png"%[foe.state,label,foe.visual.frame]
   await process_frame
   await RenderingServer.frame_post_draw
   root.get_texture().get_image().save_png(output+"/"+filename)
   samples.append({"file":filename,"state":foe.state,"frame":foe.visual.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"hp":foe.hp,"projectiles":world.projectiles.size()})
   if foe.state=="idle": break
  if seen.size()!=3 or foe.state!="idle" or absf((ticks+1)*DT-.18)>DT+.001:
   fail("three frames/180ms hurt return")
   return
  # Complete the first commitment and use a second real attack without changing HP.
  for tick in 90:
   world.step(DT)
   foe.simulate(DT)
   if world.hero.attack_time<0: break
  world.hero.controls.set_action("whip",true)
  for tick in 60:
   world.step(DT)
   foe.simulate(DT)
   if foe.hp==0: break
  world.hero.controls.set_action("whip",false)
  if foe.hp!=0 or foe.state!="death":
   fail("second actual whip is lethal at production2HP")
   return
  records.append({"direction":direction,"samples":samples,"duration":(ticks+1)*DT,"production_start_hp":2,"first_whip_hp":1,"second_whip_hp":foe.hp,"second_whip_state":foe.state,"death_art_approved":false})
 var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"records":records}," "))
 print("PASS ranged hurt: actual first whip interrupts aim at2HP→1HP,three frames/180ms both facings,fixed root,no shot,idle return; actual second whip lethal,death art outside approval")
 quit()
