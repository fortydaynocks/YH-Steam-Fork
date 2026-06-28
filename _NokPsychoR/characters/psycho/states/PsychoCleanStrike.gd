extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

"""
func _frame_5():
	var dist = (float(data.x) / 100) * 20
	
	host.afterimage(Color(1, 0, 0, 0.75), 0.5)
	host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(host.get_facing_int(), 0))
	host.move_directly_relative(str(125 + dist), "0")
	host.apply_force_relative("8", "0")
	
	host.set_vel(host.get_vel().x, "0")
	
func _frame_6():
	host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2(0, 0))

func _frame_10():
	host.apply_force_relative("-16", "0")

func _frame_16():
	host.afterimage(Color(1, 0, 0, 0.75), 0.5)
	host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(-host.get_facing_int(), 0))
	
	host.move_directly_relative("-70", "0")
	host.apply_force_relative("-16", "0")
"""

func _frame_2():
	host.apply_force_relative("-6", "0")

func _tick():
	._tick()
	
	host.afterimage(host.extra_color_1, 0.1)
	
	if current_tick in [2, 3, 4]:
		host.move_directly_relative("-40", "0")
