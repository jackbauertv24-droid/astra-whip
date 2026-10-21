class_name BackgroundArt
extends Node2D
var spec:Dictionary
var sky:Sprite2D
var repeats=[]
var framing:Sprite2D
var world
func configure(owner_world:Node2D):
 world=owner_world
 texture_filter=CanvasItem.TEXTURE_FILTER_LINEAR
 spec=JSON.parse_string(FileAccess.get_file_as_string("res://data/background_art.json"))
 z_index=-20
 sky=Sprite2D.new()
 sky.centered=false
 sky.texture=load(spec.assets.bg_sky.path)
 sky.scale=Vector2(1.25,1.25)
 sky.position=Vector2(0,-280)
 add_child(sky)
 for id in ["bg_distant_silhouette","bg_midground_arch"]:
  var entry=spec.assets[id]
  var material=ShaderMaterial.new()
  material.shader=load("res://shaders/background.gdshader")
  for i in range(-1,3):
   var sprite=Sprite2D.new()
   sprite.centered=false
   sprite.texture=load(entry.path)
   sprite.scale=Vector2.ONE*float(entry.scale)
   sprite.material=material
   add_child(sprite)
   repeats.append({"sprite":sprite,"copy":i,"entry":entry})
 framing=Sprite2D.new()
 framing.texture_filter=CanvasItem.TEXTURE_FILTER_LINEAR
 framing.centered=false
 framing.texture=load(spec.assets.bg_foreground_frame.path)
 framing.scale=Vector2(.625,.625)
 framing.z_index=20
 world.add_child(framing)
 update_camera()
func update_camera():
 var origin=world.camera.position-Vector2(640,360)
 position=origin
 for item in repeats:
  var period=float(item.entry.canvas[0])*float(item.entry.scale)
  item.sprite.position=Vector2(-fposmod(world.camera_x*float(item.entry.parallax),period)+item.copy*period,float(item.entry.world_y)-origin.y)
 framing.position=origin
 framing.visible=false
 for segment in spec.foreground_segments:
  if world.hero.position.x>=segment.start and world.hero.position.x<segment.end:framing.visible=true
func _draw():
 draw_rect(Rect2(0,0,1280,720),Color("171221"))
