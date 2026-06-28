extends "res://_NokColossus/characters/colossus/states/ColossusState.gd"

func _enter():
	if data == true:
		host.apply_force_relative("-8", "0")
	else:
		host.apply_force_relative("8", "0")
