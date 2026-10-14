extends SceneTree
# Exercise real input/physics/facing changes, capturing each rendered turn phase.
const DT = 1.0 / 120.0
func _initialize() -> void:
 call_deferred("capture")
func capture() -> void:
 var args = OS.get_cmdline_user_args()
 var output = args[0] if args.size() else ProjectSettings.globalize_path("res://../evidence/turn-engine")
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
 world.hero.controls.set_action("left",true,"capture")
 var seen = {}
 var changed_at = -1.0
 for i in 30:
  await physics_frame
  world.step(DT)
  world.camera.position.x = 640
  var hero = world.hero
  if hero.state != "turn":
   if not seen.is_empty(): break
   continue
  if hero.facing < 0 and changed_at < 0: changed_at = hero.state_time
  var key = "%d_%s" % [hero.visual.frame,"right" if hero.facing > 0 else "left"]
  if seen.has(key): continue
  seen[key] = true
  await process_frame
  await RenderingServer.frame_post_draw
  if root.get_texture().get_image().save_png(output + "/" + key + ".png") != OK:
   quit(1)
   return
 world.hero.controls.clear()
 if not (seen.has("0_right") and seen.has("1_right") and seen.has("1_left") and seen.has("2_left")) or absf(changed_at-0.075)>DT+0.0001:
  printerr("FAIL turn input/facing phases: ",seen,"; facing changed at ",changed_at)
  quit(1)
  return
 print("PASS real left input selected all turn phases; facing changed at ",changed_at," seconds")
 quit()
