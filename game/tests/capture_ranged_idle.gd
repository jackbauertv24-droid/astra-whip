extends SceneTree
const DT = 1.0/120.0
func _initialize() -> void:
 call_deferred("capture")
func fail(message: String) -> void:
 printerr("FAIL ranged idle: "+message)
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
  world.hero.reset_at(Vector2(origin.x+direction*700,Rules.GROUND))
  world.camera_x = origin.x
  foe.enter("idle")
  foe.simulate(0)
  var label = "right" if direction>0 else "left"
  var seen = {}
  var samples = []
  var wrapped = false
  for tick in 120:
   if tick>0:
    await physics_frame
    foe.simulate(DT)
   world.camera.position = Vector2(origin.x,360)
   var v = foe.visual
   if foe.state!="idle" or foe.position.distance_to(origin)>.001:
    fail("rooted idle outside detection")
    return
   var texture = v.sprite_frames.get_frame_texture(v.animation,v.frame)
   var local_pivot = authored_pivot-texture.get_size()*.5+v.offset
   if v.flip_h: local_pivot.x = -local_pivot.x
   if v.to_global(local_pivot).distance_to(foe.position)>.001:
    fail("base pivot")
    return
   var wrap = tick>100 and v.frame==0
   if seen.has(v.frame) and not wrap: continue
   if wrap and wrapped: continue
   if wrap: wrapped = true
   seen[v.frame] = true
   await process_frame
   await RenderingServer.frame_post_draw
   if not v.visible or not v.has_body_layer("idle"):
    fail("missing painted idle")
    return
   var name = "idle-%s-%s-f%02d.png" % [label,"wrap" if wrap else "first",v.frame]
   root.get_texture().get_image().save_png(output+"/"+name)
   samples.append({"state":foe.state,"frame":v.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"file":name,"wrap":wrap})
   if wrap: break
  if seen.size()!=6 or not wrapped or absf(foe.elapsed-.9)>DT+.001:
   fail("six frames or900ms loop")
   return
  world.hero.position = Vector2(origin.x+direction*350,Rules.GROUND)
  foe.simulate(DT)
  if foe.state!="aim":
   fail("natural aim detection")
   return
  var after = "after-aim-preview-"+label+".png"
  await process_frame
  await RenderingServer.frame_post_draw
  root.get_texture().get_image().save_png(output+"/"+after)
  records.append({"direction":direction,"production_hp":2,"cycle_ms":900,"samples":samples,"outgoing_state":foe.state,"outgoing_file":after,"outgoing_art_approved":false})
 var file = FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"records":records}," "))
 print("PASS ranged idle: all six frames both facings,stationary base,900ms loop and natural aim entry; outgoing preview art unapproved")
 quit()
