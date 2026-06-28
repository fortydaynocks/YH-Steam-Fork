extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _frame_1():
	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Ghost4")
