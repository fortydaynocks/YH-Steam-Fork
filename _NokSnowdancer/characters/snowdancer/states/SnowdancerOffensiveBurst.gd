extends "res://characters/states/OffensiveBurst.gd"

func is_usable():
	return .is_usable() and host.current_state().hit_fighter == true

func _frame_0():
	if host.snowflakes.value < 3:
		host.increment_snowflakes(3, true)
		
	else:
		host.increment_snowflakes(4, true)
