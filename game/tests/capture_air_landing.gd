extends SceneTree
# Real jump/attack input crosses into either landing pose without restarting combat.
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
 var records = []
 for low in [false, true]:
  var hero = world.hero
  hero.reset_at(Vector2(640, Rules.GROUND))
  for i in 8:
   await physics_frame
   world.step(DT)
  hero.controls.set_action("jump", true, "capture")
  for i in 73:
   await physics_frame
   world.step(DT)
  hero.controls.set_action("jump", false, "capture")
  hero.controls.set_action("crouch", low, "capture")
  hero.controls.set_action("whip", true, "capture")
  var landed = false
  var before = {}
  for tick in 60:
   await physics_frame
   var previous_time = hero.attack_time
   world.step(DT)
   world.camera.position.x = 640
   if tick == 0: hero.hit_ids[999] = true
   if hero.state == "attack_air":
    if not hero.visual.weapon.visible or hero.visual.weapon.texture != hero.visual.weapon_sets["attack_air"][hero.visual.frame]:
     printerr("FAIL missing synchronized air weapon before landing")
     quit(1)
     return
    before = {"state": hero.state, "time": hero.attack_time, "frame": hero.visual.frame, "active": hero.active()}
    continue
   if before.is_empty() or hero.attack_time < 0: continue
   var expected_state = "attack_crouch" if low else "attack_ground"
   var visual = hero.visual
   if hero.state != expected_state or absf(hero.attack_time - previous_time - DT) > 0.00001 or not hero.hit_ids.has(999) or not hero.active():
    printerr("FAIL landing restarted attack, lost hit IDs, missed active phase or selected wrong state")
    quit(1)
    return
   if not visual.weapon.visible or visual.weapon.texture != visual.weapon_sets[expected_state][visual.frame]:
    printerr("FAIL landing weapon did not switch on the shared clock")
    quit(1)
    return
   var bounds = Rules.CROUCH if low else Rules.STAND
   if hero.shape.shape.size != bounds:
    printerr("FAIL landing collision stance")
    quit(1)
    return
   records.append({"landing_state": hero.state, "before": before, "after_time": hero.attack_time, "after_frame": visual.frame, "active": hero.active(), "hit_id_preserved": hero.hit_ids.has(999)})
   await process_frame
   await RenderingServer.frame_post_draw
   if root.get_texture().get_image().save_png(output + "/%s.png" % expected_state) != OK:
    quit(1)
    return
   landed = true
   break
  hero.controls.clear()
  if not landed:
   printerr("FAIL missing air-to-ground attack transition")
   quit(1)
   return
 var file = FileAccess.open(output + "/capture.json", FileAccess.WRITE)
 file.store_string(JSON.stringify(records, " "))
 print("PASS active air attack lands into ground/crouch layers without clock or hit-ID reset")
 quit()
