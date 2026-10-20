extends SceneTree
class PoseActor:
 extends Node2D
 var facing=1
 var hurt_pose_context=""
var actors={}
func _initialize(): call_deferred("run")
func run():
 root.size=Vector2i(1280,720)
 var output=OS.get_cmdline_user_args()[0]
 if "--unpacked" in OS.get_cmdline_user_args():
  PackedArt.manifest={"frames":{},"pages":[]}
  PackedArt.textures.clear()
  print("ATLAS_CAPTURE_SOURCE_MODE unpacked original textures")
 DirAccess.make_dir_recursive_absolute(output)
 var background=ColorRect.new()
 background.color=Color("272438")
 background.size=Vector2(1280,720)
 root.add_child(background)
 for kind in ["hero","pursuer","swooper","ranged","boss"]:
  var parent=PoseActor.new()
  root.add_child(parent)
  var visual=ActorVisual.new()
  parent.add_child(visual)
  visual.configure(kind)
  actors[kind]=parent
 var entries=[]
 for kind in actors:
  var visual=actors[kind].get_child(0)
  for id in visual.specs:
   if not id.begins_with(kind+"_"): continue
   if not visual.body_clips.get(id,false): continue
   var elapsed=0.0
   for frame in visual.specs[id].ms.size():
    var duration=float(visual.specs[id].ms[frame])/1000
    for facing in [1,-1]: entries.append({"kind":kind,"id":id,"frame":frame,"facing":facing,"elapsed":elapsed+duration*.5})
    elapsed+=duration
 var contract: Dictionary=JSON.parse_string(FileAccess.get_file_as_string("res://data/art_contract.json"))
 for id in contract.clips:
  var spec: Dictionary=contract.clips[id]
  if spec.actor!="vfx": continue
  var complete=true
  for frame in spec.ms.size():
   if not PackedArt.exists("res://assets/vfx/"+id+"/f%03d.png"%frame): complete=false
  if not complete: continue
  for frame in spec.ms.size():
   for facing in [1,-1]: entries.append({"kind":"vfx","id":id,"frame":frame,"facing":facing,"elapsed":0.0})
 var cells=[]
 for i in 6:
  var parent=PoseActor.new()
  root.add_child(parent)
  cells.append(parent)
 var page=0
 var records=[]
 for start in range(0,entries.size(),6):
  for cell in cells:
   for child in cell.get_children(): child.free()
  for i in mini(6,entries.size()-start):
   var entry=entries[start+i]
   var parent=cells[i]
   parent.facing=entry.facing
   parent.position=Vector2((i%3)*426+(160 if entry.facing==1 else 260),(i/3)*360+300)
   if entry.kind=="vfx":
    var sprite=Sprite2D.new()
    parent.add_child(sprite)
    var spec: Dictionary=contract.clips[entry.id]
    sprite.texture=PackedArt.texture("res://assets/vfx/"+entry.id+"/f%03d.png"%entry.frame)
    sprite.scale=Vector2(.5,.5)
    sprite.flip_h=entry.facing<0
    sprite.offset=Vector2(spec.canvas[0],spec.canvas[1])*.5-Vector2(spec.anchor[0],spec.anchor[1])
    if sprite.flip_h: sprite.offset.x=-sprite.offset.x
    continue
   var visual=ActorVisual.new()
   parent.add_child(visual)
   visual.configure(entry.kind)
   var state=entry.id.trim_prefix(entry.kind+"_")
   if entry.kind=="boss" and state.begins_with("hurt_"):
    parent.hurt_pose_context=state.trim_prefix("hurt_")
    state="hurt"
   else: parent.hurt_pose_context=""
   visual.follow(state,entry.elapsed/visual.playback_rate(state))
   visual.visible=true
   if visual.frame!=entry.frame:
    printerr("FAIL atlas frame "+str(entry))
    quit(1)
    return
  for parent in actors.values(): parent.visible=false
  await process_frame
  await RenderingServer.frame_post_draw
  var filename="page-%03d.png"%page
  root.get_texture().get_image().save_png(output+"/"+filename)
  records.append({"file":filename,"entries":entries.slice(start,mini(start+6,entries.size()))})
  page+=1
 var file=FileAccess.open(output+"/index.json",FileAccess.WRITE)
 file.store_string(JSON.stringify({"samples":entries.size(),"pages":records},"  "))
 print("RESULT atlas capture: ",entries.size()," samples, ",page," pages")
 quit()
