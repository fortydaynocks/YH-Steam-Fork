extends ThrowState

export (PackedScene) var goka

func _frame_14():
	host.reset_momentum()
	host.move_directly(str(float(120) * host.get_facing_int()), "0")
	
	host.apply_force_relative("-4", "0")

func _frame_20():
	host.spawn_object(goka, 48 * host.get_facing_int(), -18, true, null, true).apply_force("3", "-3")
	host.spawn_object(goka, -48 * host.get_facing_int(), -18, true, null, true).apply_force("-3", "-3")
