extends "res://_NokColossus/characters/colossus/states/ColossusState.gd"

export (PackedScene) var wave


func _frame_12():
	host.spawn_object(wave, 36, 0, true, null, true)
