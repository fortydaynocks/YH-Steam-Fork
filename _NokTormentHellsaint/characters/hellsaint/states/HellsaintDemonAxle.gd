extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _frame_3():
	var dist = (float(data.x) / 100) * 4
	
	host.apply_force_relative("2", "0")
	host.apply_force_relative(str(dist), "0")
	
func _frame_8():
	host.move_directly_relative("6", "-36")
	host.apply_force_relative("6", "-8")
	
func _tick():
	._tick()
	
	if current_tick in [8, 9, 10, 11]:
		host.afterimage2(Color(1, 0, 0.27), 0.075)
