extends SceneTree
# Actual take_hit interrupts windup; two-HP test instance exercises nonlethal branch.
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
  world.hero.reset_at(Vector2(1050+direction*100,Rules.GROUND))
  foe.enter("approach_walk")
  foe.simulate(DT)
  if foe.state != "lunge_windup":
   printerr("FAIL hurt setup did not enter windup")
   quit(1)
   return
  var stationary_x = foe.position.x
  world.hero.reset_at(Vector2(foe.position.x+direction*350,Rules.GROUND))
  foe.hp = 2 # Test-only durability; production pursuer stays1HP.
  foe.take_hit()
  foe.simulate(0.0)
  if foe.state != "hurt" or foe.hp!=1:
   printerr("FAIL nonlethal hit did not interrupt anticipation")
   quit(1)
   return
  var seen = {}
  var samples = []
  var total = 0.0
  for tick in 130:
   if tick > 0:
    await physics_frame
    foe.simulate(DT)
    total += DT
   world.camera.position = Vector2(1050,360)
   var visual = foe.visual
   if foe.state == "hurt":
    if absf(foe.position.x-stationary_x)>0.001:
     printerr("FAIL hurt moved root")
     quit(1)
     return
    if seen.has(visual.frame): continue
    seen[visual.frame] = true
   elif foe.state != "approach_walk":
    printerr("FAIL unexpected hurt transition")
    quit(1)
    return
   var pivot = Vector2((192 if visual.flip_h else 128)-160+visual.offset.x,224-128+visual.offset.y)
   if visual.to_global(pivot).distance_to(foe.global_position)>0.001:
    printerr("FAIL hurt ground pivot")
    quit(1)
    return
   var name = "%s-%s-f%02d.png" % [foe.state,"right" if direction>0 else "left",visual.frame]
   await process_frame
   await RenderingServer.frame_post_draw
   root.get_texture().get_image().save_png(output+"/"+name)
   samples.append({"state":foe.state,"frame":visual.frame,"elapsed":foe.elapsed,"x":foe.position.x,"file":name})
   if foe.state == "approach_walk": break
  if seen.size()!=3 or foe.state!="approach_walk" or foe.elapsed>DT+0.001 or absf(total-0.18)>DT+0.001:
   printerr("FAIL hurt frame inventory or AI handoff")
   quit(1)
   return
  foe.hp = 1
  foe.enter("lunge_windup")
  foe.take_hit()
  if foe.state!="death" or foe.hp!=0:
   printerr("FAIL normal1HP hit did not enter death")
   quit(1)
   return
  records.append({"normal_lethal_state":foe.state,"direction":direction,"hurt_duration":0.18,"measured_duration":total,"test_only_initial_hp":2,"stationary_root":true,"samples":samples})
 var file = FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"records":records}," "))
 print("PASS actual damage handler: three hurt frames both facings; windup interrupt, stationary root,180ms approach handoff; normal1HP hit enters death")
 quit()
