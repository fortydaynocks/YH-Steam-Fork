extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

func _frame_1():
	host.apply_force_relative("12", "-6")

func _frame_8():
	host.play_sound("grief-swing")

func _tick():
	._tick()
	
	if current_tick >= 12 and current_tick < 21:
		host.apply_force_relative("0", "0.5")

	if current_tick in [12, 13, 14, 15] and self.hit_fighter:
		host.global_hitlag(1)

	if current_tick in [16, 17, 18]:
		if not host.is_grounded():
			if current_tick == 18:
				current_tick = 16
			
		else:
			current_tick = 18
