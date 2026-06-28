extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func is_usable():
	return .is_usable() and host.has_item("Countermeasures") and host.has_item("Money Shot")

func _frame_1():
	if host.has_item("Countermeasures"): host.use_item("Countermeasures")
	if host.has_item("Money Shot"): host.use_item("Money Shot")

func _frame_2():
	if host.initiative_effect == true:
		host.start_throw_invulnerability()

func _frame_5():
	host.reset_momentum()
	
	if data == true:
		host.apply_force_relative("12", "-4")
	else:
		host.apply_force_relative("4", "-12")
		
func _frame_18():
	host.apply_force_relative("3", "-6")

func _tick():
	._tick()
	
	if current_tick in [12, 13, 14, 15, 16, 17, 18, 19] and self.hit_fighter == false:
		host.global_hitlag(1)
