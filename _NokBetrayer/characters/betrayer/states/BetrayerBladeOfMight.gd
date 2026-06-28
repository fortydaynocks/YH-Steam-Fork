extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

func _tick():
	._tick()
	
	if current_tick in [5, 6, 7, 8, 13, 14, 15, 16] and host.is_grounded() == true:
		host.global_hitlag(2)

	host.afterimage(host.style_extra_color_1 if host.style_extra_color_1 else host.extra_color_1, 0.1)

	if current_tick == 8:
		if host.is_grounded() == false:
			current_tick -= 1
			host.apply_force_relative("1", "3")
