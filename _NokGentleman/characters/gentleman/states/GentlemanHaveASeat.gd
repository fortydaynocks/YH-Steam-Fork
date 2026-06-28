extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func _frame_8():
	var fac = host.get_facing_int()
	var dir = xy_to_dir(data.x, data.y, "6")
	
	var obj = host.spawn_object(preload("res://_NokGentleman/characters/gentleman/projectiles/GentlemanChair.tscn"), 18, 0, true, null, true)
	obj.set_grounded(false)
	obj.apply_force(str(6 * fac), "-6")
	obj.apply_force(dir.x, dir.y)
	
