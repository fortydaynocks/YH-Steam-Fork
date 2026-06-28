extends ObjectState

func _tick():
	._tick()
	
	if current_tick >= 10:
		host.disable()
