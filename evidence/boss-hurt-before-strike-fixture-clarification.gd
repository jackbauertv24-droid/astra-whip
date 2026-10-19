extends SceneTree
const DT=1.0/120
func _initialize() -> void:
 call_deferred("capture")
func fail(message: String) -> void:
 printerr("FAIL boss hurt: ",message)
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
  if actor.kind=="boss" and foe==null: foe=actor
  else: actor.visible=false
 var origin: Vector2=foe.position
 var records=[]
 for direction in [1,-1]:
  world.projectiles.clear()
  foe.position=origin
  foe.hp=8
  foe.enter("idle")
  world.hero.reset_at(origin+Vector2(direction*145,0))
  world.hero.facing=-direction
  world.camera_x=origin.x
  world.arena_active=true
  foe.facing=direction
  foe.cycles=0
  foe.simulate(0)
  if foe.state!="idle" or foe.hp!=8:
   fail("initial idle before actual whip")
   return
  var label="right" if direction>0 else "left"
  world.camera.position=Vector2(origin.x,360)
  await process_frame
  await RenderingServer.frame_post_draw
  root.get_texture().get_image().save_png(output+"/before-idle-"+label+".png")
  world.hero.controls.set_action("whip",true)
  for tick in 40:
   await physics_frame
   world.step(DT)
   foe.simulate(DT)
   if foe.hp==7: break
  world.hero.controls.set_action("whip",false)
  if foe.hp!=7 or foe.state!="hurt" or not world.projectiles.is_empty():
   fail("first actual whip causes nonlethal hurt at8HP→7HP; hero="+str(world.hero.position)+" state="+world.hero.state+" attack="+str(world.hero.attack_time)+" health="+str(world.hero.health)+" foe="+foe.state+" hp="+str(foe.hp))
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
   if foe.position.distance_to(origin)>.001 or foe.hp!=7 or not world.projectiles.is_empty():
    fail("root/HP changed or unexpected projectile")
    return
   if foe.state=="hurt":
    ticks=tick
    if seen.has(foe.visual.frame): continue
    seen[foe.visual.frame]=true
    if not foe.visual.has_body_layer("hurt") or not foe.visual.visible:
     fail("missing painted hurt")
     return
   elif foe.state!="walk":
    fail("outgoing state")
    return
   var filename="%s-%s-f%02d.png"%[foe.state,label,foe.visual.frame]
   await process_frame
   await RenderingServer.frame_post_draw
   root.get_texture().get_image().save_png(output+"/"+filename)
   samples.append({"file":filename,"state":foe.state,"frame":foe.visual.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"hp":foe.hp,"projectiles":world.projectiles.size()})
   if foe.state=="walk": break
  if seen.size()!=3 or foe.state!="walk" or absf((ticks+1)*DT-.2)>DT+.001:
   fail("three frames/200ms hurt return")
   return
  # Place a live-strike fixture after completing the real initial whip.
  for tick in 90:
   world.step(DT)
   if world.hero.attack_time<0: break
  world.hero.reset_at(origin+Vector2(direction*145,0))
  world.hero.facing=-direction
  foe.enter("strike_execute")
  var strike_hp: int=foe.hp
  world.hero.controls.set_action("whip",true)
  var hit_during_strike=false
  for tick in 60:
   await physics_frame
   world.step(DT)
   # Start the strike only once the player's real whip becomes live, avoiding
   # spending its200ms window on the player's startup windup.
   if not world.hero.active(): continue
   foe.simulate(DT)
   if foe.hp<strike_hp:
    hit_during_strike=true
    break
  world.hero.controls.set_action("whip",false)
  if not hit_during_strike or foe.hp!=6 or foe.state!="strike_execute":
   fail("real whip interrupted live strike or failed to damage")
   return
  records.append({"direction":direction,"samples":samples,"duration":(ticks+1)*DT,"production_start_hp":8,"first_whip_hp":7,"outgoing_state":"walk","live_strike_whip_hp":foe.hp,"live_strike_state":foe.state,"live_strike_fixture_explicit":true,"strike_art_approved":false})
 var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"records":records}," "))
 print("PASS boss hurt: actual whip8HP→7HP,three70/70/60ms frames/200ms bothfacings,fixedroot,walk return; second actualwhip→6HP does not interrupt explicit live-strike fixture, strike art outside approval")
 quit()
