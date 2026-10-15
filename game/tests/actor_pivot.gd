extends SceneTree
class PivotActor extends Node2D:
 var facing = 1
func _initialize() -> void:
 call_deferred("run")
func run() -> void:
 var contract_data: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://data/art_contract.json"))
 var failures = 0
 for kind in contract_data.actors:
  var actor = PivotActor.new()
  root.add_child(actor)
  actor.position = Vector2(321,217)
  var visual = ActorVisual.new()
  actor.add_child(visual)
  visual.configure(kind)
  var spec: Dictionary = contract_data.actors[kind]
  var size = Vector2i(int(spec.canvas[0]),int(spec.canvas[1]))
  var mark = Vector2(float(spec.pivot[0]),float(spec.pivot[1]))
  var image = Image.create(size.x,size.y,false,Image.FORMAT_RGBA8)
  image.fill(Color.TRANSPARENT)
  image.set_pixel(int(mark.x),int(mark.y),Color.WHITE)
  var texture = ImageTexture.create_from_image(image)
  var clip: String = visual.sprite_frames.get_animation_names()[0]
  visual.sprite_frames.set_frame(clip,0,texture)
  for mirrored in [false,true]:
   actor.facing = -1 if mirrored else 1
   visual.follow(clip.substr(kind.length()+1),0)
   var point = Vector2(size.x-mark.x,mark.y) if mirrored else mark
   var world_point = visual.to_global(point-Vector2(size)*0.5+visual.offset)
   if world_point.distance_to(actor.position)>0.01:
    failures+=1
    printerr("FAIL registered pivot ",kind," mirrored=",mirrored," delta=",world_point-actor.position)
  actor.queue_free()
 print("ACTOR PIVOT: ",failures," failures")
 quit(0 if failures==0 else 1)
