extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

var go_up = false

func _enter():
	._enter()
	go_up = false

func _frame_0():
#	._frame_0()
	if data:
		if data["Direction"].y == -1:
			if host.air_movements_left > 0:
				host.use_air_movement()
				go_up = true

func _tick():
	._tick()
	
	if current_tick in range (3, 9):
		host.set_vel(fixed.mul("6", str(host.get_facing_int())), fixed.mul(str(data["Direction"].y), "2"))
		if go_up == true:
			
			host.move_directly_relative(data["Distance"].x/10 + 10, ((data["Distance"].x/12) * data["Direction"].y))
		else:
			host.move_directly_relative(data["Distance"].x/10 + 10, ((data["Distance"].x/12) * abs(data["Direction"].y)))

#		if host.air_movements_left > 0:
#			if data["Direction"].y <= 0:
#				host.move_directly_relative(data["Distance"].x/10 + 10, ((data["Distance"].x/10) * data["Direction"].y))
#			else:
#				host.move_directly_relative(data["Distance"].x/10 + 10, ((data["Distance"].x/10) * data["Direction"].y) + 5)
#		else:
#			host.move_directly_relative(data["Distance"].x/10 + 10, abs((data["Distance"].x/10) * data["Direction"].y))
#		if current_tick % 2 == 0:
#			host.spawn_particle_effect_relative(particle_scene, Vector2(0, -19))

	if current_tick == 10:
		host.reset_momentum()
		host.apply_force_relative("6", "0")

func is_usable():
	return .is_usable() and host.air_movements_left > 0
