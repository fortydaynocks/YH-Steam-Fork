extends ObjectState

func _tick():
	._tick()
	
	if host.is_grounded() == true:
		host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-MassBreaker.tscn"), Vector2(0, 0))
		host.rumble(4, 16)
		host.screen_bump(Vector2(0, 0), 4, 0.25)
		
		host.change_state("Slam")
		
		return
		
	host.apply_force_relative("0", "0.5")
	
	if current_tick % 4 == 0:
		host.play_sound("Spin")
