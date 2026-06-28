extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func is_usable():
	return .is_usable() and host.get_most_threatening_star()

func _frame_4():
	if host.get_most_threatening_star():
		host.get_most_threatening_star().slice()

func _frame_9():
	if host.opponent.current_state() is ParryState or host.combo_count > 0:
		self.enable_interrupt()
