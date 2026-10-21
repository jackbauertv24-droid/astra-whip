class_name WhipImpactLayer
extends Node2D
var clip_id="vfx_whip_impact"
var frames: Array[Texture2D] = []
var durations: Array = []
var canvas_size=Vector2.ZERO
var anchor=Vector2.ZERO
var bursts: Array = []
var reduced=false
func _ready():
 z_index=10
 texture_filter=CanvasItem.TEXTURE_FILTER_LINEAR
 var contract: Dictionary=JSON.parse_string(FileAccess.get_file_as_string("res://data/art_contract.json"))
 var spec: Dictionary=contract.clips[clip_id]
 durations=spec.ms
 canvas_size=Vector2(spec.canvas[0],spec.canvas[1])
 anchor=Vector2(spec.anchor[0],spec.anchor[1])
 for frame in durations.size():
  var path="res://assets/vfx/%s/f%03d.png"%[clip_id,frame]
  if PackedArt.exists(path): frames.append(PackedArt.texture(path))
func frame_at(age: float)->int:
 if age<0: return -1
 var time=age*1000.0
 for frame in durations.size():
  if time<float(durations[frame]): return frame
  time-=float(durations[frame])
 return -1
func spawn_at(point: Vector2):
 bursts.append({"position":point,"age":0.0})
 queue_redraw()
func advance(dt: float):
 for index in range(bursts.size()-1,-1,-1):
  bursts[index].age+=dt
  if frame_at(bursts[index].age)<0: bursts.remove_at(index)
 queue_redraw()
func clear():
 bursts.clear()
 queue_redraw()
func _draw():
 if frames.size()!=durations.size(): return
 var tint=Color(1,1,1,.55 if reduced else 1.0)
 for burst in bursts:
  var frame=frame_at(burst.age)
  if frame>=0: draw_texture_rect(frames[frame],Rect2(burst.position-anchor*.5,canvas_size*.5),false,tint)
