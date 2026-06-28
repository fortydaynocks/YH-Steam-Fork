extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func _frame_8():
	host.afterimage(host.colors_table.MainColor, 0.2)

func _tick():
	._tick()
	
	if current_tick in [8, 9, 10]:
		host.move_directly_relative("25", "0")
