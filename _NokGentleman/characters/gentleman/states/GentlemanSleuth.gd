extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

export (bool) var aerial = false
var speed = 12
var elevation = 10

func _frame_1():
	host.set_vel("0", str(host.get_vel().y))
	host.apply_force_relative("-12", "0")

func _frame_4():
	host.reset_momentum()
	host.apply_force_relative("10", "0")
	
	if host.is_grounded() == true:
		host.spawn_particle_effect_relative(host.vfx_table.DashFloor, Vector2(0, 0), Vector2(host.get_facing_int(), 0))

func _tick():
	._tick()
	
	if current_tick in [1, 2, 3, 4]:
		host.global_hitlag(1)
	
	if current_tick in [4, 5, 6, 7, 8, 9, 10]:
		host.move_directly_relative(str(speed), "0")
		host.apply_force_relative("1", "0")
		
		if aerial == true and data:
			host.move_directly_relative("0", str(float(data.y) * elevation))
			
		if current_tick % 2 == 0:
			host.afterimage(host.colors_table.MainColor, 0.1)
			host.spawn_particle_effect_relative(host.vfx_table.Dash, Vector2(0, -18), Vector2(host.get_facing_int(), 0))
			
