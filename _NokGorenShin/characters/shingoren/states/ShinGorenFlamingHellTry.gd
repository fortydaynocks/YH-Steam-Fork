extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _enter():
	._enter()
	
	host.play_sound("SF3Super")

func _frame_1():
	var dir = xy_to_dir(data.x, data.y, "5")
	
	host.apply_force(dir.x, dir.y)
