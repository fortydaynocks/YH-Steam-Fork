extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _frame_2():
	host.apply_force_relative("-15", "0")
	host._create_speed_after_image(Color.white, 0.2)

func _frame_3():
	if host.reverse_state == true:
		host._create_speed_after_image(Color.white, 0.5)
		
		host.move_directly_relative("-36", "0")
		host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Hit3.tscn"), Vector2(0, -18))
	
func _frame_10():
	host.reset_momentum()
	host.apply_force_relative("16", "0")
	
	if self.hit_fighter == false:
		host.move_directly_relative("24", "0")
		
	
func _frame_11():
	if self.hit_fighter == false:
		host.move_directly_relative("24", "0")
	
func _tick():
	._tick()
	
	if current_tick < 10:
		host.apply_force_relative("1", "0")
		
		var y_diff = host.opponent.get_pos().y - host.get_pos().y
		host.move_directly_relative("0", str(clamp(y_diff, -2.5, 5)))
		
	host._create_speed_after_image(Color.white, 0.05)
