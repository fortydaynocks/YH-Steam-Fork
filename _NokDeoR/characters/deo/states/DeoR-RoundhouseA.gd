extends "res://_NokDeoR/characters/deo/states/DeoR-State.gd"

func _frame_0():
	if data:
		host.apply_force("2", "4")
	
	else:
		host.apply_force("2", "-4")
