extends SceneTree
const DT=1.0/120
func _initialize() -> void:
 call_deferred("capture")
func fail(message: String) -> void:
 printerr("FAIL ranged recovery: ",message)
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
  world.hero.reset_at(Vector2(origin.x+direction*350,Rules.GROUND))
  world.camera_x=origin.x
  foe.simulate(0)
  if foe.state!="aim":
   fail("natural detection")
   return
  foe.simulate(.85)
  for tick in 10:
   foe.simulate(DT)
   if foe.state=="fire": break
  foe.simulate(.11)
  if foe.state!="fire" or foe.visual.frame!=2 or world.projectiles.size()!=1:
   fail("incoming actual fire frame2")
   return
  var label="right" if direction>0 else "left"
  world.camera.position=Vector2(origin.x,360)
  await process_frame
  await RenderingServer.frame_post_draw
  root.get_texture().get_image().save_png(output+"/before-fire-"+label+".png")
  for tick in 20:
   foe.simulate(DT)
   if foe.state=="recover": break
  if foe.state!="recover" or world.projectiles.size()!=1:
   fail("natural fire handoff/one existing shot")
   return
  var seen={}
  var samples=[]
  var ticks=0
  for tick in 100:
   if tick>0:
    await physics_frame
    world.step(DT)
    foe.simulate(DT)
   world.camera.position=Vector2(origin.x,360)
   if foe.position.distance_to(origin)>.001:
    fail("root changed")
    return
   if foe.state=="recover":
    ticks=tick
    if seen.has(foe.visual.frame): continue
    seen[foe.visual.frame]=true
    if not foe.visual.has_body_layer("recover") or not foe.visual.visible:
     fail("missing painted body")
     return
    if world.projectiles.size()!=1:
     fail("extra recovery shot")
     return
   elif foe.state!="idle":
    fail("outgoing state")
    return
   var filename="%s-%s-f%02d.png"%[foe.state,label,foe.visual.frame]
   await process_frame
   await RenderingServer.frame_post_draw
   root.get_texture().get_image().save_png(output+"/"+filename)
   samples.append({"file":filename,"state":foe.state,"frame":foe.visual.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"projectile_count":world.projectiles.size()})
   if foe.state=="idle": break
  if seen.size()!=7 or foe.state!="idle" or absf((ticks+1)*DT-.7)>DT+.001:
   fail("seven frames /700ms recovery")
   return
  records.append({"direction":direction,"samples":samples,"duration":(ticks+1)*DT,"projectile_art_approved":false,"outgoing_idle_art_approved":true})
 var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"records":records}," "))
 print("PASS ranged recovery: seven frames/700ms, both facings, natural firing handoff, fixed root, no extra shot, idle return; projectile graphics outside approval")
 quit()
