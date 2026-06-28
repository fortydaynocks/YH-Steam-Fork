extends "res://_NokDeoR/characters/deo/states/DeoR-State.gd"

export (String) var stand_action

func _frame_2():
	host.stand_action(stand_action)
		
