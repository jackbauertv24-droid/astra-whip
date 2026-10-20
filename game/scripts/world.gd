extends Node2D
const TOUCH_TARGET_CSS=64.0
const TOUCH_BASE_SIZE=Vector2(116,104)
var hero: Hunter
var surfaces: Array = []
var foes: Array = []
var projectiles: Array = []
var checkpoint_layer: WhipImpactLayer
var checkpoint_frames: Array[Texture2D] = []
var checkpoint_spec: Dictionary
var defeat_layer: WhipImpactLayer
var impact_layer: WhipImpactLayer
var projectile_frames: Array[Texture2D] = []
var projectile_durations: Array = []
var projectile_canvas = Vector2.ZERO
var projectile_anchor = Vector2.ZERO
var respawn = Vector2(160, Rules.GROUND)
var checkpoint = false
var exit_unlocked = false
var arena_active = false
var complete = false
var paused = true
var started = false
var testing = false
var simulate_enemies = true
var pit_timer = -1.0
var camera_x = 640.0
var camera: Camera2D
var hud: CanvasLayer
var status: Label
var menu_scroll: ScrollContainer
var menu: VBoxContainer
var menu_back: Panel
var rotate_prompt: Label
var rotate_back: Panel
var pause_button: Button
var gates: Array = []
var effigy = true
var reduced_effects = false
var touch_buttons: Dictionary = {}
var touch_button_origins: Dictionary = {}
var ui_backing_ratio=1.0
var ui_safe_rect=Rect2(0,0,1280,720)
var backdrop: Texture2D = preload("res://assets/style/background.png")
var masonry: Texture2D = preload("res://assets/style/terrain.png")
func load_projectile_art() -> void:
 var spec: Dictionary = JSON.parse_string(FileAccess.get_file_as_string("res://data/art_contract.json")).clips.projectile_grave_shot
 projectile_durations = spec.ms
 projectile_canvas = Vector2(spec.canvas[0],spec.canvas[1])
 projectile_anchor = Vector2(spec.anchor[0],spec.anchor[1])
 projectile_frames.clear()
 for frame in spec.ms.size():
  var path = "res://assets/vfx/projectile_grave_shot/f%03d.png"%frame
  if PackedArt.exists(path): projectile_frames.append(PackedArt.texture(path))
func projectile_frame_at(age: float) -> int:
 var duration = 0.0
 for ms in projectile_durations: duration += float(ms)
 var time = fposmod(age*1000,duration)
 for frame in projectile_durations.size():
  if time < float(projectile_durations[frame]): return frame
  time -= float(projectile_durations[frame])
 return projectile_durations.size()-1
func _ready() -> void:
 load_projectile_art()
 checkpoint_spec=JSON.parse_string(FileAccess.get_file_as_string("res://data/static_art.json")).prop_checkpoint
 for frame in checkpoint_spec.frames:
  checkpoint_frames.append(PackedArt.texture("res://assets/props/prop_checkpoint/f%03d.png"%frame))
 checkpoint_layer=WhipImpactLayer.new()
 checkpoint_layer.clip_id="vfx_checkpoint_activate"
 add_child(checkpoint_layer)
 defeat_layer=WhipImpactLayer.new()
 defeat_layer.clip_id="vfx_enemy_defeat"
 add_child(defeat_layer)
 impact_layer=WhipImpactLayer.new()
 add_child(impact_layer)
 for row in Stage.SURFACES:
  add_surface(Rect2(float(row[0])*64,Rules.GROUND-float(row[2])*64,float(row[1]-row[0])*64,float(row[4])),row[3])
 add_surface(Rect2(-32,-1000,32,2200),"solid")
 add_surface(Rect2(Rules.WIDTH,-1000,32,2200),"solid")
 hero = Hunter.new()
 hero.world = self
 add_child(hero)
 hero.position = respawn
 hero.died.connect(restart)
 camera = Camera2D.new()
 camera.position = Vector2(640,360)
 add_child(camera)
 build_enemies()
 for x in [5596,6528]:
  var gate = add_surface(Rect2(x,-500,16,1060),"solid",false)
  gates.append(gate)
 build_ui()
