extends SceneTree
const DT = 1.0/120.0
func _initialize() -> void:
 call_deferred("capture")
func fail(message: String) -> void:
 printerr("FAIL boss walk: "+message)
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
 world.arena_active = true
 var foe
 for other in world.foes:
  if other.kind == "boss": foe = other
  else: other.visible = false
 var origin: Vector2 = foe.position
 var pivot = Vector2(176,512)
 var records = []
 for direction in [1,-1]:
  foe.position = origin
  foe.hp = 8
  foe.cycles = 0
  foe.facing = direction
  world.hero.reset_at(Vector2(origin.x+direction*350,Rules.GROUND))
  foe.enter("walk")
  foe.simulate(0)
  var label = "right" if direction>0 else "left"
  var seen = {}
  var samples = []
  var wrapped = false
  for tick in 80:
   if tick>0:
    await physics_frame
    foe.simulate(DT)
   world.camera_x = origin.x
   world.camera.position = Vector2(origin.x,360)
   var v = foe.visual
   if foe.state!="walk" or absf(foe.position.x-origin.x-direction*70*DT*tick)>.05:
    fail("actual70u/s walk root")
    return
   var texture = v.sprite_frames.get_frame_texture(v.animation,v.frame)
   var local_pivot = pivot-texture.get_size()*.5+v.offset
   if v.flip_h: local_pivot.x = -local_pivot.x
   if v.to_global(local_pivot).distance_to(foe.position)>.001:
    fail("foot pivot")
    return
   var wrap = tick>70 and v.frame==0
   if seen.has(v.frame) and not wrap: continue
   if wrap and wrapped: continue
   if wrap: wrapped = true
   seen[v.frame] = true
   await process_frame
   await RenderingServer.frame_post_draw
   if not v.visible or not v.has_body_layer("walk") or v.modulate!=Color.WHITE:
    fail("missing or tinted painted walk")
    return
   var name = "walk-%s-%s-f%02d.png" % [label,"wrap" if wrap else "first",v.frame]
   root.get_texture().get_image().save_png(output+"/"+name)
   samples.append({"state":foe.state,"frame":v.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"file":name,"wrap":wrap})
   if wrap: break
  if seen.size()!=8 or not wrapped or absf(foe.elapsed-.64)>DT+.001:
   fail("eight frames or640ms loop")
   return
  records.append({"direction":direction,"production_hp":8,"speed":70,"cycle_ms":640,"samples":samples})
 var file = FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"records":records}," "))
 print("PASS boss walk: eight frames both facings,actual70u/s roots,640ms loop,pivot and unmodified palette")
 quit()
