extends ObjectState

func _tick():
	._tick()
	
	var pos = host.get_pos()
	
	if current_tick < 48:
		if pos.x <= - host.stage_width or pos.x >= host.stage_width:
			current_tick = 48
			
	if current_tick >= 66:
		host.disable()
	
	else:
		if current_tick % 6 == 0:
			host.spawn_particle_effect_relative(particle_scene, Vector2(44, 0))
			host.screen_bump(Vector2(0, 0), 1, 0.25)
	
	
