class_name PaintedControls
extends RefCounted
var entries:Dictionary={}
func configure(world:Node):
 var controls=world.touch_buttons.duplicate()
 controls.pause=world.pause_button
 for action in controls:
  var control:Button=controls[action]
  var frames:Array[Texture2D]=[]
  for frame in 2:frames.append(PackedArt.texture("res://assets/ui/ui_btn_"+action+"/f%03d.png"%frame))
  var plate=TextureRect.new()
  plate.name="PaintedPlate"
  plate.expand_mode=TextureRect.EXPAND_IGNORE_SIZE
  plate.stretch_mode=TextureRect.STRETCH_KEEP_ASPECT_CENTERED
  plate.mouse_filter=Control.MOUSE_FILTER_IGNORE
  plate.texture_filter=CanvasItem.TEXTURE_FILTER_LINEAR
  plate.show_behind_parent=true
  control.add_child(plate)
  plate.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
  var style=StyleBoxEmpty.new()
  for state in ["normal","pressed","hover","hover_pressed","focus","disabled"]:control.add_theme_stylebox_override(state,style)
  entries[action]={"control":control,"frames":frames,"plate":plate,"style":style}
 refresh()
func layout(css_scale:Vector2):
 for entry in entries.values():entry.style.content_margin_top=28/maxf(css_scale.y,.001)
func refresh():
 for entry in entries.values():
  entry.plate.texture=entry.frames[1 if entry.control.button_pressed else 0]
  entry.plate.modulate=Color(1,1,1,.45 if entry.control.disabled else 1)
