extends "res://_NokDeoR/characters/deo/states/DeoR-State.gd"

var dist = 50

func _frame_10():
	host.reset_momentum()
	
	var dir = (float(data.x) / 100) * dist
	
	host.move_directly_relative("150", "0")
	host.move_directly(str(dir), "0")
	host.apply_force_relative("4", "0")
	
	host.afterimage(Color.white, 0.1)
	
	if host.is_grounded() == true:
		host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(host.get_facing_int(), 0))
