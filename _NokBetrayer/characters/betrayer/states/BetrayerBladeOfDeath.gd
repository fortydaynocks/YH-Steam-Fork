extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"
	
func _tick():
	._tick()
			
	host.afterimage(host.style_extra_color_1 if host.style_extra_color_1 else host.extra_color_1, 0.1)
