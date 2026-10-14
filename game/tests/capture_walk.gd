extends SceneTree
# Real-input walk captures: verify full cycle selection and motion/cadence together.
const DT = 1.0 / 120.0
func _initialize() -> void:
 call_deferred("capture")
func capture() -> void:
 var args = OS.get_cmdline_user_args()
 var output = args[0] if args.size() else ProjectSettings.globalize_path("res://../evidence/walk-input-engine")
 DirAccess.make_dir_recursive_absolute(output)
 var world = load("res://main.tscn").instantiate()
 root.add_child(world)
 world.testing = true
 world.simulate_enemies = false
 world.set_pause(false)
 world.menu_back.visible = false
 world.hero.reset_at(Vector2(640, Rules.GROUND))
 for i in 8:
  await physics_frame
  world.step(DT)
 world.hero.controls.set_action("right", true, "capture")
 var seen = {}
 var samples = []
 var began = -1.0
 var start_x = 0.0
 var cycle = -1.0
 var distance = 0.0
 for tick in 120:
  await physics_frame
  world.step(DT)
  world.camera.position.x = 640
  var hero = world.hero
  if hero.state != "walk": continue
  if began < 0:
   began = hero.state_time
   start_x = hero.position.x
  var index = hero.visual.frame
  if index == 0 and seen.size() == 10:
   cycle = hero.state_time - began
   distance = hero.position.x - start_x
   break
  if seen.has(index): continue
  seen[index] = true
  samples.append({"frame": index, "time": hero.state_time, "x": hero.position.x})
  await process_frame
  await RenderingServer.frame_post_draw
  if root.get_texture().get_image().save_png(output + "/f%03d.png" % index) != OK:
   quit(1)
   return
 world.hero.controls.clear()
 var expected_cycle = 0.4 # Target cycle covers approximately96u at240u/s.
 var expected_distance = Rules.SPEED * expected_cycle
 if seen.size() != 10 or absf(cycle - expected_cycle) > DT + 0.0001 or absf(distance - expected_distance) > Rules.SPEED * DT + 0.01:
  printerr("FAIL walk frames/cycle/travel: ", seen, " / ", cycle, " / ", distance)
  quit(1)
  return
 var record = {"samples": samples, "cycle_seconds": cycle, "travel_units": distance, "speed": Rules.SPEED, "playback_rate": world.hero.visual.playback_rate("walk")}
 var file = FileAccess.open(output + "/capture.json", FileAccess.WRITE)
 file.store_string(JSON.stringify(record, " "))
 print("PASS real right input selected 10 walk frames; cycle=", cycle, "s; travel=", distance, " units")
 quit()
