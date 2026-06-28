extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

export (PackedScene) var spike

func _frame_4():
	var dist = (float(data.x) / 100) * 250
	host.spawn_object(spike, int(dist), 0, false, null, true)
