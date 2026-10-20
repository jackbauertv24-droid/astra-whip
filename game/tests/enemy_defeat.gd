extends SceneTree
const DT=1.0/120
var checks=0
var failures=0
var world
var target
var origin=Vector2(6144,Rules.GROUND)
func _initialize(): call_deferred("run")
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL enemy defeat: "+message)
func advance(ticks:int):
 for tick in ticks:
  await physics_frame
  world.step(DT)
  if is_instance_valid(target): target.simulate(DT)
func prepare(foe,direction:int):
 target=foe
 world.defeat_layer.clear()
 world.impact_layer.clear()
 world.reduced_effects=false
 world.arena_active=false
 target.position=origin-Vector2(0,64 if target.kind=="swooper" else 0)
 target.floor_y=Rules.GROUND
 target.bounds=Vector2(5700,6460)
 target.facing=-direction
 target.enter("perch_idle" if target.kind=="swooper" else "idle")
 world.hero.reset_at(origin-Vector2(direction*145,0))
 world.hero.facing=direction
 await advance(4)
func actual_hit(direction:int):
 var previous:int=target.hp
 # Isolated supported standing/perch contact; retain production HP across hits.
 await prepare(target,direction)
 world.hero.controls.set_action("whip",true)
 for tick in 40:
  await advance(1)
  if target.hp<previous: break
 world.hero.controls.set_action("whip",false)
 return target.hp==previous-1
func run():
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 var layer=world.defeat_layer
 check(layer.frames.size()==8,"eight painted frames load")
 check(layer.durations.map(func(ms):return int(ms))==[70,70,70,70,70,70,70,70],"contract eight70ms phases")
 check(layer.canvas_size==Vector2(256,256) and layer.anchor==Vector2(128,128),"contract canvas and centre")
 for f in 8:
  check(layer.frame_at(float(f*70)/1000+.0000001)==f,"phase start"+str(f))
  check(layer.frame_at(float((f+1)*70)/1000-.000001)==f,"phase end"+str(f))
 check(layer.frame_at(.56)==-1,"560ms removal")
 for direction in [1,-1]:
  for foe in world.foes:
   if foe.kind not in ["pursuer","swooper","ranged","boss"]: continue
   # One instance of each archetype.
   if foe!=world.foes.filter(func(item):return item.kind==foe.kind)[0]: continue
   target=foe
   target.hp=8 if target.kind=="boss" else (2 if target.kind=="ranged" else 1)
   var initial:int=target.hp
   for hit in initial:
    check(await actual_hit(direction),"actual whip reduces production HP "+target.kind)
    if target.hp>0:check(layer.bursts.is_empty(),"nonlethal contact has no defeat effect")
   check(layer.bursts.size()==1,"exactly one defeat effect "+target.kind+str(direction))
   if layer.bursts.size()!=1: continue
   var point:Vector2=layer.bursts[0].position
   check(point==target.contact_rect().get_center(),"anchored at lethal enemy centre")
   check(layer.bursts[0].age==0.0,"begins on lethal tick")
   target.take_hit()
   check(layer.bursts.size()==1,"already-dead hits cannot retrigger")
   world.testing=false
   world.set_pause(true)
   world._physics_process(.2)
   check(layer.bursts[0].age==0.0,"pause freezes defeat clock")
   world.testing=true
   world.set_pause(false)
   world.reduced_effects=true
   await advance(1)
   check(layer.reduced,"Reduced effects applies")
   await advance(32)
   check(layer.bursts.size()==1 and layer.bursts[0].position==point,"stationary world anchor through collapse/fall")
   await advance(35)
   check(layer.bursts.is_empty(),"effect removed after560ms")
 layer.spawn_at(origin)
 world.restart()
 check(layer.bursts.is_empty(),"restart clears defeat residue")
 print("RESULT enemy defeat: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
