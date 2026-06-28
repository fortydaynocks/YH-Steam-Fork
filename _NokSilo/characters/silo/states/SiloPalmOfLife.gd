extends "res://_NokSilo/characters/silo/states/SiloState.gd"

func _frame_2():
	if data == true:
		host.apply_force_relative("0", "8")

func _frame_4():
	host.apply_force_relative("4", "0")

func _frame_9():
	host.reset_momentum()
	host.apply_force_relative("10", "0")
	
func _frame_20():
	host.reset_momentum()
	host.apply_force_relative("6", "0")
	
func _tick():
	._tick()
	
	if current_tick in [9, 10, 11, 12, 13, 14, 15, 16]:
		host.move_directly_relative("10", "0")
