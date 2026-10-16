extends SceneTree
const DT = 1.0/120.0
func _initialize() -> void:
 call_deferred("capture")
func fail(message: String) -> void:
 printerr("FAIL swooper death: "+message)
 quit(1)
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
  for tick in 135:
   if foe.state == "cruise" and foe.elapsed>=.1: break
   foe.simulate(DT)
  if foe.state != "cruise":
   fail("natural cruise entry")
   return
  var label = "right" if direction>0 else "left"
  world.camera.position = Vector2(1800,360)
  await process_frame
  await RenderingServer.frame_post_draw
  var before = "before-cruise-"+label+".png"
  root.get_texture().get_image().save_png(output+"/"+before)
  var origin = foe.position
  foe.take_hit()
  foe.simulate(0)
  if foe.hp!=0 or foe.state!="death_fall":
   fail("normal1HP lethal handler")
   return
  # Put the hunter in the descending contact circle: dead foes must not hurt.
  world.hero.position = foe.position+Vector2(0,28)
  var hero_hp = world.hero.health
  var seen = {}
  var samples = []
  for tick in 152:
   world.hero.position = foe.position+Vector2(0,28)
   if tick>0:
    await physics_frame
    foe.simulate(DT)
   if absf(foe.position.x-origin.x)>.001 or absf(foe.position.y-minf(Rules.GROUND,origin.y+180*foe.elapsed))>.02:
    fail("180u/s fall or ground clamp")
    return
   if world.hero.health!=hero_hp:
    fail("dead contact damage")
    return
   var v = foe.visual
   if v.to_global(v.offset).distance_to(foe.position)>.001:
    fail("body pivot")
    return
   world.hero.position = Vector2(1800+direction*550,Rules.GROUND)
   var name = ""
   if not seen.has(v.frame):
    seen[v.frame] = true
    name = "death_fall-%s-f%02d.png" % [label,v.frame]
   elif tick == 42: name = "hold350ms-"+label+".png"
   elif tick == 125: name = "ground-settle-"+label+".png"
   elif tick == 151: name = "cleanup-"+label+".png"
   if name == "": continue
   await process_frame
   await RenderingServer.frame_post_draw
   if foe.elapsed<=1.2 and not v.visible:
    fail("missing death art before cleanup")
    return
   if foe.elapsed>1.2 and v.visible:
    fail("death cleanup after1.2s")
    return
   if tick==125 and v.modulate.a<.8:
    fail("ash faded before visible ground settle")
    return
   if tick>=42 and v.frame!=4:
    fail("hold final frame")
    return
   root.get_texture().get_image().save_png(output+"/"+name)
   samples.append({"state":foe.state,"frame":v.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"visible":v.visible,"opacity":v.modulate.a,"hero_hp":world.hero.health,"file":name})
  if seen.size()!=5:
   fail("five-frame coverage")
   return
  records.append({"direction":direction,"production_hp":1,"hp_after_hit":0,"before":before,"origin":[origin.x,origin.y],"samples":samples})
 var file = FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"normal_production_hp":1,"fall_speed":180,"clip_duration_ms":350,"cleanup_after_seconds":1.2,"records":records}," "))
 print("PASS normal1HP swooper death: five frames both facings,180u/s fall,350ms hold,ground clamp,cleanup and no dead contact damage")
 quit()
