extends "res://_NokColossus/characters/colossus/states/ColossusState.gd"

func _tick():
	._tick()
	
	if host.combo_count >= 1:
		if current_tick % 2 == 0:
			host.opponent.hitlag_ticks = 1
