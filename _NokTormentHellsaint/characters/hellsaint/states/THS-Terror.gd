extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

var force = 6

func _frame_3():
	host.global_hitlag(5)

func _frame_4():
	if host.buffers.get("targeted_array"):
		var array = host.obj_from_name(host.buffers.get("targeted_array"))
		
		if array:
			var dir = xy_to_dir(data.x * 2, data.y, str(force))
			
			var proj = array.star()
			proj.apply_force(dir.x, dir.y)
