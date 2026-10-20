extends SceneTree
var checks=0
var failures=0
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL boss death entry: "+message)
func _initialize(): call_deferred("run")
func run():
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 var boss
 for foe in world.foes:
  if foe.kind=="boss": boss=foe
 var loading=boss.visual.sprite_frames.get_frame_texture("boss_death",1)
 for facing in [1,-1]:
  boss.facing=facing
  for state in ["idle","walk","hurt","strike_windup","strike_execute","strike_recover","hazard_windup","hazard_execute","hazard_recover"]:
   for time in [0.0,.15,.3]:
    boss.hp=1
    boss.enter(state)
    boss.visual.follow(state,time)
    var before=boss.visual.sprite_frames.get_frame_texture(boss.visual.animation,boss.visual.frame)
    var clip=str(boss.visual.animation)
    var frame=boss.visual.frame
    boss.take_hit()
    boss.visual.follow("death",0)
    check(boss.hp==0 and boss.state=="death","lethal state")
    check(boss.death_entry_animation==clip and boss.death_entry_frame==frame,"entry recorded")
    check(boss.visual.sprite_frames.get_frame_texture("boss_death",0)==before,"exact lethal paint retained from"+state)
    boss.visual.follow("death",.089)
    check(boss.visual.frame==0,"90ms entry hold")
    boss.visual.follow("death",.09)
    check(boss.visual.frame==1 and boss.visual.sprite_frames.get_frame_texture("boss_death",1)==loading,"same authored loading follows entry")
    check(boss.visual.flip_h==(facing<0),"facing preserved")
    check(boss.visual.sprite_frames.get_frame_count("boss_death")==12,"twelve frames remain")
 print("RESULT boss death entry: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
