extends "res://_NokDurmak/characters/durmak/summons/WalkerState.gd"
		
func _frame_2():
	if host.is_grounded():
		host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2())
	host.play_sound("Jump")

	host.apply_force_relative("4", "-12")
	
func _frame_7():
	var pos = host.get_pos()
	var opos = host.get_opponent().get_pos()
	host.set_facing(1 if opos.x > pos.x else -1)
	
	host.reset_momentum()
	host.apply_force_relative("4", "12")
	
func _tick():
	._tick()
	
	if current_tick >= 7 and host.is_grounded():
		host.timeout = 0
		return self.fallback_state
