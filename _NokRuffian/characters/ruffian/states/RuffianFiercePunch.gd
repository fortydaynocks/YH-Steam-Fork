extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

func _tick():
	._tick()
	
	if current_tick in [3, 4, 5, 6, 7, 8, 9]:
		host.move_directly_relative("10", "0")
		
		if current_tick % 2 == 0:
			host.spawn_particle_effect_relative(particle_scene, Vector2(0, -19))
		
	if current_tick == 10:
		host.reset_momentum()
		host.apply_force_relative("6", "0")
