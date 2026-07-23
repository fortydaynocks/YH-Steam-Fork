extends "res://_NokVenerator/venerator/states/VN-State.gd"

func _enter():
	._enter()
	
	if data:
		host.change_state("flashbeam-flash")

func _frame_8():
	host.spawn_particle_effect_relative(
		preload("res://_NokVenerator/venerator/effects/VN-Flashbeam.tscn"),
		Vector2(16, -30),
		Vector2(host.get_facing_int(), 0)
	)
