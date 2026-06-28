extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

func _frame_1():
	if data == true:
		host.apply_force_relative("0", "6")
