extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var dist = 8

func _frame_5():
	host.set_vel(host.get_vel().x, "0")
	
	host.apply_force_relative("6", "6")

func _tick():
	._tick()
	
	if current_tick in [4, 5, 6, 7, 8, 9]:
		var dir = ((float(data.x) / 100) * dist)
		
		host.move_directly_relative("4", "7.5")
		host.move_directly_relative(str(dir), "0")
		
	else:
		host.apply_grav()
	
	host._create_speed_after_image(Color.white, 0.05)
