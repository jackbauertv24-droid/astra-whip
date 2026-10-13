class_name Controls
extends RefCounted
var held: Dictionary = {}
var edges: Dictionary = {}
var touches: Dictionary = {}
func set_action(action: String, down: bool, source: String = "keyboard") -> void:
 var key = source + ":" + action
 var was = is_held(action)
 if down: held[key] = action
 else: held.erase(key)
 if down and not was: edges[action] = true
func is_held(action: String) -> bool:
 return action in held.values()
func pressed(action: String) -> bool:
 return edges.get(action, false)
func axis() -> float:
 if Rules.mutation("T-08") and is_held("left") and is_held("right"): return 1.0
 return float(is_held("right")) - float(is_held("left"))
func flush_edges() -> void:
 edges.clear()
func clear() -> void:
 held.clear()
 edges.clear()
 touches.clear()
