extends "res://_NokVenerator/venerator/states/VN-State.gd"

func _frame_0():
	host.reset_momentum()
	host.apply_force_relative("-2", "-6")
