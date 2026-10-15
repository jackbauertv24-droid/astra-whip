extends SceneTree
# Actual range-triggered windup -> lunge -> recovery -> approach.
const DT = 1.0/120.0
func _initialize() -> void:
 call_deferred("capture")
func capture() -> void:
 var output = OS.get_cmdline_user_args()[0]
 DirAccess.make_dir_recursive_absolute(output)
 var world = load("res://main.tscn").instantiate()
 root.add_child(world)
 world.testing = true
 world.simulate_enemies = false
 world.set_pause(false)
 world.menu_back.visible = false
 var foe = world.foes[0]
 for other in world.foes:
  if other != foe: other.visible = false
 var records = []
 for direction in [1,-1]:
  foe.position = Vector2(1050,Rules.GROUND)
  foe.floor_y = Rules.GROUND
  foe.bounds = Vector2(700,1500)
  foe.hp = 1
  foe.facing = direction
  world.camera_x = 1050
  world.hero.reset_at(Vector2(1050+direction*100,Rules.GROUND))
  foe.enter("approach_walk")
  foe.simulate(DT)
  if foe.state != "lunge_windup":
   printerr("FAIL close hunter did not trigger windup")
   quit(1)
   return
  world.hero.reset_at(Vector2(foe.position.x+direction*350,Rules.GROUND))
  var expected = ["lunge_windup","lunge","recovery","approach_walk"]
  var clocks = [0.35,0.24,0.6]
  var counts = [4,3,4,1]
  var phase = 0
  var logical = 0.0
  var began = 0.0
  var phase_x = foe.position.x
  var seen = {}
  var samples = []
  var transitions = []
  for tick in 180:
   if tick>0:
    await physics_frame
    foe.simulate(DT)
    logical += DT
   if foe.state != expected[phase]:
    if phase>=3 or foe.state!=expected[phase+1] or seen.size()!=counts[phase]:
     printerr("FAIL lunge action order or frame inventory")
     quit(1)
     return
    var duration = logical-began
    var distance = absf(foe.position.x-phase_x)
    if absf(duration-clocks[phase])>DT+0.001 or (phase!=1 and distance>0.001) or (phase==1 and absf(distance-62.4)>260*DT+0.01):
     printerr("FAIL lunge phase clock or physical travel")
     quit(1)
     return
    transitions.append({"from":expected[phase],"to":foe.state,"duration":duration,"distance":distance})
    phase += 1
    began = logical
    phase_x = foe.position.x
    seen = {}
   world.camera.position = Vector2(1050,360)
   var visual = foe.visual
   if seen.has(visual.frame): continue
   seen[visual.frame] = true
   var pivot = Vector2((192 if visual.flip_h else 128)-160+visual.offset.x,224-128+visual.offset.y)
   if visual.to_global(pivot).distance_to(foe.global_position)>0.001:
    printerr("FAIL mirrored lunge pivot")
    quit(1)
    return
   var name = "%s-%s-f%02d.png" % [foe.state,"right" if direction>0 else "left",visual.frame]
   await process_frame
   await RenderingServer.frame_post_draw
   root.get_texture().get_image().save_png(output+"/"+name)
   samples.append({"state":foe.state,"frame":visual.frame,"elapsed":foe.elapsed,"x":foe.position.x,"file":name})
   if phase==3: break
  if phase!=3 or seen.size()!=1:
   printerr("FAIL incomplete lunge capture")
   quit(1)
   return
  records.append({"direction":direction,"lunge_speed":260,"transitions":transitions,"samples":samples})
 var file = FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"records":records}," "))
 print("PASS actual AI windup/lunge/recovery: all11 frames both facings,350/240/600ms clocks,62.4u lunge travel and approach handoff")
 quit()
