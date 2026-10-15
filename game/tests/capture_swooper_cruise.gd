extends SceneTree
# Observe the real idle-to-cruise AI handoff, complete wingbeat and loop seam.
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
  world.hero.reset_at(Vector2(1800+direction*550,Rules.GROUND))
  world.camera_x = 1800
  foe.enter("perch_idle")
  for tick in 112:
   if foe.state == "cruise": break
   foe.simulate(DT)
  await process_frame
  await RenderingServer.frame_post_draw
  if foe.state != "cruise":
   printerr("FAIL natural cruise entry")
   quit(1)
   return
  var start = foe.position
  var seen = {}
  var samples = []
  for tick in 89:
   if tick>0:
    await physics_frame
    foe.simulate(DT)
   world.camera.position = Vector2(1800,360)
   var visual = foe.visual
   if foe.state != "cruise" or not visual.visible:
    printerr("FAIL missing delivered cruise or wrong AI state")
    quit(1)
    return
   if foe.contact_rect().get_center().distance_to(foe.position)>0.001 or visual.to_global(visual.offset).distance_to(foe.position)>0.001:
    printerr("FAIL flight center registration")
    quit(1)
    return
   var expected = direction*65.0*foe.elapsed
   if absf((foe.position.x-start.x)-expected)>0.01:
    printerr("FAIL cruise travel")
    quit(1)
    return
   var wrap = tick>80 and visual.frame==0
   if seen.has(visual.frame) and not wrap: continue
   seen[visual.frame] = true
   var name = "cruise-%s-%s-f%02d.png" % ["right" if direction>0 else "left","wrap" if wrap else "first",visual.frame]
   await process_frame
   await RenderingServer.frame_post_draw
   root.get_texture().get_image().save_png(output+"/"+name)
   samples.append({"state":foe.state,"frame":visual.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"file":name,"wrap":wrap})
   if wrap: break
  if seen.size()!=8 or samples.size()!=9:
   printerr("FAIL cruise frame or seam inventory")
   quit(1)
   return
  records.append({"direction":direction,"natural_perch_to_cruise":true,"nominal_cycle_ms":720,"speed_u_per_s":65,"samples":samples})
 var file = FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"records":records}," "))
 print("PASS actual swooper cruise AI: eight frames, both facings, world flight pivot, travel and loop seam")
 quit()
