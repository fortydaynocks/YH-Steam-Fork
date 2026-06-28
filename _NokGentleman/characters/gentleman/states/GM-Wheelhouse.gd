extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

var dist = 5

func _frame_6():
	host.reset_momentum()
	
	host.apply_force_relative("2", "-10")
	

func _tick():
	._tick()
	
	if current_tick in [2, 3, 4, 5, 6]:
		var dir = (float(data.x) / 100) * dist
		
		host.move_directly_relative("10", "0")
		host.move_directly_relative(str(dir), "0")
		
		host.afterimage(Color("#a3a7c2"), 0.1)
