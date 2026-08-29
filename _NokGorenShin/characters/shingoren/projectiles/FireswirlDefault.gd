extends ObjectState

var life = 120

func _tick():
	._tick()
	
	if current_tick >= life:
		host.disable()
