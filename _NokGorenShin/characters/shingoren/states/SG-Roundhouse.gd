extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

func _frame_0():
	if data:
		host.apply_force_relative("-8", "-4")
		
	else:
		host.apply_force_relative("4", "-4")
	
func _frame_5():
	if data:
		host.apply_force_relative("16", "0")
		
	else:
		host.apply_force_relative("8", "0")

func _frame_11():
	host.set_grounded(false)
