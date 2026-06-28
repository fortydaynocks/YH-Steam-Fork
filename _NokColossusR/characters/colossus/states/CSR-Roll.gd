extends RollDodge

func _tick():
	._tick()
	
	if host.is_grounded() == true:
		if current_tick % 8 == 0 and current_tick <= 16:
			host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2(0, 0))
			
		if current_tick == 17:
			host.play_sound("Landing")
