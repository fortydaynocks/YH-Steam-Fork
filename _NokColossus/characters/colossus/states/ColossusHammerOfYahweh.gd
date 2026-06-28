extends "res://_NokColossus/characters/colossus/states/ColossusState.gd"

func _frame_1():
	land_cancel = false
	
	var dir = xy_to_dir(data.x * 1.5, data.y, "10")
	host.apply_force(dir.x, dir.y)

func _frame_15():
	host.set_grounded(false)
	land_cancel = true
