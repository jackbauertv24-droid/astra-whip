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
  for tick in 245:
   if foe.state == "dive_telegraph": break
   foe.simulate(DT)
  if foe.state != "dive_telegraph" or not foe.history.has("cruise"):
   printerr("FAIL natural dive detection")
   quit(1)
   return
  var origin = foe.position
  var seen = {}
  var samples = []
  var tell_ticks = 0
  for tick in 76:
   if tick>0:
    await physics_frame
    foe.simulate(DT)
   world.camera.position = Vector2(1800,360)
   var visual = foe.visual
   if foe.state == "dive_telegraph":
    tell_ticks = tick
    if foe.position.distance_to(origin)>0.001 or visual.to_global(visual.offset).distance_to(origin)>0.001:
     printerr("FAIL tell moved root or flight pivot")
     quit(1)
     return
    if seen.has(visual.frame): continue
    seen[visual.frame] = true
   elif foe.state != "dive":
    printerr("FAIL unexpected tell handoff")
    quit(1)
    return
   var name = "%s-%s-f%02d.png" % [foe.state,"right" if direction>0 else "left",visual.frame]
   await process_frame
   await RenderingServer.frame_post_draw
   if foe.state == "dive_telegraph" and not visual.visible:
    printerr("FAIL missing delivered tell")
    quit(1)
    return
   root.get_texture().get_image().save_png(output+"/"+name)
   samples.append({"state":foe.state,"frame":visual.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"file":name})
   if foe.state == "dive": break
  if seen.size()!=4 or foe.state!="dive" or absf((tell_ticks+1)*DT-.6)>DT+.001:
   printerr("FAIL four tell frames or 600ms handoff")
   quit(1)
   return
  records.append({"direction":direction,"natural_detection":true,"stationary_root":true,"tell_duration":(tell_ticks+1)*DT,"samples":samples})
 var file = FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"records":records}," "))
 print("PASS actual swooper wing-fold tell: four frames, both facings, stationary root and full 600ms before dive")
 quit()
