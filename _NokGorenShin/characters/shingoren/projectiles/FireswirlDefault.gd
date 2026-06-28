extends ObjectState

var life = 75

func _tick():
	._tick()
	
	if current_tick >= life:
		host.disable()
