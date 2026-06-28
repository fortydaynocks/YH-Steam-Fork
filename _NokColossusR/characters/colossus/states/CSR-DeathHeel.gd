extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

func _frame_0():
	if data == true:
		host.apply_force_relative("5", "3")
		
	else:
		host.apply_force_relative("3", "-5")
