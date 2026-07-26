extends "res://_NokVenerator/venerator/states/VN-State.gd"

func _frame_5():
	if "Aerial" in self.editor_description:
		host.reset_momentum()
		host.apply_force_relative("2.5", "-10")
