extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

func _frame_1():
	if data == true:
		host.apply_force_relative("6", "6")
		

func _frame_5():
	if data == false:
		host.apply_force_relative("6", "0")

func _tick():
	._tick()
	
	if data == false:
		if current_tick in [2, 3, 4, 5]:
			host.move_directly_relative("10", "0")
	
	host.afterimage(Color("#006aff"), 0.1)
