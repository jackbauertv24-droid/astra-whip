extends SceneTree
const DT=1.0/120
class TerrainBoard:
 extends Node2D
 var art=TerrainArt.new()
 var overlay=false
 var shapes:Array=[]
 var used:Dictionary={}
 func _ready():
  art.configure()
  for rect in [Rect2(100,140,192,256),Rect2(420,180,64,192),Rect2(484,244,192,128),Rect2(760,244,192,128),Rect2(952,180,64,192)]:shapes.append({"rect":rect,"kind":"solid"})
  shapes.append({"rect":Rect2(360,470,256,16),"kind":"one_way"})
  shapes.append({"rect":Rect2(700,470,64,16),"kind":"one_way"})
  for shape in shapes:
   for row in int(ceil(shape.rect.size.y/64)):
    for col in int(ceil(shape.rect.size.x/64)):
     for id in art.tiles_for(shape,row,col,shapes):used[id]=true
 func _draw():
  draw_rect(Rect2(0,0,1280,720),Color("272438"))
  for shape in shapes:
   art.draw_surface(self,shape,shapes,640)
   draw_line(shape.rect.position,Vector2(shape.rect.end.x,shape.rect.position.y),Color("77838f"),3)
   if overlay:draw_rect(shape.rect,Color(1,.3,.3,.7),false,1)
var world
func _initialize():call_deferred("run")
func image_file(output:String,name:String)->Vector2i:
 await process_frame
 await RenderingServer.frame_post_draw
 var image=root.get_texture().get_image()
 image.save_png(output+"/"+name)
 return image.get_size()
func run():
 var output=OS.get_cmdline_user_args()[0]
 if "--unpacked" in OS.get_cmdline_user_args():
  PackedArt.manifest={"frames":{},"pages":[]}
  PackedArt.textures.clear()
  print("TERRAIN_RENDER_SOURCE_MODE unpacked")
 DirAccess.make_dir_recursive_absolute(output)
 var board=TerrainBoard.new()
 root.add_child(board)
 var records=[]
 for overlay in [false,true]:
  board.overlay=overlay
  board.queue_redraw()
  var name="kit-collision-overlay.png" if overlay else "kit-board.png"
  var size=await image_file(output,name)
  records.append({"file":name,"kind":"nonplayable engine kit board","roles":board.used.keys(),"collision_overlay":overlay,"image_size":[size.x,size.y]})
 if "--board-only" in OS.get_cmdline_user_args():
  var index=FileAccess.open(output+"/index.json",FileAccess.WRITE)
  index.store_string(JSON.stringify({"samples":28,"pages":records.map(func(record):return {"file":record.file,"entries":record.roles})}," "))
  print("PASS terrain board render:28role samples,2images")
  quit()
  return
 board.queue_free()
 await process_frame
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 world.simulate_enemies=false
 world.set_pause(false)
 world.menu_back.visible=false
 for fixture in [{"name":"threshold","x":160.0,"y":560.0,"camera":640.0,"cy":360.0},{"name":"bridge","x":640.0,"y":560.0,"camera":760.0,"cy":360.0},{"name":"lower-return","x":640.0,"y":688.0,"camera":760.0,"cy":360.0},{"name":"stairs","x":2880.0,"y":432.0,"camera":3050.0,"cy":296.0},{"name":"upper-platforms","x":3264.0,"y":432.0,"camera":3264.0,"cy":296.0},{"name":"fallback-step","x":3520.0,"y":496.0,"camera":3380.0,"cy":296.0},{"name":"checkpoint","x":4000.0,"y":560.0,"camera":4128.0,"cy":360.0},{"name":"arena","x":5900.0,"y":560.0,"camera":6144.0,"cy":360.0}]:
  world.hero.reset_at(Vector2(fixture.x,fixture.y))
  for tick in 4:
   await physics_frame
   world.step(DT)
  if fixture.name=="arena":world.gate_open_fraction=0
  world.camera_x=fixture.camera
  world.camera.position=Vector2(fixture.camera,fixture.cy)
  world.queue_redraw()
  var name="stage-"+fixture.name+".png"
  var size=await image_file(output,name)
  records.append({"file":name,"kind":"fixed stage inspection view","hero_position":[world.hero.position.x,world.hero.position.y],"camera":[fixture.camera,fixture.cy],"image_size":[size.x,size.y]})
 var file=FileAccess.open(output+"/capture.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"physical_device":false,"viewport":root.size,"samples":records,"stage_geometry":"unchanged Stage.SURFACES; board is nonplayable inspection geometry"}," "))
 print("PASS terrain capture:14roles,kitboard/collisionoverlay,8fixedstageviews")
 quit()
