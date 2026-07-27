extends "res://_NokVenerator/venerator/states/VN-State.gd"

func _frame_0():
	self.apply_custom_x_fric = true
	self.apply_custom_y_fric = true
	
	self.interruptible_on_opponent_turn = host.combo_count > 0

func _frame_14():
	self.apply_custom_x_fric = false
	self.apply_custom_y_fric = false
	
func _frame_15():
	host.gain_blessing()
	host.gain_super_meter_raw(30)
	
	host.play_sound("Angelica2")
	host.play_sound("Angelica3")
	
	host.spawn_particle_effect_relative(
		preload("res://_NokVenerator/venerator/effects/VN-Star3.tscn"),
		Vector2(0, -18)
	)
	
	host.screen_bump(Vector2(0, 0), 2, 0.1)
	host.afterimage(Color("#f0b541"), 0.5)
	
func on_got_hit():
	.on_got_hit()
	
	if host.previous_state() and host.previous_state().state_name == self.state_name:
		if current_tick < 15:
			host.gain_blessing(-1)
			
			host.play_sound("AngelicaCancel")
			host.spawn_particle_effect_relative(
				preload("res://_NokVenerator/venerator/effects/VN-Star2.tscn"),
				Vector2(0, -24)
			)

func _tick():
	._tick()
	
	host.global_hitlag(1)
	
	if current_tick < 15:
		host.apply_force_relative("0", "-0.4")
		
		if current_tick % 4 == 0:
			host.gain_super_meter_raw(10)
			
			host.play_sound("Angelica")
			host.spawn_particle_effect_relative(
				preload("res://_NokVenerator/venerator/effects/VN-Star1.tscn"),
				Vector2(0, -18)
			)
		
	else:
		host.apply_grav()

