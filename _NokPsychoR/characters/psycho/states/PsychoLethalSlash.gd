extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

func _frame_7():
	host.afterimage(Color(1, 0, 0, 0.75), 0.1)
	host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(host.get_facing_int(), 0))
	
	host.reset_momentum()
	host.move_directly_relative("70", "0")
	host.apply_force_relative("10", "0")
	
func _frame_10():
	host.afterimage(Color(1, 0, 0, 0.75), 0.1)
	host.move_directly_relative("50", "0")
