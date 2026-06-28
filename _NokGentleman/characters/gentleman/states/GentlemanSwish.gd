extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func _frame_1():
	if data == true:
		host.apply_force_relative("1", "8")
	else:
		host.apply_force_relative("1", "-4")
