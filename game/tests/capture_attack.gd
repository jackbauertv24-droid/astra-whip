extends SceneTree
# Fresh input, both facings, shared clock and exact mirrored socket registration.
const DT = 1.0 / 120.0
func _initialize() -> void:
 call_deferred("capture")
func capture() -> void:
 var args = OS.get_cmdline_user_args()
 var output = args[0]
 DirAccess.make_dir_recursive_absolute(output)
 var world = load("res://main.tscn").instantiate()
 root.add_child(world)
 world.testing = true
 world.simulate_enemies = false
 world.set_pause(false)
 world.menu_back.visible = false
 var samples = []
 var socket_error_max = 0.0
 for direction in [1, -1]:
  world.hero.reset_at(Vector2(640, Rules.GROUND))
  world.hero.facing = direction
  for i in 8:
   await physics_frame
   world.step(DT)
  world.hero.controls.set_action("whip", true, "capture")
  var seen = {}
  for tick in 66:
   await physics_frame
   world.step(DT)
   world.camera.position.x = 640
   var hero = world.hero
   var visual = hero.visual
   if hero.state != "attack_ground": continue
   var index = visual.frame
   if not visual.weapon.visible or visual.weapon.texture != visual.weapon_frames[index]:
    printerr("FAIL weapon/body synchronization")
    quit(1)
    return
   var socket = Vector2(visual.hand_sockets[index][0], visual.hand_sockets[index][1])
   var expected = hero.global_position + Vector2((socket.x - 256) * direction, socket.y - 448) * 0.5
   socket_error_max = maxf(socket_error_max, visual.weapon.to_global(socket).distance_to(expected))
   if socket_error_max > 0.001:
    printerr("FAIL mirrored socket registration")
    quit(1)
    return
   if seen.has(index): continue
   seen[index] = true
   samples.append({"facing": direction, "frame": index, "time": hero.attack_time, "active": hero.active()})
   await process_frame
   await RenderingServer.frame_post_draw
   var side = "right" if direction > 0 else "left"
   if root.get_texture().get_image().save_png(output + "/%s-f%03d.png" % [side, index]) != OK:
    printerr("FAIL capture write")
    quit(1)
    return
  world.hero.controls.clear()
  if seen.size() != 8:
   printerr("FAIL missing attack frames: ", seen)
   quit(1)
   return
 var record = FileAccess.open(output + "/capture.json", FileAccess.WRITE)
 record.store_string(JSON.stringify({"samples": samples, "socket_error_max": socket_error_max, "socket_tolerance": 0.001, "attack_seconds": Rules.ATTACK_END}, " "))
 print("PASS eight synchronized attack frames in both facings; mirrored sockets within0.001 units")
 quit()
