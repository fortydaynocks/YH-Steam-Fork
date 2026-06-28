extends "res://_NokColossus/characters/colossus/states/ColossusState.gd"

func _frame_1():
	host.do_asta_text(host.asta_emotes.MassBreaker, 0.2, 1)

func _tick():
	._tick()
	
	if host.is_grounded() == false:
		if current_tick < 16:
			host.apply_force_relative("0", "1")
			
		if current_tick == 13:
			current_tick = 12