func add_surface(rect: Rect2, kind: String, enabled: bool = true) -> Dictionary:
 var body = StaticBody2D.new()
 body.collision_layer = 1 if enabled else 0
 body.collision_mask = 0
 var shape = CollisionShape2D.new()
 var box = RectangleShape2D.new()
 box.size = rect.size
 shape.shape = box
 shape.position = rect.get_center()
 shape.one_way_collision = kind == "one_way"
 shape.one_way_collision_margin = 1
 body.add_child(shape)
 add_child(body)
 var data = {"rect":rect,"kind":kind,"node":body,"enabled":enabled}
 if enabled: surfaces.append(data)
 return data
func build_enemies() -> void:
 for foe in foes: foe.queue_free()
 foes.clear()
 for row in Stage.ENCOUNTERS:
  var foe = Foe.new()
  foe.kind = row[0]
  foe.floor_y = Rules.GROUND - float(row[2])*64
  foe.position = Vector2(row[1],foe.floor_y - (182.5 if foe.kind == "swooper" else 0))
  foe.bounds = Vector2(row[3],row[4])
  foe.world = self
  add_child(foe)
  foes.append(foe)
func set_gate(enabled: bool) -> void:
 for gate in gates:
  gate.node.collision_layer = 1 if enabled else 0
  if enabled and not gate in surfaces: surfaces.append(gate)
  if not enabled: surfaces.erase(gate)
func restart() -> void:
 if complete:
  checkpoint = false
  respawn = Vector2(160,Rules.GROUND)
 complete = false
 exit_unlocked = false
 arena_active = false
 pit_timer = -1
 projectiles.clear()
 impact_layer.clear()
 defeat_layer.clear()
 checkpoint_layer.clear()
 effigy = true
 set_gate(false)
 hero.reset_at(respawn)
 build_enemies()
 if not testing: set_pause(false)
func pit_fall() -> void:
 if pit_timer < 0: pit_timer = 0
func capture_checkpoint() -> void:
 if checkpoint: return
 checkpoint_layer.spawn_at(Vector2(4128,Rules.GROUND))
 checkpoint = true
 respawn = Vector2(4128,Rules.GROUND)
func is_portrait() -> bool:
 var window_size=get_window().size
 return window_size.y>window_size.x
func set_pause(value: bool) -> void:
 paused = value or is_portrait()
 hero.controls.clear()
 update_orientation_ui()
func update_orientation_ui() -> void:
 if not is_instance_valid(rotate_prompt): return
 var portrait=is_portrait()
 if portrait:
  paused=true
  hero.controls.clear()
 menu.visible=(paused or complete) and not portrait
 menu_back.visible=menu.visible
 menu_scroll.visible=menu.visible
 rotate_prompt.visible=portrait
 rotate_back.visible=portrait
 status.visible=not portrait
 for action in touch_buttons: touch_buttons[action].visible=not portrait
 pause_button.disabled=portrait
 pause_button.text="PAUSED" if portrait else ("RESUME" if paused else "PAUSE")
func _notification(what: int) -> void:
 if what == NOTIFICATION_APPLICATION_FOCUS_OUT and is_instance_valid(hero): set_pause(true)
func _process(_dt: float) -> void:
 for action in touch_buttons:
  touch_buttons[action].set_pressed_no_signal(not paused and not complete and hero.controls.is_held(action))
func _physics_process(dt: float) -> void:
 if testing: return
 if is_portrait() and not paused: set_pause(true)
 if not paused and not complete: step(dt)
 status.text = "ASTRA WHIP   |   HEALTH %d/5" % maxi(0,hero.health) + ("   CHECKPOINT LIT" if checkpoint else "   THE ASHEN THRESHOLD")
 if complete: status.text = "THE WARDEN HAS FALLEN — THE WAY IS OPEN"
 menu_back.visible = menu.visible
 queue_redraw()
