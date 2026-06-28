extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _frame_1():
	host.reset_momentum()
	
	host.apply_force_relative("6", "-4")
