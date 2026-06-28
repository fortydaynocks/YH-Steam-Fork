extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

func _frame_0():
	if data:
		host.apply_force_relative("-2", "0")
	else:
		host.apply_force_relative("5", "0")
