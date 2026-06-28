extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"


func _enter():
	._enter()
	if _previous_state_name() == "jetstream":
		beats_backdash = true
	else:
		beats_backdash = false

func _frame_0():
	if _previous_state_name() == "jetstream":
		host.apply_force_relative(10, 0)
