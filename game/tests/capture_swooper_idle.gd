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
  var origin = Vector2(1800,Rules.GROUND-182.5)
  foe.position = origin
  foe.floor_y = Rules.GROUND
  foe.bounds = Vector2(1400,2200)
  foe.hp = 1
  foe.facing = direction
  world.hero.reset_at(Vector2(1800+direction*550,Rules.GROUND))
  world.camera_x = 1800
  foe.enter("perch_idle")
  foe.simulate(0)
  var seen = {}
  var samples = []
  var idle_ticks = 0
  for tick in 114:
   if tick>0:
    await physics_frame
    foe.simulate(DT)
   world.camera.position = Vector2(1800,360)
   var visual = foe.visual
   if foe.position.distance_to(origin)>0.001 or visual.to_global(visual.offset).distance_to(origin)>0.001:
    printerr("FAIL idle moved root or flight pivot")
    quit(1)
    return
   if foe.state == "perch_idle":
    idle_ticks = tick
    if seen.has(visual.frame): continue
    seen[visual.frame] = true
   elif foe.state != "cruise":
    printerr("FAIL unexpected idle handoff")
    quit(1)
    return
   var name = "%s-%s-f%02d.png" % [foe.state,"right" if direction>0 else "left",visual.frame]
   await process_frame
   await RenderingServer.frame_post_draw
   if not visual.visible:
    printerr("FAIL missing delivered idle or cruise")
    quit(1)
    return
   root.get_texture().get_image().save_png(output+"/"+name)
   samples.append({"state":foe.state,"frame":visual.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"file":name})
   if foe.state == "cruise": break
  if seen.size()!=6 or foe.state!="cruise" or absf((idle_ticks+1)*DT-.9)>DT+.001:
   printerr("FAIL six idle frames or900ms handoff")
   quit(1)
   return
  records.append({"direction":direction,"stationary_root":true,"duration":(idle_ticks+1)*DT,"samples":samples})
 var file = FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"records":records}," "))
 print("PASS actual swooper idle AI: six frames, both facings, stationary root, center pivot,900ms cruise handoff")
 quit()
