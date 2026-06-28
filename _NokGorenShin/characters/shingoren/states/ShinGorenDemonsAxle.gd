extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _tick():
	._tick()
	
	if current_tick < 13:
		host._create_speed_after_image(Color(0.8, 0.18, 0.48, 0), 0.1)
		host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18), Vector2(0, -1))
		host.global_hitlag(1)

	if current_tick == 13:
		host.global_hitlag(8)
