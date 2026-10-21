extends SceneTree
var checks=0
var failures=0
func check(ok:bool,message:String):
 checks+=1
 if not ok:
  failures+=1
  printerr("FAIL painted sampling: "+message)
func _initialize():call_deferred("run")
func run():
 check(root.canvas_item_default_texture_filter==Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_LINEAR,"viewport default is linear without mip sampling")
 var world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 await process_frame
 if "--negative-nearest" in OS.get_cmdline_user_args():world.rotate_graphic.texture_filter=CanvasItem.TEXTURE_FILTER_NEAREST
 var nodes=world.find_children("*","CanvasItem",true,false)
 nodes.append(world)
 for node in nodes:
  check(node.texture_filter in [CanvasItem.TEXTURE_FILTER_PARENT_NODE,CanvasItem.TEXTURE_FILTER_LINEAR],"painted node inherits or uses linear "+str(node.get_path()))
 print("RESULT painted sampling: %d checks, %d failures"%[checks,failures])
 quit(1 if failures else 0)
