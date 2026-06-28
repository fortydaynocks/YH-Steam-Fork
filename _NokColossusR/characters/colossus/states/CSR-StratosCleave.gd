extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

func _frame_11():
	host.apply_force_relative("2", "-10")

func on_got_blocked():
	.on_got_blocked()
	
	host.opponent.reset_momentum()
	host.opponent.apply_force_relative("0", "-10")
