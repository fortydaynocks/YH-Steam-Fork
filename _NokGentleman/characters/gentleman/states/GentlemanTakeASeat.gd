extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func is_usable():
	return.is_usable()

func _frame_7():
	var dir = xy_to_dir(data.x, data.y, "12")
	var obj = host.spawn_object(host.objs_table.Chair, 18, -18, true, null, true)
	obj.set_grounded(false)
	
	obj.apply_force(dir.x, dir.y)
