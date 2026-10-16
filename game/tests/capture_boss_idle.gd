extends SceneTree
const DT = 1.0/120.0
func _initialize() -> void:
 call_deferred("capture")
func fail(message: String) -> void:
 printerr("FAIL boss idle: "+message)
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
 world.arena_active = false
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
  foe.enter("idle")
  foe.simulate(0)
  var label = "right" if direction>0 else "left"
  var seen = {}
  var samples = []
  var wrapped = false
  for tick in 140:
   if tick>0:
    await physics_frame
    foe.simulate(DT)
   world.camera_x = origin.x
   world.camera.position = Vector2(origin.x,360)
   var v = foe.visual
   if foe.state!="idle" or foe.position.distance_to(origin)>.001:
    fail("stationary waiting root")
    return
   var texture = v.sprite_frames.get_frame_texture(v.animation,v.frame)
   var local_pivot = pivot-texture.get_size()*.5
   if v.flip_h: local_pivot.x = -local_pivot.x
   local_pivot += v.offset
   if v.to_global(local_pivot).distance_to(foe.position)>.001:
    fail("foot pivot actual=%s expected=%s offset=%s texture=%s flip=%s" % [v.to_global(local_pivot),foe.position,v.offset,texture.get_size(),v.flip_h])
    return
   var wrap = tick>110 and v.frame==0
   if seen.has(v.frame) and not wrap: continue
   if wrap and wrapped: continue
   if wrap: wrapped = true
   seen[v.frame] = true
   await process_frame
   await RenderingServer.frame_post_draw
   if not v.visible or not v.has_body_layer("idle") or v.modulate!=Color.WHITE:
    fail("missing or tinted painted idle")
    return
   var name = "idle-%s-%s-f%02d.png" % [label,"wrap" if wrap else "first",v.frame]
   root.get_texture().get_image().save_png(output+"/"+name)
   samples.append({"state":foe.state,"frame":v.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"file":name,"wrap":wrap})
   if wrap: break
  if seen.size()!=8 or not wrapped or absf(foe.elapsed-1.0)>DT+.001:
   fail("eight frames or1000ms loop")
   return
  world.arena_active = true
  foe.simulate(DT)
  if foe.state!="walk":
   fail("actual arena activation did not enter walk")
   return
  foe.simulate(0)
  await process_frame
  await RenderingServer.frame_post_draw
  var after = "after-walk-"+label+".png"
  root.get_texture().get_image().save_png(output+"/"+after)
  records.append({"direction":direction,"production_hp":8,"cycle_ms":1000,"samples":samples,"arena_inactive_during_idle":true,"arena_active_outgoing_state":foe.state,"outgoing_file":after})
  world.arena_active = false
 var file = FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"records":records}," "))
 print("PASS boss idle: eight frames both facings,stationary waiting root,1000ms loop,pivot,unmodified palette and actual arena activation into walk")
 quit()