func step(dt: float) -> void:
 checkpoint_layer.reduced=reduced_effects
 checkpoint_layer.advance(dt)
 defeat_layer.reduced=reduced_effects
 defeat_layer.advance(dt)
 impact_layer.reduced=reduced_effects
 impact_layer.advance(dt)
 if pit_timer >= 0:
  pit_timer += dt
  if pit_timer >= 0.8: restart()
  return
 hero.simulate(dt)
 if simulate_enemies:
  for foe in foes: foe.simulate(dt)
 for index in range(projectiles.size()-1,-1,-1):
  var shot: Dictionary = projectiles[index]
  shot.pos.x += shot.dir * 280 * dt
  shot.age = float(shot.get("age",0.0)) + dt
  if Rect2(shot.pos-Vector2(12.5,12.5),Vector2(25,25)).intersects(hero.body_rect()):
   hero.damage("projectile",shot.pos.x)
   projectiles.remove_at(index)
  elif absf(shot.pos.x-shot.start) >= 640: projectiles.remove_at(index)
 if not checkpoint and absf(hero.position.x-4128) < 36 and absf(hero.position.y-Rules.GROUND) < 30: capture_checkpoint()
 if hero.position.x > 5655 and not exit_unlocked:
  arena_active = true
  set_gate(true)
 if exit_unlocked: set_gate(false)
 if exit_unlocked and hero.position.x > 6600:
  complete = true
  hero.controls.clear()
  menu.visible = true
 if effigy and hero.active() and hero.whip_rect().intersects(Rect2(400,Rules.GROUND-90,32,70)):
  impact_layer.spawn_at(hero.whip_rect().intersection(Rect2(400,Rules.GROUND-90,32,70)).get_center())
  effigy = false
 var target = clampf(hero.position.x+hero.facing*100,640,Rules.WIDTH-640)
 if arena_active and not exit_unlocked: target = 6144
 camera_x = lerpf(camera_x,target,minf(1,dt*7))
 camera.position.x = camera_x
 camera.position.y = lerpf(camera.position.y,296.0 if hero.position.x > 2880 and hero.position.x < 3840 else 360.0,minf(1,dt*5))
func build_ui() -> void:
 hud = CanvasLayer.new()
 add_child(hud)
 menu_back = Panel.new()
 menu_back.position = Vector2(400,175)
 menu_back.size = Vector2(480,485)
 menu_back.mouse_filter = Control.MOUSE_FILTER_IGNORE
 var panel_style = StyleBoxFlat.new()
 panel_style.bg_color = Color(0.07,0.05,0.10,0.94)
 panel_style.border_color = Color("9d7950")
 panel_style.set_border_width_all(2)
 panel_style.set_corner_radius_all(8)
 menu_back.add_theme_stylebox_override("panel",panel_style)
 hud.add_child(menu_back)
 status = Label.new()
 status.position = Vector2(30,22)
 status.add_theme_font_size_override("font_size",22)
 hud.add_child(status)
 pause_button = button("RESUME",Vector2(1120,15),Vector2(130,60))
 pause_button.pressed.connect(func():
  started = true
  set_pause(not paused))
 menu_scroll=ScrollContainer.new()
 menu_scroll.horizontal_scroll_mode=ScrollContainer.SCROLL_MODE_DISABLED
 menu_scroll.follow_focus=true
 hud.add_child(menu_scroll)
 menu = VBoxContainer.new()
 menu.size_flags_horizontal=Control.SIZE_EXPAND_FILL
 menu.mouse_filter=Control.MOUSE_FILTER_PASS
 menu_scroll.add_child(menu)
 var title = Label.new()
 title.text = "ASTRA WHIP\nThe Ashen Threshold · Preview"
 title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
 title.autowrap_mode=TextServer.AUTOWRAP_WORD_SMART
 title.add_theme_font_size_override("font_size",28)
 menu.add_child(title)
 var intro = Label.new()
 intro.text = "A deliberate gothic passage.\nMove · read the tell · commit to the whip.\nA/D or arrows · Space jump · J whip · S crouch"
 intro.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
 intro.autowrap_mode=TextServer.AUTOWRAP_WORD_SMART
 menu.add_child(intro)
 var start = Button.new()
 start.text = "ENTER / RESUME"
 start.custom_minimum_size = Vector2(400,60)
 start.pressed.connect(func():
  started = true
  if complete: restart()
  set_pause(false))
 menu.add_child(start)
 var retry = Button.new()
 retry.text = "RETRY FROM CHECKPOINT"
 retry.custom_minimum_size.y = 48
 retry.pressed.connect(restart)
 menu.add_child(retry)
 var effects = CheckButton.new()
 effects.text = "Reduced effects"
 effects.toggled.connect(func(value): reduced_effects = value)
 menu.add_child(effects)
 for bus_name in ["Music", "SFX"]:
  var bus = AudioServer.bus_count
  AudioServer.add_bus()
  AudioServer.set_bus_name(bus,bus_name)
  var volume_label=Label.new()
  volume_label.text="Music volume" if bus_name=="Music" else "Sound effects volume"
  menu.add_child(volume_label)
  var slider = HSlider.new()
  slider.min_value = 0
  slider.max_value = 1
  slider.step = 0.05
  slider.value = 0.7
  slider.tooltip_text = volume_label.text
  slider.value_changed.connect(func(value): AudioServer.set_bus_volume_db(bus,linear_to_db(maxf(value,0.001))))
  menu.add_child(slider)
 for entry in [["left","LEFT",Vector2(24,590)],["right","RIGHT",Vector2(154,590)],["crouch","CROUCH",Vector2(840,590)],["jump","JUMP",Vector2(975,540)],["whip","WHIP",Vector2(1110,590)]]:
  var b = button(entry[1],entry[2],TOUCH_BASE_SIZE)
  b.toggle_mode = true
  b.mouse_filter = Control.MOUSE_FILTER_IGNORE
  touch_buttons[entry[0]] = b
  touch_button_origins[entry[0]]=entry[2]
 # Keep pause/resume usable after the game viewport is downscaled on phones.
 rotate_back=Panel.new()
 rotate_back.mouse_filter=Control.MOUSE_FILTER_IGNORE
 var rotate_style=StyleBoxFlat.new()
 rotate_style.bg_color=Color(.05,.03,.08,.94)
 rotate_back.add_theme_stylebox_override("panel",rotate_style)
 hud.add_child(rotate_back)
 hud.move_child(rotate_back,0)
 rotate_prompt=Label.new()
 rotate_prompt.text="Rotate to landscape\nGame paused"
 rotate_prompt.horizontal_alignment=HORIZONTAL_ALIGNMENT_CENTER
 rotate_prompt.vertical_alignment=VERTICAL_ALIGNMENT_CENTER
 rotate_prompt.autowrap_mode=TextServer.AUTOWRAP_OFF
 rotate_prompt.mouse_filter=Control.MOUSE_FILTER_IGNORE
 hud.add_child(rotate_prompt)
 hud.move_child(pause_button,hud.get_child_count()-1)
 get_viewport().size_changed.connect(update_ui_layout)
 update_ui_layout()
