extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

func _frame_0():
	if data == true:
		host.apply_force_relative("4", "-4")
		
	else:
		host.apply_force("0", "8")
