extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

export (PackedScene) var smoke_effect

func _frame_2():
	var dist = float(data.x) * 5
	
	host.reset_momentum()
	host.apply_force_relative("0", "-8")
	host.apply_force_relative(str(dist), "0")
	
	if host.is_grounded() == true:
		host.spawn_particle_effect_relative(host.vfx_table.Wind1, Vector2(0, 0), Vector2(host.get_facing_int(), 0))
		host.spawn_particle_effect_relative(host.vfx_table.Landing, Vector2(0, 0), Vector2(host.get_facing_int(), 0))
		
func _frame_9():
	host.set_grounded(false)
		
func _tick():
	._tick()
	
	if current_tick >= 9:
		if host.is_grounded() == true:
			
			host.apply_force_relative("4", "0")
			return "downfall2"
			
		else:
			host.reset_momentum()
			host.move_directly_relative("20", "20")
		
		host._create_speed_after_image(Color("cc2f7b"), 0.1)
		
	if current_tick >= 26:
		current_tick = 19
