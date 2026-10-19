extends SceneTree
var failures=0
var checks=0
func check(ok: bool,message: String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL boss hurt context: "+message)
func _initialize():
 call_deferred("run")
func run():
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.arena_active=true
 var boss
 for foe in world.foes:
  if foe.kind=="boss": boss=foe
 for facing in [1,-1]:
  boss.facing=facing
  for pair in [[.15,"stooped"],[.67,"rising"],[.82,"half_stoop"],[1.0,""]]:
   boss.hp=8
   boss.enter("strike_recover")
   boss.elapsed=pair[0]
   boss.take_hit()
   check(boss.state=="hurt","hurt entered")
   check(boss.hurt_pose_context==pair[1],"elapsed selects posture "+str(pair))
   for sample in [[0.0,0],[.075,1],[.15,2]]:
    boss.visual.follow("hurt",sample[0])
    check(boss.visual.has_body_layer("hurt"),"paint present")
    check(boss.visual.frame==sample[1],"70/70/60ms frame")
    check(boss.visual.animation==("boss_hurt" if pair[1]=="" else "boss_hurt_"+pair[1]),"correct animation")
   boss.enter("walk")
   check(boss.hurt_pose_context=="","context cleared")
 boss.hp=8
 boss.enter("walk")
 boss.take_hit()
 boss.visual.follow("hurt",0)
 check(boss.visual.animation=="boss_hurt","ordinary hurt unchanged")
 print("RESULT boss hurt context: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
