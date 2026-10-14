extends SceneTree
# Capture actual runtime textures at contract frame boundaries, without simulation.
func _initialize() -> void:
 call_deferred("capture")
func capture() -> void:
 var args = OS.get_cmdline_user_args()
 var state = args[0] if args.size() > 0 else "get_up"
 var output = args[1] if args.size() > 1 else "res://../evidence/getup-engine"
 DirAccess.make_dir_recursive_absolute(output)
 var world = load("res://main.tscn").instantiate()
 root.add_child(world)
 world.testing = true
 world.set_pause(false)
 world.menu_back.visible = false
 world.hero.position = Vector2(640, Rules.GROUND)
 world.hero.enter(state)
 var durations = world.hero.visual.specs["hero_" + state].ms
 var elapsed = 0.0
 for i in durations.size():
  world.hero.visual.follow(state, elapsed + 0.00001)
  world.hero.queue_redraw()
  await process_frame
  await RenderingServer.frame_post_draw
  var error = root.get_texture().get_image().save_png(output + "/f%03d.png" % i)
  if error != OK:
   printerr("Capture failed: ", error)
   quit(1)
   return
  elapsed += durations[i] / (1000.0 * world.hero.visual.playback_rate(state))
 quit()
