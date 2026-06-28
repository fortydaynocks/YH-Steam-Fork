extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _tick():
	._tick()
	
	if current_tick >= 7 and current_tick <= 14:
		if current_tick % 2 == 0:
			var color = host.style_extra_color_2 if (host.style_extra_color_2 and host.applied_style) else host.extra_color_2
			if host.id == 1:
				color = host.style_extra_color_1 if (host.style_extra_color_1 and host.applied_style) else host.extra_color_1
			color.a = 0.5
			host.create_speed_after_image(color, 0.05)
