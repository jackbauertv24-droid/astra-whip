extends SceneTree
# Actual reset idle -> patrol transition, no forced visual state.
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
  foe.enter("idle")
  foe.simulate(0.0)
  var seen = {}
  var samples = []
  for tick in 130:
   if tick > 0:
    await physics_frame
    foe.simulate(DT)
   world.camera.position = Vector2(1050,360)
   var visual = foe.visual
   if foe.state == "idle":
    if absf(foe.position.x-1050)>0.001:
     printerr("FAIL idle moved root")
     quit(1)
     return
    if seen.has(visual.frame): continue
    seen[visual.frame] = true
   elif foe.state != "patrol_walk":
    printerr("FAIL unexpected idle transition")
    quit(1)
    return
   var pivot = Vector2((192 if visual.flip_h else 128)-160+visual.offset.x,224-128+visual.offset.y)
   if visual.to_global(pivot).distance_to(foe.global_position)>0.001:
    printerr("FAIL idle ground pivot")
    quit(1)
    return
   var name = "%s-%s-f%02d.png" % [foe.state,"right" if direction>0 else "left",visual.frame]
   await process_frame
   await RenderingServer.frame_post_draw
   root.get_texture().get_image().save_png(output+"/"+name)
   samples.append({"state":foe.state,"frame":visual.frame,"elapsed":foe.elapsed,"x":foe.position.x,"file":name})
   if foe.state == "patrol_walk": break
  if seen.size()!=6 or foe.state!="patrol_walk" or foe.elapsed>DT+0.001:
   printerr("FAIL idle frame inventory or AI handoff")
   quit(1)
   return
  records.append({"direction":direction,"idle_duration":0.9,"stationary_root":true,"samples":samples})
 var file = FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"records":records}," "))
 print("PASS actual AI idle: six frames, stationary root and ground pivots both facings; natural patrol handoff after900ms")
 quit()
