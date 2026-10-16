extends SceneTree
const DT = 1.0/120.0
func _initialize() -> void:
 call_deferred("capture")
func fail(message: String) -> void:
 printerr("FAIL ranged aim: "+message)
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
  if other.kind == "ranged" and foe == null: foe = other
  else: other.visible = false
 var origin: Vector2 = foe.position
 var actor_spec: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://data/art_contract.json")).actors.ranged
 var authored_pivot = Vector2(actor_spec.pivot[0],actor_spec.pivot[1])
 var records = []
 for direction in [1,-1]:
  foe.position = origin
  foe.hp = 2
  world.projectiles.clear()
  world.hero.reset_at(Vector2(origin.x+direction*700,Rules.GROUND))
  world.camera_x = origin.x
  foe.enter("idle")
  foe.simulate(.3)
  if foe.state!="idle":
   fail("idle outside detection")
   return
  world.camera.position = Vector2(origin.x,360)
  var label = "right" if direction>0 else "left"
  var before = "before-idle-"+label+".png"
  await process_frame
  await RenderingServer.frame_post_draw
  root.get_texture().get_image().save_png(output+"/"+before)
  world.hero.position = Vector2(origin.x+direction*350,Rules.GROUND)
  foe.simulate(0)
  if foe.state!="aim":
   fail("natural detection into aim")
   return
  var seen = {}
  var samples = []
  var ticks = 0
  for tick in 115:
   if tick>0:
    await physics_frame
    foe.simulate(DT)
   world.camera.position = Vector2(origin.x,360)
   if foe.position.distance_to(origin)>.001 or foe.hp!=2:
    fail("root or productionHP changed")
    return
   if world.projectiles.size()!=0:
    fail("shot during900ms telegraph")
    return
   var v = foe.visual
   if foe.state=="aim":
    ticks = tick
    if seen.has(v.frame): continue
    seen[v.frame] = true
   elif foe.state!="fire":
    fail("unexpected aiming handoff")
    return
   if foe.state=="aim":
    var texture = v.sprite_frames.get_frame_texture(v.animation,v.frame)
    var local_pivot = authored_pivot-texture.get_size()*.5+v.offset
    if v.flip_h: local_pivot.x = -local_pivot.x
    if v.to_global(local_pivot).distance_to(origin)>.001:
     fail("base pivot")
     return
   var name = "%s-%s-f%02d.png" % [foe.state,label,v.frame]
   await process_frame
   await RenderingServer.frame_post_draw
   if foe.state=="aim" and (not v.visible or not v.has_body_layer("aim")):
    fail("missing painted aim")
    return
   root.get_texture().get_image().save_png(output+"/"+name)
   samples.append({"state":foe.state,"frame":v.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"file":name,"projectiles":world.projectiles.size()})
   if foe.state=="fire": break
  if seen.size()!=6 or foe.state!="fire" or absf((ticks+1)*DT-.9)>DT+.001:
   fail("six frames or900ms duration")
   return
  foe.simulate(.05)
  if world.projectiles.size()!=1:
   fail("one projectile on fire frame1")
   return
  var birth: Vector2 = world.projectiles[0].pos
  var expected = origin+Vector2(direction*40,-82.5)
  if birth.distance_to(expected)>.001:
   fail("projectile muzzle moved outside required lane")
   return
  records.append({"direction":direction,"production_hp":2,"before":before,"natural_idle_detection":true,"aim_duration":(ticks+1)*DT,"samples":samples,"outgoing_fire_art_approved":false,"projectile_birth":{"fire_elapsed":foe.elapsed,"fire_frame":foe.visual.frame,"position":[birth.x,birth.y],"expected_source_muzzle":[208,155],"projectile_art_approved":false}})
 var file = FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"records":records}," "))
 print("PASS ranged aim: six frames both facings,900ms fixed-root telegraph,no early shots,fire frame1 birth at unchanged required muzzle; outgoing preview art unapproved")
 quit()
