extends SceneTree
const DT = 1.0/120.0
func _initialize() -> void:
 call_deferred("capture")
func capture() -> void:
 var output = OS.get_cmdline_user_args()[0]
 DirAccess.make_dir_recursive_absolute(output)
 var world = load("res://main.tscn").instantiate()
 root.add_child(world)
 world.testing = true
 world.simulate_enemies = false
 world.set_pause(false)
 world.menu_back.visible = false
 var foe
 for other in world.foes:
  if other.kind == "swooper" and foe == null: foe = other
  else: other.visible = false
 var records = []
 for direction in [1,-1]:
  foe.position = Vector2(1800,Rules.GROUND-182.5)
  foe.floor_y = Rules.GROUND
  foe.bounds = Vector2(1400,2200)
  foe.hp = 2 # Explicit test-only nonlethal branch; normal basic HP is1.
  foe.facing = direction
  world.hero.reset_at(Vector2(1800+direction*550,Rules.GROUND))
  world.camera_x = 1800
  foe.enter("perch_idle")
  for tick in 135:
   if foe.state == "cruise" and foe.elapsed>=.1: break
   foe.simulate(DT)
  if foe.state != "cruise":
   printerr("FAIL natural cruise before hurt")
   quit(1)
   return
  world.camera.position = Vector2(1800,360)
  var label = "right" if direction>0 else "left"
  var before = "before-cruise-"+label+".png"
  await process_frame
  await RenderingServer.frame_post_draw
  root.get_texture().get_image().save_png(output+"/"+before)
  var origin = foe.position
  foe.take_hit()
  foe.simulate(0)
  if foe.state!="hurt" or foe.hp!=1:
   printerr("FAIL real nonlethal handler")
   quit(1)
   return
  var seen = {}
  var samples = []
  var hurt_ticks = 0
  for tick in 26:
   if tick>0:
    await physics_frame
    foe.simulate(DT)
   world.camera.position = Vector2(1800,360)
   var v = foe.visual
   if foe.position.distance_to(origin)>.01 or v.to_global(v.offset).distance_to(foe.position)>.001:
    printerr("FAIL hurt drift or body pivot")
    quit(1)
    return
   if foe.state == "hurt":
    hurt_ticks = tick
    if seen.has(v.frame): continue
    seen[v.frame] = true
   elif foe.state != "recovery_climb":
    printerr("FAIL unexpected hurt handoff")
    quit(1)
    return
   var name = "%s-%s-f%02d.png" % [foe.state,label,v.frame]
   await process_frame
   await RenderingServer.frame_post_draw
   if not v.visible:
    printerr("FAIL missing hurt/recovery artwork")
    quit(1)
    return
   root.get_texture().get_image().save_png(output+"/"+name)
   samples.append({"state":foe.state,"frame":v.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"file":name})
   if foe.state == "recovery_climb": break
  if seen.size()!=3 or absf((hurt_ticks+1)*DT-.18)>DT+.001:
   printerr("FAIL three hurt frames or180ms timing")
   quit(1)
   return
  foe.simulate(DT)
  var first_delta = foe.position.distance_to(origin)
  if first_delta>2 or absf(foe.position.y-lerpf(origin.y,Rules.GROUND-182.5,DT/.9))>.01:
   printerr("FAIL recovery teleported from hit altitude")
   quit(1)
   return
  var step_name = "recovery-first-step-"+label+".png"
  await process_frame
  await RenderingServer.frame_post_draw
  root.get_texture().get_image().save_png(output+"/"+step_name)
  samples.append({"state":foe.state,"frame":foe.visual.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"file":step_name})
  for tick in 115:
   if foe.state!="recovery_climb": break
   foe.simulate(DT)
  if foe.state!="cruise" or absf(foe.position.y-(Rules.GROUND-182.5))>.01:
   printerr("FAIL conditional recovery completion")
   quit(1)
   return
  var after = "after-cruise-"+label+".png"
  await process_frame
  await RenderingServer.frame_post_draw
  root.get_texture().get_image().save_png(output+"/"+after)
  samples.append({"state":foe.state,"frame":foe.visual.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"file":after})
  records.append({"direction":direction,"fixture_hp":2,"hp_after_hit":1,"hurt_duration":(hurt_ticks+1)*DT,"before":before,"first_recovery_delta":first_delta,"samples":samples})
 foe.hp = 1
 foe.enter("cruise")
 foe.take_hit()
 if foe.hp!=0 or foe.state!="death_fall":
  printerr("FAIL normal1HP damage must bypass hurt")
  quit(1)
  return
 var file = FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"normal_production_hp":1,"normal_lethal_state":foe.state,"normal_lethal_hp":foe.hp,"conditional_nonlethal_fixture":true,"records":records}," "))
 print("PASS conditional swooper hurt: real2HP handler, three frames both facings,180ms,continuous recovery; normal1HP goes death_fall")
 quit()
