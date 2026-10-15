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
  for tick in 350:
   if foe.state == "dive" and foe.elapsed>=.18: break
   foe.simulate(DT)
  if foe.state != "dive":
   printerr("FAIL natural dive before recovery")
   quit(1)
   return
  world.camera.position = Vector2(1800,360)
  await process_frame
  await RenderingServer.frame_post_draw
  var label = "right" if direction>0 else "left"
  var before = "before-dive-"+label+".png"
  root.get_texture().get_image().save_png(output+"/"+before)
  while foe.state == "dive": foe.simulate(DT)
  if foe.state != "recovery_climb":
   printerr("FAIL natural recovery entry")
   quit(1)
   return
  var origin = foe.position
  var seen = {}
  var samples = []
  var recovery_ticks = 0
  for tick in 114:
   if tick>0:
    await physics_frame
    foe.simulate(DT)
   world.camera.position = Vector2(1800,360)
   var visual = foe.visual
   if absf(foe.position.x-origin.x)>.01 or visual.to_global(visual.offset).distance_to(foe.position)>.001:
    printerr("FAIL recovery drift or body pivot")
    quit(1)
    return
   if foe.state == "recovery_climb":
    recovery_ticks = tick
    var expected_y = lerpf(foe.floor_y-64,foe.floor_y-182.5,minf(1,foe.elapsed/.9))
    if absf(foe.position.y-expected_y)>.01:
     printerr("FAIL prescribed recovery climb")
     quit(1)
     return
    if seen.has(visual.frame): continue
    seen[visual.frame] = true
   elif foe.state != "cruise":
    printerr("FAIL unexpected recovery handoff")
    quit(1)
    return
   var name = "%s-%s-f%02d.png" % [foe.state,label,visual.frame]
   await process_frame
   await RenderingServer.frame_post_draw
   if not visual.visible:
    printerr("FAIL missing painted recovery or cruise")
    quit(1)
    return
   root.get_texture().get_image().save_png(output+"/"+name)
   samples.append({"state":foe.state,"frame":visual.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"file":name})
   if foe.state == "cruise": break
  if seen.size()!=6 or foe.state!="cruise" or absf((recovery_ticks+1)*DT-.9)>DT+.001 or absf(foe.position.y-(foe.floor_y-182.5))>.01:
   printerr("FAIL six frames,900ms recovery or cruise altitude")
   quit(1)
   return
  records.append({"direction":direction,"natural_dive_to_recovery":true,"duration":(recovery_ticks+1)*DT,"before":before,"start_altitude":64,"end_altitude":182.5,"samples":samples})
 var file = FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"records":records}," "))
 print("PASS actual swooper recovery: six frames both facings, dive/cruise handoffs,900ms ascent64->182.5u,stable pivots")
 quit()
