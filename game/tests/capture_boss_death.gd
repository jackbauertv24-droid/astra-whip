extends SceneTree
const DT=1.0/120
var world
var boss
var origin: Vector2
func _initialize(): call_deferred("run")
func fail(message: String):
 printerr("FAIL boss death capture: "+message)
 quit(1)
func advance():
 await physics_frame
 world.step(DT)
 boss.simulate(DT)
 world.camera_x=origin.x
 world.camera.position=Vector2(origin.x,360)
 world.queue_redraw()
func snap(output: String,name: String)->Dictionary:
 world.queue_redraw()
 await process_frame
 await RenderingServer.frame_post_draw
 var image=root.get_texture().get_image()
 image.save_png(output+"/"+name)
 return {"file":name,"state":boss.state,"animation":str(boss.visual.animation),"frame":boss.visual.frame,"elapsed":boss.elapsed,"hp":boss.hp,"alpha":boss.visual.modulate.a,"visible":boss.visual.visible,"position":[boss.position.x,boss.position.y],"exit_unlocked":world.exit_unlocked,"image_size":[image.get_width(),image.get_height()]}
func run():
 var output=OS.get_cmdline_user_args()[0]
 DirAccess.make_dir_recursive_absolute(output)
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 world.menu_back.visible=false
 for foe in world.foes:
  if foe.kind=="boss": boss=foe
  else: foe.visible=false
 origin=boss.position
 var records=[]
 for direction in [1,-1]:
  for entry in ["idle","strike_recover"]:
   world.arena_active=false
   world.exit_unlocked=false
   world.projectiles.clear()
   boss.position=origin
   boss.hp=8
   boss.facing=direction
   boss.enter("idle")
   boss.visual.visible=true
   world.hero.reset_at(origin+Vector2(direction*145,0))
   world.hero.facing=-direction
   var actual_hits=[]
   for hit in 7:
    world.hero.controls.set_action("whip",true)
    for tick in 65: await advance()
    world.hero.controls.set_action("whip",false)
    actual_hits.append(boss.hp)
    if boss.hp!=7-hit:
     fail("actual production8HP prelude hit"+str(hit))
     return
   # Explicit entry fixtures isolate standing and supported recovery kills;
   # health is earned by seven actual attacks, not a substituted1HP spawn.
   boss.enter(entry)
   if entry=="strike_recover": boss.elapsed=.15
   boss.simulate(0)
   var label=("right" if direction>0 else "left")+"-"+entry
   var samples=[await snap(output,"before-"+label+".png")]
   world.hero.controls.set_action("whip",true)
   for tick in 40:
    await advance()
    if boss.hp==0: break
   world.hero.controls.set_action("whip",false)
   if boss.hp!=0 or boss.state!="death":
    fail("eighth actual whip must kill")
    return
   actual_hits.append(boss.hp)
   if boss.visual.sprite_frames.get_frame_texture("boss_death",0)!=boss.visual.sprite_frames.get_frame_texture(boss.death_entry_animation,boss.death_entry_frame):
    fail("lethal paint must be preserved in first90ms")
    return
   var seen={}
   for tick in 146:
    if tick>0: await advance()
    if boss.position!=origin or boss.hp!=0:
     fail("dead root/HP")
     return
    if boss.elapsed<1.08 and world.exit_unlocked:
     fail("early exit")
     return
    if not seen.has(boss.visual.frame):
     seen[boss.visual.frame]=true
     samples.append(await snap(output,"death-%s-f%02d.png"%[label,boss.visual.frame]))
    if boss.elapsed>=1.08: break
   if seen.size()!=12 or boss.visual.frame!=11 or not world.exit_unlocked:
    fail("12frames and1080ms unlock")
    return
   samples.append(await snap(output,"unlock-"+label+".png"))
   while boss.elapsed<1.14: await advance()
   samples.append(await snap(output,"fade-"+label+".png"))
   while boss.elapsed<=1.2: await advance()
   samples.append(await snap(output,"cleanup-"+label+".png"))
   if boss.visual.visible:
    fail("cleanup after1200ms")
    return
   records.append({"direction":direction,"entry_fixture":entry,"death_entry_animation":boss.death_entry_animation,"death_entry_frame":boss.death_entry_frame,"first_frame_preserves_entry":true,"production_start_hp":8,"actual_whip_hit_hp":actual_hits,"samples":samples})
 var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"viewport":root.size,"physical_device":false,"records":records}," "))
 print("PASS boss death capture: eight actual whips,12frames,bothfacings,standing/stooped entry,1080ms unlock,1200ms cleanup")
 quit()
