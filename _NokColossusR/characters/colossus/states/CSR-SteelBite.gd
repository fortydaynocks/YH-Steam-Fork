extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

var max_dist = 20

func _frame_8():
	host.apply_force_relative("6", "0")

func _tick():
	._tick()
	
	if current_tick in [6, 7, 8]:
		if abs(host.opponent.get_pos().x - host.get_pos().x) > 20 and host.reverse_state == false:
			host.move_directly_relative(str(max_dist), "0")
			
		if host.is_grounded() == true:
			host.spawn_particle_effect_relative(preload("res://fx/DashParticle.tscn"), Vector2(), Vector2(host.get_facing_int(), 0))
