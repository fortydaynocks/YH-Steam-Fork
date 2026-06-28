extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

func _tick():
	._tick()
	
	if not current_tick in [15, 16, 17, 18, 19, 20, 21, 22, 23, 24]:
		host.global_hitlag(1)
	
	if host.combo_count > 0:
		if current_tick % 2 == 0:
			host.opponent.hitlag_ticks = 1
