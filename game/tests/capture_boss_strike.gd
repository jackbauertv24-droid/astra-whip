extends SceneTree
const DT=1.0/120
var capture_failed=false
var world
var foe
var origin=Vector2.ZERO
func _initialize() -> void:
 call_deferred("capture")
func fail(message: String) -> void:
 capture_failed=true
 printerr("FAIL boss strike: "+message)
 quit(1)
func setup(direction: int) -> void:
 foe.position=origin
 foe.hp=8
 foe.cycles=0
 foe.facing=direction
 world.hero.reset_at(origin+Vector2(direction*145,0))
 world.hero.facing=-direction
 world.camera_x=origin.x
 world.camera.position=Vector2(origin.x,360)
 world.arena_active=true
 foe.enter("walk")
 foe.simulate(0)
func snap(output: String,name: String,time: float) -> Dictionary:
 world.camera_x=origin.x
 world.camera.position=Vector2(origin.x,360)
 await process_frame
 await RenderingServer.frame_post_draw
 var v=foe.visual
 var texture=v.sprite_frames.get_frame_texture(v.animation,v.frame)
 var p=Vector2(176,512)-texture.get_size()*.5
 if v.flip_h: p.x=-p.x
 p+=v.offset
 if not v.visible or not v.has_body_layer(foe.state) or v.modulate!=Color.WHITE or v.to_global(p).distance_to(origin)>.001:
  fail("missing/tinted paint or pivot in "+name)
 var img=root.get_texture().get_image()
 img.save_png(output+"/"+name)
 return {"file":name,"animation":str(v.animation),"hurt_pose_context":foe.hurt_pose_context,"state":foe.state,"frame":v.frame,"elapsed":foe.elapsed,"sequence_elapsed":time,"position":[foe.position.x,foe.position.y],"hp":foe.hp,"hero_hp":world.hero.health,"facing":foe.facing,"image_size":[img.get_width(),img.get_height()]}
