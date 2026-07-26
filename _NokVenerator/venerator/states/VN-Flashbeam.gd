extends "res://_NokVenerator/venerator/states/VN-State.gd"

func _frame_0():
	if data:
		host.apply_force_relative("0", "6")
	else:
		host.apply_force_relative("0", "-3")

func _frame_8():
	host.spawn_particle_effect_relative(
		preload("res://_NokVenerator/venerator/effects/VN-Flashbeam.tscn"),
		Vector2(16, -30),
		Vector2(host.get_facing_int(), 0)
	)