func update_ui_layout() -> void:
 var insets=Vector4.ZERO
 var density=1.0
 if OS.has_feature("web"):
  var raw=JavaScriptBridge.eval("""(function(){var e=document.createElement('div');e.style.cssText='position:fixed;visibility:hidden;pointer-events:none;padding:env(safe-area-inset-top) env(safe-area-inset-right) env(safe-area-inset-bottom) env(safe-area-inset-left)';document.body.appendChild(e);var s=getComputedStyle(e),v=[parseFloat(s.paddingLeft)||0,parseFloat(s.paddingTop)||0,parseFloat(s.paddingRight)||0,parseFloat(s.paddingBottom)||0];e.remove();var c=document.getElementById('canvas'),r=c.getBoundingClientRect();return JSON.stringify({insets:[Math.max(0,v[0]-r.left),Math.max(0,v[1]-r.top),Math.max(0,v[2]-(innerWidth-r.right)),Math.max(0,v[3]-(innerHeight-r.bottom))],density:r.width&&r.height?Math.max(c.width/r.width,c.height/r.height):1});})()""")
  if raw!=null:
   var data=JSON.parse_string(str(raw))
   if data is Dictionary:
    insets=Vector4(data.insets[0],data.insets[1],data.insets[2],data.insets[3])
    density=float(data.density)
 layout_ui_for_insets(insets,density)
func layout_ui_for_insets(insets: Vector4,density: float) -> void:
 ui_backing_ratio=maxf(density,.001)
 var view=get_viewport_rect()
 var inverse=get_viewport().get_final_transform().affine_inverse()
 var first=inverse*(Vector2(insets.x,insets.y)*ui_backing_ratio)
 var last=inverse*(Vector2(get_window().size)-Vector2(insets.z,insets.w)*ui_backing_ratio)
 ui_safe_rect=Rect2(first,last-first).intersection(view)
 update_pause_target()
 update_menu_targets()
 update_touch_targets()
 var scale=ui_units_to_css_pixels()
 status.position=Vector2(maxf(30,ui_safe_rect.position.x+8/scale.x),maxf(22,ui_safe_rect.position.y+8/scale.y))
 rotate_back.size=view.size
 rotate_prompt.add_theme_font_size_override("font_size",maxi(28,ceili(20/maxf(scale.y,.001))))
 rotate_prompt.position=ui_safe_rect.position+Vector2(80,0)
 rotate_prompt.size=Vector2(ui_safe_rect.size.x-160,ui_safe_rect.size.y)
 update_orientation_ui()
