class_name TerrainArt
extends RefCounted
const MODULE=64.0
var textures:Dictionary={}
func configure():
 var specs:Dictionary=JSON.parse_string(FileAccess.get_file_as_string("res://data/static_art.json"))
 for id in specs:
  if specs[id].category=="terrain":textures[id]=PackedArt.texture("res://assets/terrain/"+id+"/f000.png")
func occupied(point:Vector2,shapes:Array)->bool:
 for shape in shapes:
  if shape.rect.has_point(point):return true
 return false
func tiles_for(surface:Dictionary,row:int,col:int,shapes:Array)->Array:
 var rect:Rect2=surface.rect
 var columns=int(ceil(rect.size.x/MODULE))
 var rows=int(ceil(rect.size.y/MODULE))
 var first=col==0
 var last=col==columns-1
 if surface.kind=="one_way":
  if first and last:return ["terrain_plat_end_left","terrain_plat_end_right"]
  return ["terrain_plat_end_left" if first else ("terrain_plat_end_right" if last else "terrain_plat_mid")]
 var x=rect.position.x+col*MODULE
 var y=rect.position.y+row*MODULE
 var mid=Vector2(x+minf(MODULE,rect.end.x-x)*.5,y+minf(MODULE,rect.end.y-y)*.5)
 var left=first and not occupied(Vector2(rect.position.x-.1,mid.y),shapes)
 var right=last and not occupied(Vector2(rect.end.x+.1,mid.y),shapes)
 if row==0 and not occupied(Vector2(mid.x,rect.position.y-.1),shapes):
  var a="terrain_inner_left" if occupied(Vector2(rect.position.x-.1,rect.position.y-.1),shapes) else "terrain_cap_left"
  var b="terrain_inner_right" if occupied(Vector2(rect.end.x+.1,rect.position.y-.1),shapes) else "terrain_cap_right"
  if first and last:return [a,b]
  return [a if first else (b if last else "terrain_cap_mid")]
 if row==rows-1 and not occupied(Vector2(mid.x,rect.end.y+.1),shapes):
  if left and right:return ["terrain_bottom_left","terrain_bottom_right"]
  return ["terrain_bottom_left" if left else ("terrain_bottom_right" if right else "terrain_bottom_mid")]
 if left and right:return ["terrain_side_left","terrain_side_right"]
 return ["terrain_side_left" if left else ("terrain_side_right" if right else "terrain_fill_center")]
func draw_surface(target:CanvasItem,surface:Dictionary,shapes:Array,camera_x:float):
 var rect:Rect2=surface.rect
 for row in int(ceil(rect.size.y/MODULE)):
  for col in int(ceil(rect.size.x/MODULE)):
   var at=rect.position+Vector2(col,row)*MODULE
   if absf(at.x-camera_x)>800:continue
   var size=Vector2(minf(MODULE,rect.end.x-at.x),minf(MODULE,rect.end.y-at.y))
   var ids=tiles_for(surface,row,col,shapes)
   if ids.size()==1:
    target.draw_texture_rect_region(textures[ids[0]],Rect2(at,size),Rect2(Vector2.ZERO,size*2))
   else:
    var half=Vector2(size.x*.5,size.y)
    target.draw_texture_rect_region(textures[ids[0]],Rect2(at,half),Rect2(Vector2.ZERO,half*2))
    target.draw_texture_rect_region(textures[ids[1]],Rect2(at+Vector2(half.x,0),half),Rect2(Vector2(128-half.x*2,0),half*2))
