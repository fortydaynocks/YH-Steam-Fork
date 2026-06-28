extends "res://_NokGentleman/characters/gentleman/states/GentlemanThrowState.gd"

func is_usable():
	return .is_usable() and host.has_item("Pocket Knife")

func _frame_1():
	host.apply_force_relative("-8", "0")
	host.use_item("Pocket Knife")
	
func _frame_10():
	host.move_directly_relative("60", "0")
	host.apply_force_relative("8", "0")
	
func _tick():
	._tick()
	
	if current_tick in [4, 5, 6, 7, 8, 9, 10]:
		host.global_hitlag(1)
