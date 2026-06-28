extends ObjectState

func _frame_0():
	$"%Wave".stop_emitting()
	
	$"%Info".visible = false
	$"%Info".bbcode_text = ""
	
	host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Star.tscn"), Vector2(0, 0))

func _tick():
	._tick()
	
	if current_tick >= 10:
		host.disable()
