extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

func _frame_1():
	host.reset_momentum()
	host.apply_force_relative("-20", "0")
	
	var fac = host.get_facing_int()
	host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(), Vector2(-fac, 0))
	
func _tick():
	._tick()
	
	if current_tick <= 13:
		host.apply_force_relative("1", "0")
		
	if current_tick in [12, 13]:
		host.move_directly_relative("70", "0")
		host.apply_force_relative("4", "0")
