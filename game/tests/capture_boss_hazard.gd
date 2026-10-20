extends SceneTree
const DT=1.0/120
var world
var boss
var origin=Vector2.ZERO
var failed=false
func _initialize(): call_deferred("run")
func fail(message:String):
 failed=true
 printerr("FAIL boss hazard capture: "+message)
 quit(1)
func advance():
 var jump=boss.state=="hazard_windup" and boss.elapsed>=.99 and world.hero.is_on_floor()
 world.hero.controls.set_action("jump",jump)
 await physics_frame
 world.step(DT)
 boss.simulate(DT)
 world.hero.controls.set_action("jump",false)
 world.camera_x=origin.x
 world.camera.position=Vector2(origin.x,360)
 world.queue_redraw()
func setup(direction:int):
 boss.position=origin
 boss.hp=8
 boss.cycles=0
 boss.facing=direction
 world.hero.reset_at(origin+Vector2(direction*145,0))
 world.hero.facing=-direction
 world.arena_active=true
 boss.enter("walk")
 boss.simulate(0)
 for tick in 300:
  if boss.state=="hazard_windup": break
  await advance()
 if boss.state!="hazard_windup" or boss.cycles!=1 or boss.hp!=8 or world.hero.health!=5:
  fail("natural strike→recovery→alternate hazard prelude")
func snap(output:String,name:String,time:float)->Dictionary:
 world.camera_x=origin.x
 world.camera.position=Vector2(origin.x,360)
 await process_frame
 await RenderingServer.frame_post_draw
 var visual=boss.visual
 var texture=visual.sprite_frames.get_frame_texture(visual.animation,visual.frame)
 var p=Vector2(176,512)-texture.get_size()*.5
 if visual.flip_h: p.x=-p.x
 p+=visual.offset
 if not visual.visible or not visual.has_body_layer(boss.state) or visual.modulate!=Color.WHITE or visual.to_global(p).distance_to(origin)>.001:
  fail("missing/tinted paint or pivot "+name)
 var image=root.get_texture().get_image()
 image.save_png(output+"/"+name)
 return {"file":name,"state":boss.state,"animation":str(visual.animation),"frame":visual.frame,"elapsed":boss.elapsed,"sequence_elapsed":time,"hurt_pose_context":boss.hurt_pose_context,"hp":boss.hp,"hero_hp":world.hero.health,"position":[boss.position.x,boss.position.y],"hazard_x":boss.hazard_x,"effect_id":boss.hazard_effect_id(),"effect_frame":boss.hazard_effect_frame(),"hero_position":[world.hero.position.x,world.hero.position.y],"image_size":[image.get_width(),image.get_height()]}
func run():
 var output=OS.get_cmdline_user_args()[0]
 DirAccess.make_dir_recursive_absolute(output)
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 for foe in world.foes:
  if foe.kind=="boss": boss=foe
  else: foe.visible=false
 origin=boss.position
 var records=[]
 for direction in [1,-1]:
  var label="right" if direction>0 else "left"
  await setup(direction)
  if failed: return
  var samples=[]
  var seen={}
  var transitions=[]
  var previous=boss.state
  var start=0.0
  for tick in 330:
   if tick>0: await advance()
   if boss.hp!=8 or world.hero.health!=5 or boss.position.distance_to(origin)>.001:
    fail("full cycle root/health")
    return
   if previous!=boss.state:
    transitions.append({"from":previous,"to":boss.state,"duration_ms":(tick*DT-start)*1000})
    previous=boss.state
    start=tick*DT
   var key=boss.state+"/"+str(boss.visual.frame)+"/"+str(boss.hazard_effect_frame())
   if not seen.has(key):
    seen[key]=true
    samples.append(await snap(output,"cycle-%s-%s-f%02d-fx%02d.png"%[label,boss.state,boss.visual.frame,boss.hazard_effect_frame()],tick*DT))
   if boss.state=="walk": break
  for pair in [["hazard_windup",8,1200],["hazard_execute",4,400],["hazard_recover",6,900]]:
   var frames={}
   var duration=-1.0
   for sample in samples:
    if sample.state==pair[0]: frames[sample.frame]=true
   for transition in transitions:
    if transition.from==pair[0]: duration=transition.duration_ms
   if frames.size()!=pair[1] or absf(duration-pair[2])>DT*1000+1:
    fail("full cycle frames/timing "+str(pair))
    return
  records.append({"direction":direction,"branch":"full_cycle","natural_alternation_after_strike":true,"production_start_hp":8,"samples":samples,"transitions":transitions,"outgoing_state":boss.state})
  for branch in [[0.0,"stooped"],[.3,"rising"],[.45,"hazard_late"]]:
   await setup(direction)
   if failed: return
   for tick in 210:
    if boss.state=="hazard_recover": break
    await advance()
   if boss.state!="hazard_recover":
    fail("natural recovery entry")
    return
   var clock=0.0
   for tick in int(round(branch[0]/DT)):
    await advance()
    clock+=DT
   samples=[]
   samples.append(await snap(output,"punish-%s-%s-before.png"%[label,branch[1]],clock))
   seen={}
   for tick in 130:
    world.hero.controls.set_action("whip",tick==0)
    await advance()
    world.hero.controls.set_action("whip",false)
    clock+=DT
    var key=boss.state+"/"+str(boss.visual.frame)+"/"+str(boss.hp)
    if not seen.has(key):
     seen[key]=true
     samples.append(await snap(output,"punish-%s-%s-%s-f%02d-h%d.png"%[label,branch[1],boss.state,boss.visual.frame,boss.hp],clock))
    if boss.state=="walk": break
   var hurt_frames={}
   for sample in samples:
    if sample.animation=="boss_hurt_"+branch[1]: hurt_frames[sample.frame]=true
   if boss.hp!=7 or world.hero.health!=5 or hurt_frames.size()!=3 or boss.state!="walk" or absf(clock-.9)>DT+.001:
    fail("actual whip/context/recovery "+str(branch)+" hp="+str(boss.hp)+" frames="+str(hurt_frames)+" clock="+str(clock))
    return
   records.append({"direction":direction,"branch":"punish_"+branch[1],"natural_alternation_after_strike":true,"production_start_hp":8,"final_hp":7,"whip_start_recovery_seconds":branch[0],"full_commitment_inside_window":branch[0]+.5<=.9,"recovery_ms":clock*1000,"samples":samples,"outgoing_state":boss.state})
 var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"physical_device":false,"window_size":root.size,"records":records}," "))
 print("PASS boss hazard: natural alternating cycle,18frames,1200/400/900ms,bothfacings,jump clear,actualwhips and all three recovery contexts,900ms preserved")
 quit()
