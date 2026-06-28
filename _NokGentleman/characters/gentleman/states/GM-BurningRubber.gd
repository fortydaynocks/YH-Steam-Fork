extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

var accel = 3

func _frame_11():
	host.reset_momentum()
	host.apply_force_relative("6", "0")
	
	host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(-host.get_facing_int(), 0))
	host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2(30, 0))

func _tick():
	._tick()

	if current_tick < 12:
		if abs(host.opponent.get_pos().x - host.get_pos().x) > 100 and host.reverse_state == false:
			host.apply_force_relative(str(accel), "0")
			
		if current_tick % 2 == 0:
			host.afterimage(Color("#a3a7c2"), 0.1)
			host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(host.get_facing_int(), 0))
