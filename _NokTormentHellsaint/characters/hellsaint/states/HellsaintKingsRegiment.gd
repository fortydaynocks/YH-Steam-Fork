extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

export (PackedScene) var slash

func _frame_4():
	host.play_sound("void05")
	
	var obj = host.spawn_object(slash, 0, 0, true, null, true)
