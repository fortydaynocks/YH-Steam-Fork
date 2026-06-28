extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _frame_4():
	host.spawn_particle_effect_relative(host.vfx_table.Wind1, Vector2(0, 0), Vector2(host.get_facing_int(), 0))
	
	host.move_directly_relative("100", "0")
	host.set_facing(-host.get_facing_int())
	host.apply_force_relative("-8", "0")
	
func _frame_8():
	host.apply_force_relative("8", "0")
	
func _frame_12():
	host.spawn_particle_effect_relative(host.vfx_table.Wind1, Vector2(0, 0), Vector2(host.get_facing_int(), 0))
	
	host.move_directly_relative("100", "0")
	host.set_facing(-host.get_facing_int())
	host.apply_force_relative("-8", "0")
	
func _frame_18():
	host.apply_force_relative("8", "0")

