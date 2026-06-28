extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _enter():
	._enter()
	
	if data == true:
		host.apply_force_relative("2", "6")
	else:
		host.apply_force_relative("4", "0")
