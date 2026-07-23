extends "res://_NokSickness/characters/sickness/states/SC-State.gd"

func _frame_1():
	if "Aerial" in self.editor_description:
		host.reset_momentum()
		
		if data:
			if host.combo_count < 1: host.use_air_movement()
			host.apply_force_relative("8", "-4")
			
		else:
			host.apply_force_relative("4", "8")
			
	else:
		if data:
			host.apply_force_relative("4", "-8")
			
		else:
			host.apply_force_relative("8", "-4")
		
func _frame_10():
	host.set_grounded(false)
