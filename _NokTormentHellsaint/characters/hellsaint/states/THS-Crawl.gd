extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _frame_5():
	if host.buffers.get("targeted_array"):
		var array = host.obj_from_name(host.buffers.get("targeted_array"))
		
		if array:
			array.crawl()
