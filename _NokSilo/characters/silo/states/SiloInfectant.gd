extends "res://_NokSilo/characters/silo/states/SiloState.gd"

var speed = 9

func _frame_8():
	var obj = host.spawn_object(host.objs_table.Infectant, 18 * host.get_facing_int(), -18, false, null, true)
	obj.set_grounded(false)
	
	var dir = xy_to_dir(data.x, data.y, str(speed))
	obj.apply_force(dir.x, dir.y)
