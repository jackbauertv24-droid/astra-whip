extends SceneTree
var checks=0
var failures=0
func check(ok: bool, message: String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL boss death visibility: "+message)
func _initialize(): call_deferred("run")
func run():
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 var boss
 for foe in world.foes:
  if foe.kind=="boss": boss=foe
 # Exercise the production painted-body branch before the missing death art is
 # accepted. This fixture is deliberately not evidence of completed death art.
 var texture=boss.visual.sprite_frames.get_frame_texture("boss_idle",0)
 for frame in 12:
  boss.visual.sprite_frames.set_frame("boss_death",frame,texture,90)
 boss.visual.body_clips.boss_death=true
 var origin: Vector2=boss.position
 for facing in [1,-1]:
  boss.hp=1
  boss.facing=facing
  boss.enter("idle")
  boss.take_hit()
  check(boss.hp==0 and boss.state=="death","lethal hit starts death")
  world.exit_unlocked=false
  for time in [0.0,.09,.18,.27,.36,.45,.54,.63,.72,.81,.90,.99,1.079,1.08,1.14,1.20,1.201]:
   boss.elapsed=time
   boss.simulate(0)
   boss._draw()
   check(boss.position==origin,"collapse never moves gameplay root")
   check(boss.visual.visible==(time<=1.2),"paint visible through cleanup boundary")
   check(world.exit_unlocked==(time>=1.08),"exit unlock at1080ms")
   if time<=1.08:
    check(is_equal_approx(boss.visual.modulate.a,1.0),"full opacity throughout all12 authored frames at"+str(time))
   elif time<=1.2:
    check(is_equal_approx(boss.visual.modulate.a,clampf((1.2-time)/.12,0,1)),"fade only after completed sequence")
 print("RESULT boss death visibility: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
