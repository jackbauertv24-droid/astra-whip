extends SceneTree
var checks=0
var failures=0
func _initialize() -> void:
 call_deferred("run")
func check(ok: bool,label: String) -> void:
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL ",label)
func run() -> void:
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 if not world.has_method("projectile_frame_at"):
  check(false,"painted projectile clock/resources unavailable")
  print("RANGED PROJECTILE ART: ",checks," checks, ",failures," failures")
  quit(1)
  return
 var spec: Dictionary=JSON.parse_string(FileAccess.get_file_as_string("res://data/art_contract.json")).clips.projectile_grave_shot
 check(world.projectile_frames.size()==spec.ms.size(),"all three painted frames loaded")
 check(world.projectile_canvas==Vector2(spec.canvas[0],spec.canvas[1]),"64px canvas from contract")
 check(world.projectile_anchor==Vector2(spec.anchor[0],spec.anchor[1]),"center pivot from contract")
 for texture in world.projectile_frames: check(texture.get_size()==Vector2(64,64),"native source canvas")
 for sample in [[0.0,0],[.079,0],[.08,1],[.159,1],[.16,2],[.239,2],[.24,0],[.32,1],[.48,0],[2.4,0]]:
  check(world.projectile_frame_at(sample[0])==sample[1],"80ms phase/240ms wrap at"+str(sample[0]))
 var foe
 for actor in world.foes:
  if actor.kind=="ranged": foe=actor
 foe.position=Vector2(1800,Rules.GROUND)
 world.camera_x=1800
 for direction in [1,-1]:
  world.projectiles.clear()
  world.hero.reset_at(Vector2(1800+direction*1000,Rules.GROUND))
  foe.facing=direction
  foe.enter("fire")
  foe.simulate(.05)
  check(world.projectiles.size()==1 and world.projectiles[0].age==0,"actual birth phase0")
  var birth: Vector2=world.projectiles[0].pos
  for sample in [[.04,0],[.041,1],[.08,2],[.08,0]]:
   world.step(sample[0])
   check(world.projectile_frame_at(world.projectiles[0].age)==sample[1],"actual world age phase")
  check(absf(world.projectiles[0].pos.x-birth.x-direction*280*.241)<.01,"art clock preserves280u/s")
 print("RANGED PROJECTILE ART: ",checks," checks, ",failures," failures")
 quit(0 if failures==0 else 1)
