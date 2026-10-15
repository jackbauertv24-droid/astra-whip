extends SceneTree
# Actual AI transitions and travel; canonical frame timings are retained in source.
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
 for state in ["patrol_walk", "approach_walk"]:
  for direction in [1, -1]:
   foe.position = Vector2(1050, Rules.GROUND)
   foe.floor_y = Rules.GROUND
   foe.bounds = Vector2(800,1500)
   foe.hp = 1
   foe.facing = direction
   world.hero.reset_at(Vector2(1050 + direction * (550 if state == "patrol_walk" else 350), Rules.GROUND))
   foe.enter("idle" if state == "patrol_walk" else "patrol_walk")
   world.camera_x = 1050
   for tick in 150:
    await physics_frame
    foe.simulate(DT)
    if foe.state == state: break
   if foe.state != state:
    printerr("FAIL AI did not enter pursuer ", state)
    quit(1)
    return
   var began = foe.elapsed
   var start_x = foe.position.x
   var seen = {}
   var samples = []
   var cycle = -1.0
   var distance = 0.0
   for tick in 120:
    if tick > 0:
     await physics_frame
     foe.simulate(DT)
    world.camera.position = Vector2(1050,360)
    if foe.state != state:
     printerr("FAIL unexpected pursuer state change")
     quit(1)
     return
    var visual = foe.visual
    var index = visual.frame
    if index == 0 and seen.size() == 8:
     cycle = foe.elapsed - began
     distance = absf(foe.position.x - start_x)
     break
    var pivot = Vector2((192 if visual.flip_h else 128) - 160 + visual.offset.x, 224 - 128 + visual.offset.y)
    if visual.to_global(pivot).distance_to(foe.global_position) > 0.001:
     printerr("FAIL mirrored pursuer ground pivot")
     quit(1)
     return
    if seen.has(index): continue
    seen[index] = true
    samples.append({"frame": index, "time": foe.elapsed, "x": foe.position.x})
    await process_frame
    await RenderingServer.frame_post_draw
    var side = "right" if direction > 0 else "left"
    if root.get_texture().get_image().save_png(output + "/%s-%s-f%03d.png" % [state, side, index]) != OK:
     quit(1)
     return
   var speed = Rules.PURSUER_PATROL_SPEED if state == "patrol_walk" else Rules.PURSUER_APPROACH_SPEED
   var expected_cycle = 0.72 if state == "patrol_walk" else 0.432
   if seen.size() != 8 or absf(cycle - expected_cycle) > DT + 0.0001 or absf(distance - 43.2) > speed * DT + 0.01:
    printerr("FAIL pursuer frame/cycle/travel: ", state, " ", seen, " ", cycle, " ", distance)
    quit(1)
    return
   records.append({"state": state, "facing": direction, "samples": samples, "cycle_seconds": cycle, "travel_units": distance, "speed": speed, "playback_rate": foe.visual.playback_rate(state)})
 var file = FileAccess.open(output + "/capture.json", FileAccess.WRITE)
 file.store_string(JSON.stringify(records, " "))
 print("PASS actual AI patrol/approach: eight frames both facings, travel/cadence and mirrored ground pivots")
 quit()
