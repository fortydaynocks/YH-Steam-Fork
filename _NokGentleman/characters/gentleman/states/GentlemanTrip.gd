extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func _frame_4():
	host.move_directly_relative("15", "0")
	host.afterimage(host.colors_table.MainColor, 0.05)
