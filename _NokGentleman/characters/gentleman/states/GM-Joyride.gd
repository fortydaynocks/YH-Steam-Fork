extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func _frame_2():
	host.apply_force_relative("4", "0")
	
	if abs(host.opponent.get_pos().x - host.get_pos().x) > 40:
		host.apply_force_relative("8", "0")
		host.apply_forces_no_limit()
