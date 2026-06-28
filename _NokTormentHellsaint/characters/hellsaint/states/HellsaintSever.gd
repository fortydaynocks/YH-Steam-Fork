extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _enter():
	._enter()
	
	land_cancel = false

func _frame_5():
	host.reset_momentum()
	host.apply_force_relative("4", "-8")
	
	var dir = xy_to_dir(data.x, data.y, "3")
	host.apply_force(dir.x, dir.y)
	
	land_cancel = true
