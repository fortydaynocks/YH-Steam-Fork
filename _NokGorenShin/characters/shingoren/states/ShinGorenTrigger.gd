extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _frame_0():
	host.apply_force_relative("-2", "0")
	
	if host.is_grounded() == false:
		host.apply_force_relative("0", "-3")
	
func _frame_6():
	host.apply_force_relative("4", "0")

func _frame_9():
	if data.get("x") == null:
		data["x"] = str(-300 * host.get_facing_int())
	
	var dist = ((float(data.x) / 100) * 25)
	
	host.move_directly_relative("120", "0")
	host.move_directly(str(dist), "0")
	
	host.reset_momentum()
	host.apply_force_relative("-4", "0")
	
	host.spawn_particle_effect_relative(host.vfx_table.Wind2, Vector2(40, 0), Vector2(host.get_facing_int(), 0))
	host.spawn_particle_effect_relative(host.vfx_table.Wind2, Vector2(80, 0), Vector2(host.get_facing_int(), 0))
	host.spawn_particle_effect_relative(host.vfx_table.Wind2, Vector2(120, 0), Vector2(host.get_facing_int(), 0))
	
func _frame_10():
	host._create_speed_after_image(Color(0.8, 0.18, 0.48), 0.2)
