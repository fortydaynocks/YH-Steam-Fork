extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _enter():
	._enter()
	
	land_cancel = false
	
func _frame_1():
	if host.reverse_state == true:
		host.apply_force_relative("-10", "-5")
	else:
		host.apply_force_relative("14", "-5")

func _frame_7():
	host.reset_momentum()
	host.apply_force_relative("10", "8")
	
func _frame_8():
	var dir = xy_to_dir(data.x, data.y * 1.25, "3")
	host.apply_force(dir.x, dir.y)
	
	land_cancel = true
