extends "res://_NokColossus/characters/colossus/states/ColossusPunch.gd"

func _frame_8():
	host.apply_force_relative("16", "0")

func _tick():
	._tick()
	
	if current_tick % 2 == 0:
		host.afterimage(host.colors.Fire, 0.1)
	
	if current_tick <= 8:
		host.global_hitlag(1)
		
	if current_tick in [8, 9, 10, 11, 12, 13, 14]:
		host.move_directly_relative("22", "0")
		
		if current_tick % 2 == 0:
			host.spawn_particle_effect_relative(particle_scene, Vector2(0, 0))
