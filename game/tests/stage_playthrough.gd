extends SceneTree
# Deterministic input policy through the production stage. No teleports,
# invulnerability, enemy HP edits, direct damage calls or disabled encounters.
const DT=1.0/120.0
var world
var events=[]
var last_health=5
var last_checkpoint=false
var last_unlocked=false
func _initialize():call_deferred("run")
func run():
 world=load("res://main.tscn").instantiate()
 world.testing=true
 root.add_child(world)
 await physics_frame
 for tick in 24000:
  var h=world.hero
  var right=true
  var left=false
  var jump=false
  var whip=false
  if world.effigy and h.position.x>280 and h.position.x<430:
   right=false
   whip=true
  # Read the authored terrain ahead; clear solid upward steps with base jumps.
  if h.is_on_floor():
   for surface in world.surfaces:
    var edge=surface.rect.position.x-h.position.x
    if surface.kind=="solid" and edge>0 and edge<85 and surface.rect.position.y<h.position.y-10:
     jump=true
   if h.position.x>2140 and h.position.x<2176:jump=true
  for foe in world.foes:
   if foe.hp<=0:continue
   var dx=foe.position.x-h.position.x
   if foe.kind=="boss" and world.arena_active:
    # Maintain base-whip spacing, and jump the late locked ground warning.
    right=dx>185
    left=dx<150
    if foe.state=="hazard_windup" and foe.elapsed>.96 and h.is_on_floor():jump=true
    whip=absf(dx)<215 and not (foe.state=="hazard_windup" and foe.elapsed>.5)
   elif absf(dx)<205 and absf(foe.position.y-h.position.y)<110:
    right=dx>160
    left=dx<0
    whip=true
   if foe.kind=="pursuer" and h.position.x>2080 and h.position.x<2176 and dx>0 and dx<400:
    jump=false
    right=dx>180
    whip=true
  # Fresh presses, not hold-to-repeat; one frame released between attacks.
  h.controls.set_action("right",right)
  h.controls.set_action("left",left)
  h.controls.set_action("jump",jump and tick%4==0)
  h.controls.set_action("whip",whip and tick%64==0)
  await physics_frame
  world.step(DT)
  if tick%120==0 or h.health!=last_health or world.checkpoint!=last_checkpoint or world.exit_unlocked!=last_unlocked:
   events.append({"seconds":snappedf(tick*DT,.001),"x":h.position.x,"y":h.position.y,"state":h.state,"hp":h.health,"checkpoint":world.checkpoint,"exit_unlocked":world.exit_unlocked})
  last_health=h.health
  last_checkpoint=world.checkpoint
  last_unlocked=world.exit_unlocked
  if h.health<=0 or world.pit_timer>=0:
   finish(false,"policy died or fell; inspect trace")
   return
  if world.complete:
   finish(world.checkpoint and world.exit_unlocked and not world.effigy,"completed production stage")
   return
 finish(false,"policy timed out")
func finish(ok:bool,message:String):
 var encounters=[]
 for foe in world.foes:encounters.append({"kind":foe.kind,"hp":foe.hp,"state":foe.state,"history":foe.history.keys()})
 var h=world.hero
 events.append({"final":true,"x":h.position.x,"y":h.position.y,"hp":h.health,"checkpoint":world.checkpoint,"exit_unlocked":world.exit_unlocked,"complete":world.complete,"effigy_remaining":world.effigy})
 var path="user://stage-playthrough.json"
 if OS.get_cmdline_user_args().size()>0:path=OS.get_cmdline_user_args()[0]
 FileAccess.open(path,FileAccess.WRITE).store_string(JSON.stringify({"passed":ok,"method":"automated production input policy; not unfamiliar-player or touch acceptance","physical_device":false,"message":message,"encounters":encounters,"events":events}," "))
 print("RESULT stage playthrough: ","PASS " if ok else "FAIL ",message,"; trace=",path)
 quit(0 if ok else 1)
