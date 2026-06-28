extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _frame_1():
	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Ghost1")

func _frame_2():
	if host.is_grounded() == true:
		host.apply_force_relative("12", "0")
	else:
		host.apply_force_relative("3", "0")
		
