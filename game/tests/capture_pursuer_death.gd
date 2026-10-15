extends SceneTree
# Normal one-HP damage handler, complete collapse/dissolve, hold and cleanup.
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
 var foe = world.foes[0]
 for other in world.foes:
  if other != foe: other.visible = false
 var records = []
 for direction in [1,-1]:
  foe.position = Vector2(1050,Rules.GROUND)
  foe.floor_y = Rules.GROUND
  foe.bounds = Vector2(700,1500)
  foe.hp = 1
  foe.facing = direction
  foe.visual.visible = true
  world.hero.reset_at(Vector2(1050+direction*550,Rules.GROUND))
  world.camera_x = 1050
  foe.enter("patrol_walk")
  foe.simulate(0.0)
  world.camera.position = Vector2(1050,360)
  await process_frame
  await RenderingServer.frame_post_draw
  var before = "death-%s-before.png" % ["right" if direction>0 else "left"]
  root.get_texture().get_image().save_png(output+"/"+before)
  foe.take_hit()
  foe.simulate(0.0)
  if foe.hp!=0 or foe.state!="death":
   printerr("FAIL normal lethal hit did not enter death")
   quit(1)
   return
  var seen = {}
  var samples = [{"state":"patrol_walk","frame":0,"elapsed":0,"visible":true,"hp":1,"x":foe.position.x,"file":before}]
  var held = false
  var hidden = false
  for tick in 160:
   if tick>0:
    await physics_frame
    foe.simulate(DT)
   world.camera.position = Vector2(1050,360)
   if foe.state!="death" or absf(foe.position.x-1050)>0.001:
    printerr("FAIL death state or root changed")
    quit(1)
    return
   var tag = ""
   if not seen.has(foe.visual.frame):
    seen[foe.visual.frame] = true
    tag = "f%02d" % foe.visual.frame
   elif foe.elapsed>=0.75 and not held:
    if foe.visual.frame!=5:
     printerr("FAIL final death frame did not hold")
     quit(1)
     return
    held = true
    tag = "hold"
   elif foe.elapsed>=1.3 and not hidden:
    hidden = true
    tag = "hidden"
   if tag=="": continue
   var visual = foe.visual
   var pivot = Vector2((192 if visual.flip_h else 128)-160+visual.offset.x,224-128+visual.offset.y)
   if visual.to_global(pivot).distance_to(foe.global_position)>0.001:
    printerr("FAIL mirrored death pivot")
    quit(1)
    return
   await process_frame
   await RenderingServer.frame_post_draw
   if (tag=="hold" and not visual.visible) or (tag=="hidden" and visual.visible):
    printerr("FAIL death hold/cleanup visibility")
    quit(1)
    return
   var name = "death-%s-%s.png" % ["right" if direction>0 else "left",tag]
   root.get_texture().get_image().save_png(output+"/"+name)
   samples.append({"state":foe.state,"frame":visual.frame,"elapsed":foe.elapsed,"visible":visual.visible,"x":foe.position.x,"file":name})
   if hidden: break
  if seen.size()!=6 or not held or not hidden:
   printerr("FAIL incomplete death inventory/hold/cleanup")
   quit(1)
   return
  world.hero.reset_at(foe.position)
  var health = world.hero.health
  foe.simulate(0.1)
  if world.hero.health!=health:
   printerr("FAIL dead pursuer dealt contact damage")
   quit(1)
   return
  records.append({"direction":direction,"normal_initial_hp":1,"dead_contact_damage":false,"six_frames_then_hold":true,"samples":samples})
 var file = FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"records":records}," "))
 print("PASS normal lethal handler: six death frames both facings; grounded root, final hold, cleanup and no dead contact damage")
 quit()
