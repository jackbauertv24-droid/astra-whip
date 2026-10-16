extends SceneTree
const DT=1.0/120
var world
var foe
var origin: Vector2
var camera_center: Vector2
var output: String
func _initialize() -> void:
 call_deferred("capture")
func fail(message: String) -> void:
 printerr("FAIL projectile grave shot: ",message)
 quit(1)
func snapshot(filename: String) -> void:
 world.camera_x=camera_center.x
 world.camera.position=camera_center
 world.queue_redraw()
 await process_frame
 await RenderingServer.frame_post_draw
 root.get_texture().get_image().save_png(output+"/"+filename)
func tick() -> void:
 world.step(DT)
 # Isolate one real firing cycle, stopping subsequent AI cycles at idle.
 if foe.state!="idle": foe.simulate(DT)
func capture() -> void:
 output=OS.get_cmdline_user_args()[0]
 DirAccess.make_dir_recursive_absolute(output)
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 world.menu_back.visible=false
 for actor in world.foes:
  if actor.kind=="ranged" and foe==null: foe=actor
  else: actor.visible=false
 origin=foe.position
 if world.projectile_frames.size()!=3:
  fail("painted delivery missing")
  return
 var records=[]
 for direction in [1,-1]:
  world.projectiles.clear()
  foe.position=origin
  foe.hp=2
  foe.enter("idle")
  world.hero.reset_at(Vector2(origin.x+direction*350,Rules.GROUND))
  world.hero.facing=-direction
  camera_center=Vector2(origin.x+direction*160,360)
  world.camera_x=camera_center.x
  foe.simulate(0)
  foe.simulate(.85)
  var label="right" if direction>0 else "left"
  await snapshot("before-aim-"+label+".png")
  for n in 10:
   foe.simulate(DT)
   if foe.state=="fire": break
  foe.simulate(.05)
  var birth: Vector2=origin+Vector2(direction*40,-82.5)
  if world.projectiles.size()!=1 or world.projectiles[0].pos.distance_to(birth)>.001 or world.projectiles[0].age!=0:
   fail("real frame1 birth/socket")
   return
  var samples=[]
  for target in [0.0,.08,.16,.24,.9,2.275]:
   while not world.projectiles.is_empty() and world.projectiles[0].age+.000001<target:
    await physics_frame
    tick()
   if world.projectiles.size()!=1:
    fail("early expiry/extra shot")
    return
   var shot: Dictionary=world.projectiles[0]
   var frame: int=world.projectile_frame_at(shot.age)
   var filename="flight-%s-%04d-f%d.png"%[label,int(target*1000),frame]
   await snapshot(filename)
   samples.append({"state":"projectile","file":filename,"frame":frame,"age":shot.age,"position":[shot.pos.x,shot.pos.y],"distance":absf(shot.pos.x-birth.x)})
   if absf(shot.pos.y-birth.y)>.001 or absf(absf(shot.pos.x-birth.x)-280*shot.age)>.1:
    fail("straight280u/s flight")
    return
  for n in 5:
   tick()
   if world.projectiles.is_empty(): break
  if not world.projectiles.is_empty():
   fail("640u expiry")
   return
  await snapshot("expired-"+label+".png")
  var collisions=[]
  for low in [true,false]:
   world.projectiles.clear()
   world.hero.reset_at(origin+Vector2(direction*72,0))
   world.hero.facing=-direction
   if low: world.hero.controls.set_action("crouch",true)
   for n in 4: world.step(DT)
   foe.facing=direction
   foe.enter("fire")
   foe.simulate(.05)
   var x_before: float=world.hero.position.x
   for n in (35 if low else 2): world.step(DT)
   if world.hero.health!=(Rules.HEALTH if low else Rules.HEALTH-1):
    fail("crouch clearance/standing damage")
    return
   if not low and (world.projectiles.size()!=0 or world.hero.state!="hurt_recoil" or absf(world.hero.position.x-x_before)>.001):
    fail("standing consumes shot without displacement")
    return
   if low and world.projectiles.size()!=1:
    fail("crouch keeps shot flying")
    return
   var filename=("crouch-clear-" if low else "standing-hit-")+label+".png"
   await snapshot(filename)
   collisions.append({"file":filename,"crouched":low,"health":world.hero.health,"state":world.hero.state,"remaining_shots":world.projectiles.size(),"non_displacing":absf(world.hero.position.x-x_before)<.001})
  records.append({"direction":direction,"birth":[birth.x,birth.y],"samples":samples,"isolated_one_firing_cycle":true,"expired_at640u":true,"collision_fixtures":collisions})
 var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"records":records}," "))
 print("PASS projectile: painted3frame240msloop,bothfacings,actualframe1muzzle birth,280u/s/640u,standing non-displacing hit,crouch clear")
 quit()
