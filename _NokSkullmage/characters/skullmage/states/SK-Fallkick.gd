extends "res://_NokSkullmage/characters/skullmage/states/SK-State.gd"

func _frame_2():
	host.move_directly_relative("0", "-20")
	host.apply_force_relative("4", "-4")
	
func _frame_9():
	host.reset_momentum()
	host.apply_force_relative("4", "20")
	
	host.set_grounded(false)
