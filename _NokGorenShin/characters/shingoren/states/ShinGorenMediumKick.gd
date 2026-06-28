extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _frame_2():
	var dir = xy_to_dir(data.x, data.y, "4")
	host.apply_force(dir.x, dir.y)
