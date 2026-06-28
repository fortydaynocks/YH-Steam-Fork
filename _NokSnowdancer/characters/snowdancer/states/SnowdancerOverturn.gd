extends "res://_NokSnowdancer/characters/snowdancer/states/SnowdancerState.gd"

func _frame_1():
	if "AerialOverturn" in self.editor_description:
		if data == true:
			host.apply_force_relative("4", "6")
			
		else:
			host.apply_force_relative("4", "-2")
	else:
		if data == true:
			host.apply_force_relative("6", "-6")
			
		else:
			host.apply_force_relative("6", "-2")
