extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"


func _frame_8():
	host.move_directly_relative("80", "0")
	host.apply_force_relative("8", "0")
	
	host.afterimage(Color("#a3a7c2"), 0.1)
	
func _frame_9():
	host.move_directly_relative("40", "0")
