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
  foe.hp = 1
  foe.facing = direction
  world.hero.reset_at(Vector2(1800+direction*280,Rules.GROUND))
  world.camera_x = 1800
  foe.enter("perch_idle")
  for tick in 310:
   if foe.state == "dive_telegraph" and foe.elapsed>=.58: break
   foe.simulate(DT)
  if foe.state != "dive_telegraph":
   printerr("FAIL natural tell before dive")
   quit(1)
   return
  world.camera.position = Vector2(1800,360)
  await process_frame
  await RenderingServer.frame_post_draw
  var label = "right" if direction>0 else "left"
  root.get_texture().get_image().save_png(output+"/before-tell-"+label+".png")
  while foe.state == "dive_telegraph": foe.simulate(DT)
  if foe.state != "dive":
   printerr("FAIL natural dive entry")
   quit(1)
   return
  var origin = foe.position
  var seen = {}
  var samples = []
  var dive_ticks = 0
  for tick in 34:
   if tick>0:
    await physics_frame
    foe.simulate(DT)
   world.camera.position = Vector2(1800,360)
   var visual = foe.visual
   if foe.state == "dive":
    dive_ticks = tick
    if absf(foe.position.x-origin.x-direction*300*foe.elapsed)>.01:
     printerr("FAIL dive speed")
     quit(1)
     return
    if foe.elapsed>0:
     var expected_y = lerpf(foe.floor_y-182.5,foe.floor_y-64,minf(1,foe.elapsed/.12))
     if absf(foe.position.y-expected_y)>.01:
      printerr("FAIL dive altitude path")
      quit(1)
      return
    if visual.to_global(visual.offset).distance_to(foe.position)>.001:
     printerr("FAIL dive body pivot")
     quit(1)
     return
    if seen.has(visual.frame): continue
    seen[visual.frame] = true
   elif foe.state != "recovery_climb":
    printerr("FAIL unexpected dive handoff")
    quit(1)
    return
   var name = "%s-%s-f%02d.png" % [foe.state,label,visual.frame]
   await process_frame
   await RenderingServer.frame_post_draw
   if foe.state == "dive" and not visual.visible:
    printerr("FAIL missing painted dive")
    quit(1)
    return
   root.get_texture().get_image().save_png(output+"/"+name)
   samples.append({"state":foe.state,"frame":visual.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"file":name})
   if foe.state == "recovery_climb": break
  if seen.size()!=4 or foe.state!="recovery_climb" or absf((dive_ticks+1)*DT-.24)>DT+.001 or absf(foe.position.y-(foe.floor_y-64))>.01:
   printerr("FAIL four dive frames, duration, or low-pass depth")
   quit(1)
   return
  records.append({"direction":direction,"natural_tell_entry":true,"duration":(dive_ticks+1)*DT,"speed":300,"bottom_altitude":foe.floor_y-foe.position.y,"before":"before-tell-"+label+".png","samples":samples})
 var file = FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"records":records}," "))
 print("PASS actual swooper dive: painted tell handoff, four frames both facings, 300u/s,64u low pass,240ms recovery entry")
 quit()
