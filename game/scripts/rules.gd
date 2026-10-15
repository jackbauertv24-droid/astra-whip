class_name Rules
extends RefCounted
# Single source for gameplay numbers, unchanged from GAMEPLAY_RULES.
const SPEED = 240.0
const GRAVITY = 1600.0
const JUMP = -640.0
const AIR_ACCEL = 600.0
const PURSUER_PATROL_SPEED = 60.0
const PURSUER_APPROACH_SPEED = 100.0
const SWOOPER_RADIUS = 40.0
const COYOTE = 0.1
const BUFFER = 0.1
const WINDUP = 0.15
const ACTIVE_END = 0.25
const ATTACK_END = 0.5
const INVULN = 1.0
const HEALTH = 5
const STAND = Vector2(40, 104)
const CROUCH = Vector2(40, 60)
const KNOCK_SPEED = 160.0
const GROUND = 560.0
const WIDTH = 6656.0
const KILL_Y = GROUND + 256.0
const HERO_STATES = ["idle", "start_move", "walk", "stop_move", "turn", "crouch_enter", "crouch_idle", "crouch_exit", "jump_takeoff", "jump_rise", "jump_apex", "fall", "land", "attack_ground", "attack_air", "attack_crouch", "hurt_recoil", "knockback", "knockdown", "get_up", "death"]
const ENEMY_STATES = {
 "pursuer": ["idle", "patrol_walk", "alert", "approach_walk", "lunge_windup", "lunge", "recovery", "hurt", "death"],
 "swooper": ["perch_idle", "cruise", "dive_telegraph", "dive", "recovery_climb", "hurt", "death_fall"],
 "ranged": ["idle", "aim", "fire", "recover", "hurt", "death"],
 "boss": ["idle", "walk", "turn", "strike_windup", "strike_execute", "strike_recover", "hazard_windup", "hazard_execute", "hazard_recover", "hurt", "death"]
}
static func mutation(id: String) -> bool:
 return OS.get_environment("ASTRA_MUTATION") == id
