extends "res://_NokSkullmage/characters/skullmage/projectiles/summons/SK-SummonState.gd"

func _frame_10():
	host.apply_force_relative("6", "0")

func _tick():
	._tick()
	
	if current_tick in [10, 11]:
		host.move_directly_relative("50", "0")
