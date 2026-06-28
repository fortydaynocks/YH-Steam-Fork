extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

func _frame_1():
	if data == true:
		host.apply_force_relative("0", "-8")

func _frame_9():
	host.reset_momentum()

func _tick():
	._tick()
	
	if current_tick in [9, 10, 11, 12, 13, 14, 15, 16]:
		host.move_directly_relative("20", "20")
		host.apply_force_relative("4", "4")
		
	host.afterimage(host.style_extra_color_1 if host.style_extra_color_1 else host.extra_color_1, 0.1)
