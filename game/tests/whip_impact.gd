extends SceneTree
const DT=1.0/120
var checks=0
var failures=0
var world
var boss
var origin=Vector2(6144,Rules.GROUND)
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL whip impact: "+message)
func _initialize(): call_deferred("run")
func advance(ticks:int):
 for tick in ticks:
  await physics_frame
  world.step(DT)
  boss.simulate(DT)
func setup(direction:int,mode:String):
 world.impact_layer.clear()
 world.reduced_effects=false
 world.arena_active=true
 boss.position=origin
 boss.hp=8
 boss.facing=-direction
 boss.enter("idle")
 world.hero.reset_at(origin-Vector2(direction*145,0))
 world.hero.facing=direction
 await advance(4)
 if mode=="crouch":
  world.hero.controls.set_action("crouch",true)
  await advance(3)
 elif mode=="air":
  world.hero.controls.set_action("jump",true)
  await advance(6)
  world.hero.controls.set_action("jump",false)
func run():
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 for foe in world.foes:
  if foe.kind=="boss": boss=foe
 var layer=world.impact_layer
 check(layer.frames.size()==6,"all six source textures load")
 check(layer.durations.map(func(ms): return int(ms))==[40,40,40,50,50,60],"contract phase durations")
 check(layer.anchor==Vector2(96,96) and layer.canvas_size==Vector2(192,192),"contract centre/canvas")
 check(layer.z_index>boss.z_index and layer.z_index>world.hero.z_index,"contact draws above actors")
 var boundary_ms=0
 for frame in 6:
  check(layer.frame_at(float(boundary_ms)/1000)==frame,"phase start "+str(frame))
  boundary_ms+=int(layer.durations[frame])
  check(layer.frame_at(float(boundary_ms)/1000-.000001)==frame,"phase last instant "+str(frame))
 check(layer.frame_at(.28)==-1 and layer.frame_at(2)==-1,"280ms one-shot expiry")
 for direction in [1,-1]:
  for mode in ["ground","crouch","air"]:
   await setup(direction,mode)
   world.hero.controls.set_action("whip",true)
   for tick in 40:
    await advance(1)
    if boss.hp<8: break
   check(boss.hp==7,"actual "+mode+" whip hits production8HP boss")
   check(layer.bursts.size()==1,"one actual impact "+mode+str(direction))
   if layer.bursts.size()!=1: continue
   check(world.hero.state=="attack_"+mode,"correct supported attack path")
   var point:Vector2=layer.bursts[0].position
   var whip:Rect2=world.hero.whip_rect()
   var body:Rect2=boss.contact_rect()
   check(point.x>=whip.position.x and point.x<=whip.end.x and point.y>=whip.position.y and point.y<=whip.end.y,"point inside active whip")
   check(body.has_point(point),"point inside struck target")
   check(layer.bursts[0].age==0.0 and layer.frame_at(0)==0,"first frame begins at contact")
   world.hero.controls.set_action("whip",false)
   world.testing=false
   world.set_pause(true)
   world._physics_process(.12)
   check(layer.bursts[0].age==0.0,"production pause freezes effect clock")
   world.testing=true
   world.set_pause(false)
   world.reduced_effects=true
   await advance(1)
   check(layer.reduced,"reduced-effects setting reaches layer")
   world.reduced_effects=false
   await advance(1)
   check(not layer.reduced,"normal effects can be restored")
   await advance(25)
   check(layer.bursts.size()==1 and boss.hp==7,"held active contact never duplicates burst/damage")
   if layer.bursts.size()==1: check(layer.bursts[0].position==point,"effect stays at world contact rather than following target")
   await advance(8)
   check(layer.bursts.is_empty(),"effect removed after full280ms")
  await setup(direction,"ground")
  world.hero.facing=-direction
  world.hero.controls.set_action("whip",true)
  await advance(65)
  check(boss.hp==8 and layer.bursts.is_empty(),"a facing-away miss produces no impact")
 # A circular target may touch the far corner of the rectangular whip. Its
 # nearest point, not the bounding-box centre, must be the effect's anchor.
 var swooper
 for foe in world.foes:
  if foe.kind=="swooper": swooper=foe
 for direction in [1,-1]:
  layer.clear()
  world.hero.reset_at(Vector2(6000,Rules.GROUND))
  world.hero.facing=direction
  for tick in 4:
   await physics_frame
   world.step(DT)
  swooper.hp=1
  swooper.position=world.hero.position+Vector2(direction*177,-64)
  swooper.floor_y=Rules.GROUND
  swooper.bounds=Vector2(5700,6460)
  swooper.enter("perch_idle")
  world.hero.controls.set_action("whip",true)
  for tick in 40:
   await physics_frame
   world.step(DT)
   swooper.simulate(DT)
   if swooper.hp==0: break
  world.hero.controls.set_action("whip",false)
  check(swooper.hp==0 and layer.bursts.size()==1,"circular grazing hit produces one impact")
  if layer.bursts.size()==1:
   var point:Vector2=layer.bursts[0].position
   check(point.distance_to(swooper.position)<=Rules.SWOOPER_RADIUS,"circular contact stays inside actual circle")
   check(is_equal_approx(absf(point.x-world.hero.position.x),168),"circular contact uses actual far whip edge")
 world.restart()
 world.hero.reset_at(Vector2(304,Rules.GROUND))
 world.hero.facing=1
 for tick in 4:
  await physics_frame
  world.step(DT)
 world.hero.controls.set_action("whip",true)
 for tick in 40:
  await physics_frame
  world.step(DT)
  if not world.effigy: break
 check(not world.effigy and layer.bursts.size()==1,"actual effigy destruction produces one impact")
 if layer.bursts.size()==1: check(layer.bursts[0].position==Vector2(416,Rules.GROUND-64),"effigy contact point")
 world.restart()
 check(layer.bursts.is_empty(),"restart clears all contact residue")
 print("RESULT whip impact: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