func button_label_width(control: Button,font_size: int,text: String) -> float:
 return control.get_theme_font("font").get_string_size(text,HORIZONTAL_ALIGNMENT_LEFT,-1,font_size).x+control.get_theme_stylebox("normal").get_minimum_size().x
func update_touch_targets() -> void:
 var scale=ui_units_to_css_pixels()
 var font_size=ceili(16/scale.y)
 var target_size=Vector2(maxf(TOUCH_BASE_SIZE.x,TOUCH_TARGET_CSS/scale.x),maxf(TOUCH_BASE_SIZE.y,TOUCH_TARGET_CSS/scale.y))
 for control in touch_buttons.values():
  control.add_theme_font_size_override("font_size",font_size)
  target_size.x=maxf(target_size.x,button_label_width(control,font_size,control.text))
 var left_gap=maxf(touch_button_origins.right.x-touch_button_origins.left.x-TOUCH_BASE_SIZE.x,8/scale.x)
 var right_gap=maxf(touch_button_origins.whip.x-touch_button_origins.jump.x-TOUCH_BASE_SIZE.x,8/scale.x)
 var left=maxf(touch_button_origins.left.x,ui_safe_rect.position.x+8/scale.x)
 var right=minf(touch_button_origins.whip.x+TOUCH_BASE_SIZE.x,ui_safe_rect.end.x-8/scale.x)
 var floor_y=clampf(touch_button_origins.whip.y,ui_safe_rect.position.y+8/scale.y,ui_safe_rect.end.y-8/scale.y-target_size.y)
 # Use a shared baseline for all five gameplay controls.
 var jump_y=floor_y
 var positions={"left":Vector2(left,floor_y),"right":Vector2(left+target_size.x+left_gap,floor_y),"whip":Vector2(right-target_size.x,floor_y),"jump":Vector2(right-target_size.x*2-right_gap,jump_y),"crouch":Vector2(right-target_size.x*3-right_gap*2,floor_y)}
 for action in touch_buttons:
  var control=touch_buttons[action]
  control.custom_minimum_size=target_size
  control.set_deferred("size",target_size)
  control.position=positions[action]
func update_menu_targets() -> void:
 var scale=ui_units_to_css_pixels()
 var label_index=0
 for control in menu.get_children():
  if control is Label:
   var target=20 if label_index==0 else 14
   control.add_theme_font_size_override("font_size",ceili(target/scale.y))
   label_index+=1
  elif control is BaseButton or control is Range:
   control.mouse_filter=Control.MOUSE_FILTER_PASS
   control.custom_minimum_size.y=TOUCH_TARGET_CSS/scale.y
   if control is BaseButton: control.add_theme_font_size_override("font_size",ceili(16/scale.y))
 var margin=Vector2(16,16)/scale
 var panel_size=Vector2(minf(480/scale.x,ui_safe_rect.size.x-margin.x*2),minf(485/scale.y,ui_safe_rect.size.y-margin.y*2))
 menu_back.position=ui_safe_rect.position+(ui_safe_rect.size-panel_size)*.5
 menu_back.size=panel_size
 menu_scroll.position=menu_back.position+margin
 # Theme changes invalidate cached minimum widths; size after they settle.
 menu_scroll.set_deferred("size",panel_size-margin*2)
 menu.add_theme_constant_override("separation",ceili(8/scale.y))
 menu_scroll.scroll_deadzone=ceili(8/scale.y)
func ui_units_to_css_pixels() -> Vector2:
 return get_viewport().get_stretch_transform().get_scale().abs()/ui_backing_ratio
func update_pause_target() -> void:
 var scale=ui_units_to_css_pixels()
 var font_size=ceili(16/scale.y)
 pause_button.add_theme_font_size_override("font_size",font_size)
 var size=Vector2(maxf(130,TOUCH_TARGET_CSS/maxf(scale.x,.001)),maxf(60,TOUCH_TARGET_CSS/maxf(scale.y,.001)))
 for text in ["RESUME","PAUSED","PAUSE"]: size.x=maxf(size.x,button_label_width(pause_button,font_size,text))
 pause_button.set_deferred("size",size)
 pause_button.position=Vector2(minf(1250-size.x,ui_safe_rect.end.x-8/scale.x-size.x),maxf(15,ui_safe_rect.position.y+8/scale.y))
