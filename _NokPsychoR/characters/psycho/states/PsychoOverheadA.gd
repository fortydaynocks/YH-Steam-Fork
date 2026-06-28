extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

func _frame_1():
	if data == true:
		host.apply_force_relative("0", "8")
		
func _frame_8():
	if data == false:
		host.apply_force_relative("0", "8")
