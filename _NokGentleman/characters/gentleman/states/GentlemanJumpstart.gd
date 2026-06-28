extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func _frame_4():
	if "Aerial" in editor_description and data == true:
		host.apply_force_relative("4", "4")
	else:
		host.apply_force_relative("4", "-4")
	
func _tick():
	._tick()
	
	if current_tick in [4, 5]:
		if "Aerial" in editor_description and data == true:
			host.move_directly_relative("10", "5")
		else:
			host.move_directly_relative("10", "-5")
			