func button(text: String, pos: Vector2, size: Vector2) -> Button:
 var b = Button.new()
 b.text = text
 b.position = pos
 b.size = size
 b.focus_mode = Control.FOCUS_NONE
 hud.add_child(b)
 return b
func _input(event: InputEvent) -> void:
 if event is InputEventKey and not event.echo:
  if event.keycode == KEY_ESCAPE and event.pressed:
   set_pause(not paused)
   return
  if paused or complete: return
  var mapping = {KEY_A:"left",KEY_LEFT:"left",KEY_D:"right",KEY_RIGHT:"right",KEY_SPACE:"jump",KEY_J:"whip",KEY_S:"crouch",KEY_DOWN:"crouch"}
  if mapping.has(event.keycode): hero.controls.set_action(mapping[event.keycode],event.pressed,str(event.keycode))
 if event is InputEventScreenTouch:
  if event.canceled:
   hero.controls.clear()
   return
  var source = "touch"+str(event.index)
  if not event.pressed:
   hero.controls.touches.erase(event.index)
   for action in touch_buttons: hero.controls.set_action(action,false,source)
  elif not paused and not complete:
   hero.controls.touches[event.index]=true
   for action in touch_buttons:
    if touch_buttons[action].get_global_rect().has_point(event.position): hero.controls.set_action(action,true,source)
 if event is InputEventScreenDrag and not paused and not complete and hero.controls.touches.has(event.index):
  var source = "touch"+str(event.index)
  for action in touch_buttons:
   hero.controls.set_action(action,touch_buttons[action].get_global_rect().has_point(event.position),source)
func _draw() -> void:
 draw_rect(Rect2(camera_x-1000,-600,2200,1800),Color("171221"))
 var background_x = floorf((camera_x * 0.2 - 640) / 1280) * 1280 - camera_x * 0.2 + camera_x
 for i in range(-1, 3):
  draw_texture_rect(backdrop,Rect2(background_x + i * 1280,0,1280,720),false)
 for surface in surfaces:
  draw_rect(surface.rect, Color("4c5866"))
  if surface.rect.size.x >= 64:
   for x in range(int(surface.rect.position.x),int(surface.rect.end.x),64):
    if absf(x-camera_x) > 760: continue
    for y in range(int(surface.rect.position.y),int(surface.rect.end.y),64):
     var height = minf(64,surface.rect.end.y-y)
     var source_y = 0 if y == int(surface.rect.position.y) else 128
     draw_texture_rect_region(masonry,Rect2(x,y,64,height),Rect2(128,source_y,128,height*2))
  draw_line(surface.rect.position,surface.rect.position+Vector2(surface.rect.size.x,0),Color("77838f"),3)
 var marker_anchor=Vector2(checkpoint_spec.anchor[0],checkpoint_spec.anchor[1])
 var marker_size=Vector2(checkpoint_spec.canvas[0],checkpoint_spec.canvas[1])
 draw_texture_rect(checkpoint_frames[1 if checkpoint else 0],Rect2(Vector2(4128,Rules.GROUND)-marker_anchor*.5,marker_size*.5),false)
 draw_rect(Rect2(6585,Rules.GROUND-160,55,160),Color("e3a34a") if exit_unlocked else Color("3b2d20"))
 if effigy: draw_rect(Rect2(400,Rules.GROUND-90,32,70),Color("9c9077"))
 for shot in projectiles:
  var p: Vector2 = shot.pos
  if projectile_frames.size() == projectile_durations.size():
   draw_set_transform(p,0,Vector2(float(shot.dir),1))
   draw_texture_rect(projectile_frames[projectile_frame_at(float(shot.get("age",0.0)))],Rect2(-projectile_anchor*.5,projectile_canvas*.5),false)
   draw_set_transform(Vector2.ZERO)
  else:
   draw_colored_polygon(PackedVector2Array([p+Vector2(0,-12.5),p+Vector2(12.5,0),p+Vector2(0,12.5),p+Vector2(-12.5,0)]),Color("8cc084"))
 if pit_timer >= 0: draw_rect(Rect2(camera_x-640,-360,1280,1440),Color(0.05,0.03,0.08,minf(1,pit_timer/0.8)))
