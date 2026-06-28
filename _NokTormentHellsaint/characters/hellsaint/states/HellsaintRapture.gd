extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _enter():
	._enter()
	
	apply_custom_x_fric = false

func _frame_1():
	if host.combo_count >= 1:
		current_tick = 10

func _tick():
	._tick()
	
	host.afterimage2(Color(1, 0, 0.27), 0.1)
	
	if current_tick >= 2 and current_tick <= 6:
		if host.reverse_state == true:
			if current_tick == 2:
				host.super_effect(1)
				host.spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Super.tscn"), Vector2(0, -18))
			host.move_directly_relative("-20", "0")
	
	if current_tick == 4:
		host.reset_momentum()
		host.apply_force_relative("-5", "-10")
			
			
	if current_tick > 4 and current_tick < 14:
		host.apply_grav()
		host.apply_grav()
		host.apply_grav()
		host.apply_grav()
		host.apply_grav()
		host.apply_grav()
		
	if current_tick == 11:
		host.set_vel("0", host.get_vel().y)
		host.apply_force_relative("5", "0")
	
	if current_tick == 14:
		host.reset_momentum()
		host.apply_force_relative("32", "-4")
		
		var dir = xy_to_dir(data.x, data.y / 2, "6")
		host.apply_force(dir.x, dir.y)
		
	if current_tick > 14:
		host.apply_grav()
		apply_custom_x_fric = true
