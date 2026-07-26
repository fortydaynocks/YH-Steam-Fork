extends "res://_NokVenerator/venerator/states/VN-State.gd"

func _frame_0():
	if data:
		host.apply_force_relative("0", "6")
	else:
		host.apply_force_relative("0", "-3")
