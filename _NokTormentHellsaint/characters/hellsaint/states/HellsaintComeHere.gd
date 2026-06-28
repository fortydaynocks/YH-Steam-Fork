extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _frame_1():
	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Ghost2")

func _frame_4():
	if host.initiative:
		host.start_invulnerability()
		
func _frame_8():
	host.end_invulnerability()

func _frame_6():
	host.move_directly_relative("40", "0")
	host.apply_force_relative("6", "0")
