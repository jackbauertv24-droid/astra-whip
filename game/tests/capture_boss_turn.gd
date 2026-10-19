extends SceneTree
const DT=1.0/120
func _initialize() -> void:
 call_deferred("capture")
func fail(message: String) -> void:
 printerr("FAIL boss turn: "+message)
 quit(1)
func capture() -> void:
 var output=OS.get_cmdline_user_args()[0]
 DirAccess.make_dir_recursive_absolute(output)
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 world.menu_back.visible=false
 world.arena_active=true
 var foe
 for actor in world.foes:
  if actor.kind=="boss": foe=actor
  else: actor.visible=false
 var origin: Vector2=foe.position
 var records=[]
 for direction in [1,-1]:
  foe.position=origin
  foe.hp=8
  foe.cycles=0
  foe.facing=-direction
  world.hero.reset_at(origin+Vector2(direction*350,0))
  world.camera_x=origin.x
  world.camera.position=Vector2(origin.x,360)
  foe.enter("walk")
  foe.visual.follow("walk",0)
  foe.queue_redraw()
  var label="to-right" if direction>0 else "to-left"
  await process_frame
  await RenderingServer.frame_post_draw
  var before="before-walk-"+label+".png"
  root.get_texture().get_image().save_png(output+"/"+before)
  foe.simulate(0)
  if foe.state!="turn":
   fail("natural walk direction mismatch did not enter turn")
   return
  var seen={}
  var samples=[]
  var first_flip=-1.0
  var last_facing=-direction
  var flips=0
  var ticks=0
  for tick in 45:
   ticks=tick
   if tick>0:
    await physics_frame
    foe.simulate(DT)
   world.camera.position=Vector2(origin.x,360)
   if foe.position.distance_to(origin)>.001 or foe.hp!=8:
    fail("root or production health changed")
    return
   if foe.facing!=last_facing:
    flips+=1
    last_facing=foe.facing
    if first_flip<0: first_flip=tick*DT
   var v=foe.visual
   if v.flip_h!=(foe.facing<0):
    fail("art does not follow actual facing")
    return
   var texture=v.sprite_frames.get_frame_texture(v.animation,v.frame)
   var local_pivot=Vector2(176,512)-texture.get_size()*.5
   if v.flip_h: local_pivot.x=-local_pivot.x
   local_pivot+=v.offset
   if v.to_global(local_pivot).distance_to(origin)>.001:
    fail("pivot")
    return
   if foe.state=="turn":
    var expected=direction if foe.elapsed>=.15 else -direction
    if foe.facing!=expected:
     fail("facing event timing")
     return
    if seen.has(v.frame): continue
    seen[v.frame]=true
    if not v.has_body_layer("turn"):
     fail("missing painted turn")
     return
   elif foe.state!="walk":
    fail("outgoing state")
    return
   var filename="%s-%s-f%02d.png"%[foe.state,label,v.frame]
   await process_frame
   await RenderingServer.frame_post_draw
   if not v.visible or v.modulate!=Color.WHITE:
    fail("paint missing or tinted")
    return
   root.get_texture().get_image().save_png(output+"/"+filename)
   samples.append({"file":filename,"state":foe.state,"frame":v.frame,"elapsed":foe.elapsed,"position":[foe.position.x,foe.position.y],"facing":foe.facing,"flipped":v.flip_h})
   if foe.state=="walk": break
  if seen.size()!=4 or foe.state!="walk" or absf(ticks*DT-.3)>DT+.001 or flips!=1 or absf(first_flip-.15)>DT+.001:
   fail("four frames/300ms return/one150ms flip")
   return
  records.append({"direction":direction,"production_hp":8,"natural_walk_entry":true,"samples":samples,"before_file":before,"turn_ms":ticks*DT*1000,"first_facing_flip_ms":first_flip*1000,"facing_flips":flips,"outgoing_state":foe.state})
 var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"records":records}," "))
 print("PASS boss turn: natural direction mismatch,four75ms frames,one150ms flip,300ms walk return,bothdirections,fixedroot/pivot/8HP and untinted paint")
 quit()
