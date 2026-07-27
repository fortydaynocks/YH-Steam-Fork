extends "res://_NokVenerator/venerator/states/VN-State.gd"

var speed = 20

func _exit():
	._exit()
	
	if host.is_grounded():
		host.apply_force_relative("4", "0")
	else:
		host.apply_force_relative("2", "6")

func _frame_6():
	host.apply_force_relative("0", "-8")

func _tick():
	._tick()
	
	if current_tick >= 6:
		host.reset_momentum()
		host.move_directly_relative(str(speed / 3), str(speed))
	
		var dir = (data.x * speed) / 100
		host.move_directly_relative(str(dir / 3), "0")
		
		host.afterimage(Color("#ff8933"), 0.05)
	
