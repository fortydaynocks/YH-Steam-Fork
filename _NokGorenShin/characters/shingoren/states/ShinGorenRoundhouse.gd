extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _frame_2():
	
	if host.air_movements_left >= 1:
		var dir = xy_to_dir(data["Direction"].x, data["Direction"].y, "9")
		host.apply_force(dir.x, dir.y)
		
		host.air_movements_left -= 1
