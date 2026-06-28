extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _frame_0():
	host.apply_force_relative("-2", "0")
	
	if host.is_grounded() == false:
		host.apply_force_relative("0", "-3")

func _frame_6():
	host.reset_momentum()
	host.apply_force_relative("8", "0")
	
	host.spawn_particle_effect_relative(host.vfx_table.Wind2, Vector2(40, 0), Vector2(host.get_facing_int(), 0))
	host.spawn_particle_effect_relative(host.vfx_table.Wind2, Vector2(80, 0), Vector2(host.get_facing_int(), 0))
	host.spawn_particle_effect_relative(host.vfx_table.Wind2, Vector2(120, 0), Vector2(host.get_facing_int(), 0))
	host._create_speed_after_image(Color(0.8, 0.18, 0.48), 0.2)

func _tick():
	._tick()
	
	if current_tick in [7, 8]:
		host.move_directly_relative("50", "0")
