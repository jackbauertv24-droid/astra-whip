extends SceneTree
const DT=1.0/120
var world
var checks=0
var failures=0
func _initialize():call_deferred("run")
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL damage priority: ",message)
func run():
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 await physics_frame
 for facing in [1,-1]:
  for health in [1,5]:
   for already_active in [false,true]:
    for incoming in ["projectile","contact"]:
     world.restart()
     world.simulate_enemies=false
     world.hero.reset_at(Vector2(3200,Rules.GROUND))
     for i in 4:
      await physics_frame
      world.step(DT)
     var h=world.hero
     world.simulate_enemies=true
     h.facing=facing
     h.health=health
     var target=world.foes[0]
     target.position=h.position+Vector2(facing*110,0)
     target.bounds=Vector2(target.position.x,target.position.x)
     target.enter("lunge_windup")
     if already_active:
      h.enter("attack_ground")
      h.attack_time=.15
     else:h.controls.set_action("whip",true)
     var pos=h.position+Vector2(0,-70)
     if incoming=="projectile":world.projectiles.append({"pos":pos,"start":pos.x,"dir":0,"age":0.0})
     else:
      var contact=world.foes[1]
      contact.position=h.position
      contact.bounds=Vector2(h.position.x,h.position.x)
      contact.enter("lunge_windup")
     await physics_frame
     world.step(DT)
     check(h.health==health-1,"incoming "+incoming+" applied")
     check(target.hp==1,"same-step incoming damage suppresses outgoing whip")
     check(h.attack_time<0 and not h.active(),"damage cancels attack clock/hitbox")
     check(h.state==("death" if health==1 else ("hurt_recoil" if incoming=="projectile" else "knockback")),"lethal/nonlethal damage state wins")
 print("RESULT damage priority: ",checks," checks, ",failures," failures")
 quit(0 if failures==0 else 1)
