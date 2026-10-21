extends SceneTree
func _initialize():call_deferred("run")
func run():
 var paths=[]
 for page in JSON.parse_string(FileAccess.get_file_as_string("res://data/atlas.json")).pages:paths.append(page.path)
 for entry in JSON.parse_string(FileAccess.get_file_as_string("res://data/background_art.json")).assets.values():paths.append(entry.path)
 var rows=[]
 for path in paths:
  var texture=load(path)
  var image=texture.get_image()
  if image==null or image.is_empty():printerr("FAIL decoded texture "+path);quit(1);return
  image.convert(Image.FORMAT_RGBA8)
  var bytes=image.get_data()
  var hasher=HashingContext.new()
  hasher.start(HashingContext.HASH_SHA256)
  hasher.update(bytes)
  rows.append({"path":path,"width":image.get_width(),"height":image.get_height(),"rgba_bytes":bytes.size(),"sha256":hasher.finish().hex_encode()})
 FileAccess.open(OS.get_cmdline_user_args()[0],FileAccess.WRITE).store_string(JSON.stringify({"textures":rows}," "))
 print("PASS decoded texture inventory: ",rows.size())
 quit()
