extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func _frame_4():
	host.apply_force_relative("8", "0")
	host.apply_forces_no_limit()

func _tick():
	._tick()

	if current_tick in [5, 6, 7]:
		host.move_directly_relative("15", "0")

	if current_tick in [5, 6, 7, 8, 9, 10]:
		host.afterimage(Color("#a3a7c2"), 0.1)
		
		if current_tick in [5, 7, 9]:
			host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(-host.get_facing_int(), 0))
