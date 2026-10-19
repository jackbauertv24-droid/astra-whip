class_name PackedArt
extends RefCounted
# Atlas margins preserve authored canvas size and pivot; no source image changes.
static var manifest: Dictionary = {}
static var textures: Dictionary = {}
static func initialize() -> void:
 if manifest.is_empty(): manifest=JSON.parse_string(FileAccess.get_file_as_string("res://data/atlas.json"))
static func exists(path: String) -> bool:
 initialize()
 return manifest.frames.has(path) or ResourceLoader.exists(path)
static func texture(path: String) -> Texture2D:
 initialize()
 if textures.has(path): return textures[path]
 if not manifest.frames.has(path): return load(path)
 var entry: Dictionary=manifest.frames[path]
 var packed=AtlasTexture.new()
 packed.atlas=load(manifest.pages[int(entry.page)].path)
 packed.region=Rect2(entry.region[0],entry.region[1],entry.region[2],entry.region[3])
 packed.margin=Rect2(entry.trim[0],entry.trim[1],entry.canvas[0]-entry.region[2],entry.canvas[1]-entry.region[3])
 packed.filter_clip=true
 textures[path]=packed
 return packed
