extends ObjectState

func _enter():
	._enter()
	
	host.play_sound("Ambience")

func _tick():
	._tick()
	
	if host.is_grounded() == true:
		host.change_state("Blast")
