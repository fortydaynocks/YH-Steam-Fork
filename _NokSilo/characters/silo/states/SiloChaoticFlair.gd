extends "res://_NokSilo/characters/silo/states/SiloState.gd"

func _frame_3():
	if data == true:
		if host.is_grounded() == true:
			host.apply_force_relative("0", "-8")
			
		else:
			host.apply_force_relative("0", "8")

func _tick():
	._tick()
	
	if current_tick in [6, 7, 8]:
		host.move_directly_relative("12", "0")
		host.apply_force_relative("4", "0")

		host.afterimage(Color.red, 0.1)
