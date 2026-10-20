extends "res://tests/capture_whip_impact.gd"
func run():
 var output=OS.get_cmdline_user_args()[0]
 DirAccess.make_dir_recursive_absolute(output)
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 world.menu_back.visible=false
 target=null
 view_x=640
 var records=[]
 for direction in [1,-1]:
  world.restart()
  for foe in world.foes:foe.visible=false
  world.hero.reset_at(Vector2(416-direction*112,Rules.GROUND))
  world.hero.facing=direction
  await advance(4)
  var label="right" if direction>0 else "left"
  var samples=await sequence(output,label,"effigy")
  if samples.is_empty() or world.effigy:
   fail("actual whip must destroy effigy")
   return
  world.restart()
  for foe in world.foes:foe.visible=false
  world.hero.reset_at(Vector2(416-direction*112,Rules.GROUND))
  world.hero.facing=direction
  await advance(4)
  samples.append(await snap(output,"restored-"+label+".png"))
  records.append({"direction":direction,"target_kind":"effigy","samples":samples})
 var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"physical_device":false,"viewport":root.size,"records":records}," "))
 print("PASS effigy capture:bothdirections,intact,actualwhipbreak,6impactphases,expiry,restartrestoration")
 quit()
