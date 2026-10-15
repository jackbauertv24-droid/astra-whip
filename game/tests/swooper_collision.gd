extends SceneTree
var checks = 0
var failures = 0
func _initialize() -> void:
 call_deferred("run")
func check(condition: bool,label: String) -> void:
 checks += 1
 if not condition:
  failures += 1
  printerr("FAIL ",label)
func run() -> void:
 var world = load("res://main.tscn").instantiate()
 world.testing = true
 root.add_child(world)
 world.simulate_enemies = false
 var h = world.hero
 var foe
 for actor in world.foes:
  if actor.kind == "swooper":
   foe = actor
   break
 foe.bounds = Vector2(1000,2400)
 foe.floor_y = Rules.GROUND
 for crouch in [false,true]:
  for direction in [1,-1]:
   h.reset_at(Vector2(1800,Rules.GROUND))
   h.crouched = crouch
   var body: Rect2 = h.body_rect()
   var contacts = [
    {"point":Vector2(body.get_center().x,body.position.y-39),"hit":true,"name":"top cap"},
    {"point":Vector2(body.get_center().x,body.end.y+39),"hit":true,"name":"bottom cap"},
    {"point":Vector2(body.end.x+39,body.get_center().y),"hit":true,"name":"side cap"},
    {"point":body.end+Vector2(39,39),"hit":false,"name":"square corner miss"},
    {"point":Vector2(body.end.x+41,body.get_center().y),"hit":false,"name":"outside radius"}
   ]
   for sample in contacts:
    h.reset_at(Vector2(1800,Rules.GROUND))
    h.crouched = crouch
    h.facing = direction
    foe.hp = 1
    foe.position = sample.point
    foe.enter("perch_idle")
    foe.simulate(0)
    check((h.health==Rules.HEALTH-1)==sample.hit,"contact "+sample.name+" crouch="+str(crouch)+" facing="+str(direction))
   h.reset_at(Vector2(1800,Rules.GROUND))
   h.crouched = crouch
   h.facing = direction
   h.attack_time = .2
   var whip: Rect2 = h.whip_rect()
   var outer_x = whip.end.x if direction>0 else whip.position.x
   foe.hp = 2 # Test-only nonlethal target keeps one attack alive for dedup proof.
   foe.position = Vector2(outer_x+direction*39,whip.position.y-39)
   foe.enter("perch_idle")
   foe.simulate(0)
   check(foe.hp==2 and not h.hit_ids.has(foe.get_instance_id()),"whip square corner misses without consuming target crouch="+str(crouch)+" facing="+str(direction))
   foe.position = Vector2(outer_x+direction*39,whip.get_center().y)
   foe.simulate(0)
   check(foe.hp==1 and h.hit_ids.has(foe.get_instance_id()),"later true circle intersection hits same attack crouch="+str(crouch)+" facing="+str(direction))
   foe.simulate(0)
   check(foe.hp==1,"true circle hit remains once per attack crouch="+str(crouch)+" facing="+str(direction))
 print("SWOOPER COLLISION: ",checks," checks, ",failures," failures")
 quit(0 if failures==0 else 1)
