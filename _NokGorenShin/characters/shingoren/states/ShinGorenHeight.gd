extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _enter():
	._enter()

func _frame_3():
	var dir = (float(data.x + 100) / 100) * 8
	
	host.reset_momentum()
	host.apply_force_relative(str(dir), "0")
	
	
func _frame_7():
	var dir = (float(data.x + 100) / 100) * 8
	
	host.reset_momentum()
	host.apply_force_relative(str(dir), "-20")

func _tick():
	._tick()
	
	if current_tick <= 13:
		host._create_speed_after_image(Color(1, 1, 1, 0.25), 0.1)
