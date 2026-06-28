extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

onready var h = $Hitbox
onready var h2 = $Hitbox2
onready var h3 = $Hitbox3

var master_distance_mod = 0
var base_damage = {
	neutral = 190,
	combo = 80,
}
var delayed = false

func _enter():
	._enter()
	delayed = false
	for h in all_hitbox_nodes:
		h.damage = base_damage.neutral
		h.damage_in_combo = base_damage.combo

func _frame_1():
	if _previous_state_name() == "duck":
		master_distance_mod = 25
	elif _previous_state_name() == "cover":
		if delayed == false:
			host.hitlag_ticks += 1
			delayed = true
		master_distance_mod = 50
	elif _previous_state_name() == "exduck":
		master_distance_mod = 50
	else:
		master_distance_mod = 25
	
func on_got_blocked():
	.on_got_blocked()
	if host.opponent.current_state().name != "ParrySuper" and host.opponent.current_state().get("IS_NEW_PARRY"):
		hitted = true
#		host.opponent.set_vel(host.get_vel().x, host.get_vel().y)

	for h in all_hitbox_nodes:
		h.damage = 0

func _tick():
	._tick()
	if current_tick >= 1 and current_tick <= 8 * ticks_per_frame:
		host.update_facing()
	if current_tick >= 1 and current_tick <= 3:
		var pos_modifier = { # Allows you to modify an offset from the opponent's center in case you wanna do that.
			x = 0,
			y = 0,
		}
		var opp_local = host.obj_local_center(host.opponent) # gets the opponent's hurtbox's center
		var opp_center = {"x":opp_local.x + pos_modifier.x, "y":opp_local.y + pos_modifier.y}
		var nudge_force = "5.0" # Modifies the speed of the homing
		var opp_dir = fixed.normalized_vec_times(str(opp_center.x), str(opp_center.y), nudge_force) # Takes the previous values and applies them as two values.
		host.apply_force(opp_dir.x, "0.0") # Takes opp_dir's values and applies force to the thing using it.

	if abs(host.get_pos().x - host.opponent.get_pos().x) <= 30:
		host.mod_vel("0.1")
	if current_tick >= 3:
		host.mod_vel("0.90")

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)

	if obj is Fighter:
		for h in all_hitbox_nodes:
			h.damage = 0
			h.damage_in_combo = 0

