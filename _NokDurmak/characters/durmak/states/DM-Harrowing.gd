extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

func _frame_10():
	host.move_directly_relative("20", "0")

func _tick():
	._tick()
	
	if current_tick < 11:
		host.global_hitlag(1)
