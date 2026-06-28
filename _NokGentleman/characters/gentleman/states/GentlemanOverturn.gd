extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func _frame_3():
	var dir = (data.x / 100) * 5
	
	host.apply_force_relative("5", "-16")
	host.apply_force(str(dir), "0")
	
func _frame_9():
	host.set_grounded(false)
