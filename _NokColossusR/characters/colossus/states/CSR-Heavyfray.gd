extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

var adj_speed = 3

func _frame_4():
	
	if host.is_grounded() == false and data == true:
		host.apply_force_relative("6", "0")
		
	else:
		host.move_directly_relative("15", "-25")
		host.apply_force_relative("0", "-3")

func _frame_10():
	host.reset_momentum()
	
	host.apply_force_relative("12", "8")

func _tick():
	if current_tick < 11:
		host.global_hitlag(1)

	if current_tick in [4, 5, 6, 7, 8, 9, 10]:
		var dist = clamp(host.opponent.get_pos().x - host.get_pos().x, -adj_speed, adj_speed)
		
		host.apply_force(str(dist), "0")
		
	host.afterimage(Color(1, 1, 1, 0.5), 0.1)

func _exit():
	._exit()
