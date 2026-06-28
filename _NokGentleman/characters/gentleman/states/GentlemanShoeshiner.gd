extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func _frame_0():
	host.afterimage(host.colors_table.MainColor, 0.5)
	host.global_hitlag(4)

func _tick():
	._tick()
	
	host.afterimage(host.colors_table.MainColor, 0.1)
