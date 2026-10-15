extends SceneTree
# Actual patrol detection -> alert -> approach, without forcing the visual state.
const DT = 1.0 / 120.0
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
 var foe = world.foes[0]
 for other in world.foes:
  if other != foe: other.visible = false
 var records = []
 for direction in [1,-1]:
  foe.position = Vector2(1050,Rules.GROUND)
  foe.floor_y = Rules.GROUND
  foe.bounds = Vector2(800,1500)
  foe.hp = 1
  foe.facing = direction
  world.hero.reset_at(Vector2(1050+direction*550,Rules.GROUND))
  world.camera_x = 1050
  foe.enter("patrol_walk")
  for warmup in 23:
   foe.simulate(DT)
  world.hero.reset_at(Vector2(foe.position.x+direction*350,Rules.GROUND))
  foe.simulate(DT)
  if foe.state != "alert":
   printerr("FAIL visible hunter did not trigger alert")
   quit(1)
   return
  var stationary_x = foe.position.x
  var seen = {}
  var samples = []
  for tick in 130:
   if tick > 0:
    await physics_frame
    foe.simulate(DT)
   world.camera.position = Vector2(1050,360)
   var visual = foe.visual
   if foe.state == "alert":
    if absf(foe.position.x-stationary_x)>0.001:
     printerr("FAIL alert moved root")
     quit(1)
     return
    if seen.has(visual.frame): continue
    seen[visual.frame] = true
   elif foe.state != "approach_walk":
    printerr("FAIL unexpected alert transition")
    quit(1)
    return
   var pivot = Vector2((192 if visual.flip_h else 128)-160+visual.offset.x,224-128+visual.offset.y)
   if visual.to_global(pivot).distance_to(foe.global_position)>0.001:
    printerr("FAIL alert ground pivot")
    quit(1)
    return
   var name = "%s-%s-f%02d.png" % [foe.state,"right" if direction>0 else "left",visual.frame]
   await process_frame
   await RenderingServer.frame_post_draw
   root.get_texture().get_image().save_png(output+"/"+name)
   samples.append({"state":foe.state,"frame":visual.frame,"elapsed":foe.elapsed,"x":foe.position.x,"file":name})
   if foe.state == "approach_walk": break
  if seen.size()!=4 or foe.state!="approach_walk" or foe.elapsed>DT+0.001:
   printerr("FAIL alert frame inventory or AI handoff")
   quit(1)
   return
  records.append({"direction":direction,"alert_duration":0.3,"stationary_root":true,"samples":samples})
 var file = FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"records":records}," "))
 print("PASS actual AI alert: four frames, stationary root and ground pivots both facings; detection and natural approach handoff after300ms")
 quit()
