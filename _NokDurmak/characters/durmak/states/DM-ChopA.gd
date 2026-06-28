extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

func _frame_0():
	if data == true:
		host.apply_force_relative("0", "8")
