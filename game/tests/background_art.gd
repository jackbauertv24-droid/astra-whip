extends SceneTree
var checks=0
var failures=0
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL background art: "+message)
func _initialize():call_deferred("run")
func run():
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 var art=world.background_art
 check(art.z_index<0 and art.framing.z_index>0,"background and framing depth order")
 check(art.repeats.size()==8,"four repeated copies of each parallax panel")
 var specs=art.spec.assets
 check(specs.size()==4,"four mandatory backgrounds")
 for id in specs:
  var texture=load(specs[id].path)
  check(texture.get_size()==Vector2(specs[id].canvas[0],specs[id].canvas[1]),"brief source canvas "+id)
  check(specs[id].collision=="none","no collision "+id)
  check(not PackedArt.manifest.frames.has(specs[id].path),"wide panel remains standalone "+id)
 world.camera_x=640
 world.camera.position=Vector2(640,488)
 art.update_camera()
 var before=art.repeats.map(func(item):return item.sprite.position.x)
 world.camera_x=768
 world.camera.position=Vector2(768,488)
 art.update_camera()
 for i in art.repeats.size():
  var item=art.repeats[i]
  check(absf(item.sprite.position.x-before[i]+128*float(item.entry.parallax))<.01,"parallax displacement "+str(i))
  check(item.sprite.material!=null,"background-only joining shader "+str(i))
 for x in [160,700,1120,2880,3520,4128,4900,5900]:
  world.hero.position.x=x
  art.update_camera()
  check(art.framing.visible==(x<1024 or (x>=4032 and x<5312)),"non-tiled level framing segment "+str(x))
 check(art.framing.scale==Vector2(.625,.625),"uniform framing scale")
 check(art.sky.scale==Vector2(1.25,1.25),"uniform non-tiled sky cover")
 world.hero.position.x=5900
 world.restart()
 check(art.position==world.camera.position-Vector2(640,360),"retry refreshes depth stack camera")
 print("RESULT background art: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
