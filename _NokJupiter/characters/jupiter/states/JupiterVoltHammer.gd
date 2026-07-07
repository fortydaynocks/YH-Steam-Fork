extends "res://_NokJupiter/characters/jupiter/states/JupiterState.gd"

func _frame_2():
	if "Grounded" in self.editor_description:
		host.move_directly("0", "-15")
		host.apply_force_relative("8", "-4")
		
		host.afterimage(host.stuff.colors.Charge2, 0.1)

func _frame_4():
	if "Aerial" in self.editor_description and data == true:
		host.apply_force_relative("0", "8")

func _frame_7():
	if "Grounded" in self.editor_description and data == true:
		if host.reverse_state:
			host.set_facing(host.get_facing_int())
		else:
			host.set_facing(-host.get_facing_int())

func _frame_9():
	if "Grounded" in self.editor_description:
		host.set_grounded(false)
		
		host.move_directly("0", "10")
		host.apply_force_relative("8", "8")
		
		host.afterimage(host.stuff.colors.Charge2, 0.1)

func _tick():
	._tick()
	
	if current_tick in [6, 7, 8]:
		host.global_hitlag(1)