func capture() -> void:
 var output=OS.get_cmdline_user_args()[0]
 DirAccess.make_dir_recursive_absolute(output)
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 world.menu_back.visible=false
 for actor in world.foes:
  if actor.kind=="boss": foe=actor
  else: actor.visible=false
 origin=foe.position
 var records=[]
 for direction in [1,-1]:
  setup(direction)
  var label="right" if direction>0 else "left"
  if foe.state!="strike_windup":
   fail("natural145u trigger")
   return
  var seen={}
  var samples=[]
  var transitions=[]
  var state_start=0
  var last_state=foe.state
  for tick in 270:
   if tick>0:
    await physics_frame
    world.step(DT)
    foe.simulate(DT)
   world.camera_x=origin.x
   world.camera.position=Vector2(origin.x,360)
   if foe.position.distance_to(origin)>.001 or foe.hp!=8 or world.hero.health!=5:
    fail("root/health changed during spaced fullcycle")
    return
   if foe.state!=last_state:
    transitions.append({"from":last_state,"to":foe.state,"duration_ms":(tick-state_start)*DT*1000})
    state_start=tick
    last_state=foe.state
   if foe.state not in ["strike_windup","strike_execute","strike_recover","walk"]:
    fail("unexpected fullcycle state")
    return
   var key=foe.state+"/"+str(foe.visual.frame)
   if seen.has(key): continue
   seen[key]=true
   var name="cycle-%s-%s-f%02d.png"%[label,foe.state,foe.visual.frame]
   samples.append(await snap(output,name,tick*DT))
   if foe.state=="walk": break
  for pair in [["strike_windup",7,700],["strike_execute",4,200],["strike_recover",6,1100]]:
   var count=0
   for s in samples:
    if s.state==pair[0]: count+=1
   var duration=-1.0
   for t in transitions:
    if t.from==pair[0]: duration=t.duration_ms
   if count!=pair[1] or absf(duration-pair[2])>DT*1000+1:
    fail("fullcycle frames/timing "+str(pair))
    return
  records.append({"direction":direction,"branch":"full_cycle","production_start_hp":8,"spacing":145,"natural_trigger":true,"samples":samples,"transitions":transitions,"outgoing_state":foe.state})
  # Repeat the actual tell/execute, then punish recovery with two real attacks.
  setup(direction)
  for tick in 130:
   world.step(DT)
   foe.simulate(DT)
   if foe.state=="strike_recover": break
  if foe.state!="strike_recover" or foe.hp!=8 or world.hero.health!=5:
   fail("natural recovery before punish")
   return
  samples=[]
  samples.append(await snap(output,"punish-"+label+"-before.png",0))
  seen={}
  var attacks=0
  var clock=0.0
  for tick in 150:
   var trigger=attacks<2 and world.hero.attack_time<0
   if trigger: attacks+=1
   world.hero.controls.set_action("whip",trigger)
   await physics_frame
   world.step(DT)
   foe.simulate(DT)
   world.hero.controls.set_action("whip",false)
   clock+=DT
   world.camera_x=origin.x
   world.camera.position=Vector2(origin.x,360)
   if foe.position.distance_to(origin)>.001 or world.hero.health!=5 or foe.state not in ["strike_recover","hurt","walk"]:
    fail("punish root/health/state")
    return
   if foe.state=="walk" and clock<1.1-DT-.001:
    fail("early recovery exit after hurt")
    return
   var hits=8-foe.hp
   var key=foe.state+"/"+str(foe.visual.frame)+"/"+str(hits)
   if not seen.has(key):
    seen[key]=true
    var name="punish-%s-h%d-%s-f%02d.png"%[label,hits,foe.state,foe.visual.frame]
    samples.append(await snap(output,name,clock))
   if foe.state=="walk": break
  if attacks!=2 or foe.hp!=6 or world.hero.attack_time>=0 or absf(clock-1.1)>DT+.001 or foe.state!="walk":
   fail("two actual full500ms whips inside1100ms recovery")
   return
  for hit in [1,2]:
   var frames={}
   for s in samples:
    if s.state=="hurt" and s.hp==8-hit: frames[s.frame]=true
   if frames.size()!=3:
    fail("all three actual flinch frames per punish hit")
    return
  records.append({"direction":direction,"branch":"two_whip_punish","production_start_hp":8,"final_hp":6,"attacks":2,"both_commitments_finished":true,"recovery_ms":clock*1000,"samples":samples,"outgoing_state":foe.state})
  # Late real hit exercises the third posture context; its full commitment
  # extends beyond recovery, so this is not a two-whip-window claim.
  setup(direction)
  for tick in 130:
   world.step(DT)
   foe.simulate(DT)
   if foe.state=="strike_recover": break
  for tick in 78:
   world.step(DT)
   foe.simulate(DT)
  samples=[]
  seen={}
  for tick in 65:
   world.hero.controls.set_action("whip",tick==0)
   await physics_frame
   world.step(DT)
   foe.simulate(DT)
   world.hero.controls.set_action("whip",false)
   var key=foe.state+"/"+str(foe.visual.frame)
   if not seen.has(key):
    seen[key]=true
    samples.append(await snap(output,"late-%s-%s-f%02d.png"%[label,foe.state,foe.visual.frame],.65+(tick+1)*DT))
   if foe.state=="walk": break
  var late_frames={}
  for s in samples:
   if s.animation=="boss_hurt_half_stoop": late_frames[s.frame]=true
  if late_frames.size()!=3 or foe.hp!=7 or foe.state!="walk":
   fail("late actual hit half-stoop context and deadline return")
   return
  records.append({"direction":direction,"branch":"late_hurt_context","production_start_hp":8,"final_hp":7,"samples":samples,"outgoing_state":foe.state,"full_commitment_inside_window":false})
 var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"window_size":root.size,"physical_device":false,"records":records}," "))
 if capture_failed:
  quit(1)
  return
 print("PASS boss strike: natural145u trigger,all17frames/700+200+1100ms,bothfacings,fixedroot/8HP,spaced strike clear; repeated actualcycle twofull500ms whips→6HP,allflinches,resumed1100ms recovery and coherent walk return")
 quit()
