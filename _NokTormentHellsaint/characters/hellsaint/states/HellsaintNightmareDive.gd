extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

var loop_start = 12
var loop_point = 21
var speed = 6

func _enter():
	._enter()
	
	speed = 6
	
	host.play_sound("dive")

func _frame_2():	
	var dist = (float(data.x) / 100) * 4
	host.apply_force_relative(str(dist), "0")

	host.apply_force("0", "-4")

func _frame_23():
	host.reset_momentum()
	host.apply_force_relative("6", "0")
	
	host.afterimage2(Color(1, 0, 0.27), 0.5)

func _tick():
	._tick()

	if current_tick >= loop_start and current_tick <= loop_point:
		host.reset_momentum()
		
		speed += 1.5
		host.move_directly_relative(str(speed), str(speed))
		host.apply_forces_no_limit()
		
		#	--
		if host.touching_which_wall() == 1:
			host.set_facing(-1)
			host.move_directly("-40", "0")
			
			host.play_sound("Block")
			
		if host.touching_which_wall() == -1:
			host.set_facing(1)
			host.move_directly("40", "0")
			
			host.play_sound("Block")
		
		#	--
		host.afterimage2(Color(1, 0, 0.27), 0.075)
		
		if host.is_grounded() == false:
			if current_tick >= loop_point:
				current_tick = loop_start
		else:
			current_tick = loop_point + 1
