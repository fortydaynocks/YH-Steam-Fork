extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _frame_6():
	host.reset_momentum()
	host.apply_force_relative("16", "-3")
