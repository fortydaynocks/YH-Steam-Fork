extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"


func _enter():
	._enter()
	for h in all_hitbox_nodes:
		h.damage = 125
	if _previous_state_name() in ["jetstream", "chargestepdash"]:
		beats_backdash = true
	else:
		beats_backdash = false


func _tick():
	._tick()
	if name == "corkscrewblow":
		for h in all_hitbox_nodes:
			if h.group == 2:
				if host.opponent.is_grounded():
					h.plus_frames = 0
				else:
					h.plus_frames = -2
	if current_tick >= 1 and current_tick <= 9:
		var opp_local = host.obj_local_center(host.opponent)
		var above_opp = {"x":opp_local.x, "y":opp_local.y}
		var nudge_force = "10.0"
		var opp_dir = fixed.normalized_vec_times(str(above_opp.x), str(above_opp.y), nudge_force)
		if _previous_state_name() == "jetstream":
			nudge_force = "15.0"
		else:
			nudge_force = "9.0"
		if hitted == false:
			host.move_directly(opp_dir.x, opp_dir.y)
		else:
			host.move_directly(opp_dir.x, "0")

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj is Fighter:
		for h in all_hitbox_nodes:
			h.damage = 0

func on_got_blocked():
	.on_got_blocked()
#	hitted = true
	host.start_projectile_invulnerability()
	for h in all_hitbox_nodes:
		h.damage = 0
