extends "res://_NokSnowdancer/characters/snowdancer/states/SnowdancerState.gd"

func _frame_1():
	if data == true:
		host.apply_force_relative("10", "0")
		
	else:
		host.apply_force_relative("2", "0")

func _frame_8():
	host.reset_momentum()
	host.apply_force_relative("3", "-13")
	
	if host.is_grounded() == true:
		host.spawn_particle_effect_relative(particle_scene, Vector2(0, 0))

func _tick():
	._tick()
	
	if current_tick % 2 == 0:
		host.afterimage(Color(0.8, 0.86, 0.99, 0.2), 0.1)
