extends "res://_NokJupiter/characters/jupiter/states/JupiterState.gd"

func _frame_2():
	if "Aerial" in self.editor_description:
		if data == true:
			host.apply_force_relative("2", "-8")
		else:
			host.apply_force_relative("6", "-4")
	else:
		if data == true:
			host.apply_force_relative("3", "-7")
		else:
			host.apply_force_relative("7", "-3")
