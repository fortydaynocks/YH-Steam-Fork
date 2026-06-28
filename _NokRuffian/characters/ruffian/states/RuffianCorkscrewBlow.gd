extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

func _tick():
	._tick()
	
	if current_tick == 8:
		host.move_directly_relative("60", "0")
	if current_tick in [9, 10, 11]:
		host.move_directly_relative("10", "0")
	if current_tick == 12:
		host.reset_momentum()
		host.apply_force_relative("12", "0")
