extends "res://_NokDeoR/characters/deo/states/DeoR-State.gd"

var dist = 6

func _frame_1():
	var dir = ((float(data.x) / 100) * dist)
	
	if host.is_grounded() == true:
		host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2(0, 0))
	
	if data.x > 0:
		host.apply_force_relative("2", "0")
		host.apply_force_relative(str(dir), str(-dir))
		
	else:
		host.apply_force_relative("-2", "-6")
	
func _frame_9():
	host.set_grounded(false)
		
