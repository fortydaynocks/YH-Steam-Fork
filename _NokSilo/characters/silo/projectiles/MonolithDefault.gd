extends ObjectState

func _enter():
	._enter()
	
	host.play_sound("Spawn1")
	host.play_sound("Spawn2")
	host.play_sound("Spawn3")
	host.set_facing(host.randi_choice([-1, 1]))
	
func _frame_1():
	host.creator.apply_torture(host)
	
func _tick():
	._tick()
	
	if current_tick >= 70:
		host.disable()
