extends "res://characters/states/OffensiveBurst.gd"

func is_usable():
	return .is_usable() and host.current_state().hit_fighter == true
