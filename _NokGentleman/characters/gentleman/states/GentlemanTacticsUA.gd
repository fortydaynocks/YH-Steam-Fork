extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func _frame_1():
	var dist = (float(data.x) / 100)
	
	host.apply_force(str(7 * dist), str((-3) * dist))
