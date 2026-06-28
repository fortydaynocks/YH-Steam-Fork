extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _frame_1():
	if data == true:
		host.apply_force_relative("2", "0")
	else:
		host.apply_force_relative("2", "-8")
	
func _frame_8():
	host.set_grounded(false)
	host.apply_force_relative("0", "8")
	
func _tick():
	._tick()
	
	if current_tick >= 6 and current_tick < 14  and host.is_grounded() == false:
		host.apply_force_relative("0", "4")
		
		var x_diff = host.opponent.get_pos().x - host.get_pos().x
		host.move_directly(str(clamp(x_diff, -4, 4)), "0")
			
	if current_tick >= 8 and current_tick < 14 and host.is_grounded() == true:
		current_tick = 14

			
	if current_tick >= 13 and host.is_grounded() == false:
		current_tick -= 1
		
	host._create_speed_after_image(Color.white, 0.05)
