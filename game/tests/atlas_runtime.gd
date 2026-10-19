extends SceneTree
var checks=0
var failures=0
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL atlas runtime: "+message)
func _initialize(): call_deferred("run")
func run():
 root.size=Vector2i(1280,720)
 for frame in 5: await process_frame
 var baseline=RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TEXTURE_MEM_USED)
 var exported="--exported" in OS.get_cmdline_user_args()
 PackedArt.initialize()
 var pages={}
 for path in PackedArt.manifest.frames:
  var entry=PackedArt.manifest.frames[path]
  var texture=PackedArt.texture(path)
  check(texture is AtlasTexture,"frame uses atlas")
  check(texture.get_size()==Vector2(entry.canvas[0],entry.canvas[1]),"authored canvas preserved "+path)
  check(texture.margin.position==Vector2(entry.trim[0],entry.trim[1]),"trim origin preserved")
  check(texture.filter_clip,"neighbor clipping enabled")
  check(PackedArt.texture(path)==texture,"frame cached")
  pages[texture.atlas.get_instance_id()]=true
  if exported: check(not ResourceLoader.exists(path),"packed original excluded from export "+path)
 check(pages.size()==PackedArt.manifest.pages.size(),"pages shared by all frames")
 print("ATLAS_BEFORE_WORLD ",RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TEXTURE_MEM_USED)," window ",root.size)
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 for frame in 5: await process_frame
 var bytes=RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TEXTURE_MEM_USED)
 if DisplayServer.get_name()!="headless":
  check(bytes>0,"renderer reports actual texture memory")
  check(bytes-baseline<=128*1024*1024,"observed art allocation stays within starting budget")
 print("ATLAS_MEMORY ",JSON.stringify({"exported":exported,"renderer":RenderingServer.get_video_adapter_name(),"total_bytes":bytes,"empty_scene_bytes":baseline,"art_delta_bytes":bytes-baseline,"physical_device":false}))
 print("RESULT atlas runtime: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
