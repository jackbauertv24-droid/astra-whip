extends SceneTree
const DT=1.0/120
var world
var checks=0
var failures=0
var output=""
var captures=[]
var capture_prefix=""
func capture(label:String):
 if output=="" or capture_prefix=="":return
 world.queue_redraw()
 await process_frame
 await RenderingServer.frame_post_draw
 var image=root.get_texture().get_image()
 var filename=capture_prefix+"-"+label+".png"
 image.save_png(output+"/"+filename)
 var buttons={}
 for action in world.touch_buttons:
  var control=world.touch_buttons[action]
  buttons[action]={"position":[control.position.x,control.position.y],"size":[control.size.x,control.size.y]}
 captures.append({"file":filename,"image_size":[image.get_width(),image.get_height()],"hero":[world.hero.position.x,world.hero.position.y],"camera":[world.camera.position.x,world.camera.position.y],"buttons":buttons})
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL playfield clearance: "+message)
func _initialize():call_deferred("run")
func tick(count:int):
 for i in count:
  await physics_frame
  world.step(DT)
func floor_visible(y:float,message:String):
 var scale=world.ui_units_to_css_pixels()
 var top=720.0
 for button in world.touch_buttons.values():top=minf(top,button.position.y)
 var screen_y=y-world.camera.position.y+360
 check((top-screen_y)*scale.y>=15.9,message+" gapCSS="+str((top-screen_y)*scale.y))
func run():
 if OS.get_cmdline_user_args().size()>0:
  output=OS.get_cmdline_user_args()[0]
  DirAccess.make_dir_recursive_absolute(output)
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 for c in [[Vector2i(1280,720),1.0,Vector4.ZERO],[Vector2i(852,393),1.0,Vector4(44,0,44,21)],[Vector2i(568,320),1.0,Vector4(44,0,44,21)],[Vector2i(1704,786),2.0,Vector4(44,0,44,21)]]:
  if output!="" and c[0].x not in [1280,852]:continue
  capture_prefix="native" if c[0].x==1280 else ("phone" if c[0].x==852 else "")
  root.size=c[0]
  for i in 5:await process_frame
  world.layout_ui_for_insets(c[2],c[1])
  world.checkpoint=false
  world.respawn=Vector2(160,560)
  world.restart()
  world.simulate_enemies=false
  world.set_pause(false)
  await tick(4)
  check(absf(world.hero.position.x-world.camera.position.x)<620,"retry camera immediately contains respawned hero")
  floor_visible(688,"lower landing visible from encounter entry "+str(c[0]))
  await capture("entry")
  world.hero.controls.set_action("right",true)
  var reached_lower=false
  var captured_approach=false
  for i in 300:
   await tick(1)
   if world.hero.position.x>=480:floor_visible(688,"lower landing stays above thumbs during approach/fall")
   if world.hero.position.x>=480 and not captured_approach:
    captured_approach=true
    await capture("approach")
   if world.hero.position.y>680 and world.hero.is_on_floor():
    reached_lower=true
    break
  check(reached_lower,"actual walk off bridge approach reaches lower route")
  check(world.hero.position.x>512 and world.hero.position.x<896,"landed within lower corridor")
  await capture("lower-landing")
  await tick(65)
  world.hero.controls.set_action("right",false)
  floor_visible(world.hero.position.y,"actual grounded lower-route feet above thumbs")
  world.hero.controls.set_action("right",true)
  for i in 120:
   if world.hero.position.x>=848:break
   await tick(1)
  world.hero.controls.set_action("jump",true)
  await tick(1)
  world.hero.controls.set_action("jump",false)
  await tick(120)
  check(world.hero.is_on_floor() and absf(world.hero.position.y-624)<1,"actual jump reaches lower return step")
  floor_visible(624,"return step visible")
  await capture("return-step")
  world.hero.controls.set_action("jump",true)
  await tick(1)
  world.hero.controls.set_action("jump",false)
  await tick(120)
  check(world.hero.position.x>960 and world.hero.is_on_floor() and absf(world.hero.position.y-560)<1,"actual second jump returns to main route")
  world.hero.controls.set_action("right",false)
  floor_visible(560,"main-route return visible")
  await capture("main-return")
  for fixture in [Vector2(1120,560),Vector2(2880,432),Vector2(3520,496),Vector2(4128,560),Vector2(5900,560)]:
   world.hero.reset_at(fixture)
   await tick(90)
   floor_visible(maxf(560,fixture.y),"authored encounter/ground fallback floor "+str(fixture))
   await capture("stage-"+str(int(fixture.x)))
 if output!="":
  var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
  file.store_string(JSON.stringify({"physical_device":false,"samples":captures,"route":"entry/approach/lower landing/two jumps are actual input-driven traversal; stage-* are fixed inspection positions"}," "))
 print("RESULT playfield clearance: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
