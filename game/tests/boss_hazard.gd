extends SceneTree
const DT=1.0/120
var checks=0
var failures=0
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL boss hazard: "+message)
func _initialize(): call_deferred("run")
func run():
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.arena_active=true
 var boss
 for foe in world.foes:
  if foe.kind=="boss": boss=foe
 var origin=boss.position
 for direction in [1,-1]:
  boss.facing=direction
  boss.hp=8
  boss.cycles=1
  boss.enter("walk")
  world.hero.reset_at(origin+Vector2(direction*145,0))
  boss.simulate(0)
  check(boss.state=="hazard_windup","odd cycle selects hazard")
  check(boss.visual.has_body_layer(boss.state),"windup paint present")
  world.hero.position.x=origin.x+direction*200
  boss.elapsed=1.04
  boss.simulate(.005)
  check(is_equal_approx(boss.hazard_x,world.hero.position.x),"zone follows before1050ms")
  var locked=boss.hazard_x
  world.hero.position.x+=direction*80
  boss.simulate(.01)
  check(is_equal_approx(boss.hazard_x,locked),"zone locks for last150ms")
  boss.elapsed=1.2
  world.hero.position=Vector2(locked,boss.floor_y-50)
  boss.simulate(0)
  check(boss.state=="hazard_execute","1200ms execution")
  boss.simulate(.01)
  check(world.hero.health==5,"feet above46u eruption clear")
  world.hero.reset_at(Vector2(locked+direction*100,boss.floor_y))
  boss.simulate(.01)
  check(world.hero.health==5,"outside160u zone plus body halfwidth clear")
  world.hero.reset_at(Vector2(locked,boss.floor_y))
  boss.simulate(.01)
  check(world.hero.health==4,"inside eruption takes contact damage")
  boss.elapsed=.4
  boss.simulate(0)
  check(boss.state=="hazard_recover","400ms execution ends")
  for state in ["hazard_windup","hazard_execute","hazard_recover"]:
   boss.enter(state)
   check(boss.visual.has_body_layer(state),"complete paint "+state)
   var id="boss_"+state
   var time=0.0
   for frame in boss.visual.specs[id].ms.size():
    boss.visual.follow(state,time+.001)
    check(boss.visual.frame==frame,"frame mapping "+id+" "+str(frame))
    check(boss.visual.sprite_frames.get_frame_texture(id,frame).get_size()==Vector2(512,576),"canvas preserved")
    time+=float(boss.visual.specs[id].ms[frame])/1000
  for state in ["hazard_windup","hazard_execute"]:
   boss.enter(state)
   var id=boss.hazard_effect_id()
   check(boss.hazard_art[id].complete,"paired effect inventory complete")
   var time=0.0
   for frame in boss.hazard_art[id].ms.size():
    boss.elapsed=time+.000001
    check(boss.hazard_effect_frame()==frame,"paired effect frame boundary")
    check(boss.hazard_art[id].frames[frame].get_size()==boss.hazard_art[id].canvas,"effect canvas/anchor projection")
    time+=float(boss.hazard_art[id].ms[frame])/1000
  world.hero.reset_at(origin+Vector2(direction*145,0))
  for pair in [[.15,"stooped"],[.45,"rising"],[.6,"hazard_late"],[.8,""]]:
   boss.hp=8
   boss.enter("hazard_recover")
   boss.elapsed=pair[0]
   boss.take_hit()
   check(boss.state=="hurt" and boss.hp==7,"nonlethal recovery flinch")
   check(boss.hurt_pose_context==pair[1],"hazard posture "+str(pair))
   for sample in [[0.0,0],[.075,1],[.15,2]]:
    boss.visual.follow("hurt",sample[0])
    check(boss.visual.frame==sample[1],"70/70/60ms flinch")
    check(boss.visual.animation==("boss_hurt" if pair[1]=="" else "boss_hurt_"+pair[1]),"correct context clip")
   var time=pair[0]
   for tick in 130:
    boss.simulate(DT)
    time+=DT
    if boss.state=="walk": break
   check(boss.state=="walk","recovery returns to walk")
   check(time>=.9-DT-.001,"flinch cannot shorten900ms recovery")
   check(absf(time-maxf(.9,pair[0]+.2))<DT*2+.001,"late flinch ends before next commitment")
   check(boss.hurt_pose_context=="","context cleared on walk")
 print("RESULT boss hazard: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
