extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

export (PackedScene) var rose



func _frame_8():
	var fac = host.get_facing_int()
	
	var obj = host.spawn_object(rose, 16, -48, true, null, true)
	obj.set_grounded(false)
	host.can_followup = true
	obj.set_facing(host.get_facing_int())
	var dir = xy_to_dir(data.x, data.y, "7")
	obj.apply_force(6 * fac, 0)
	obj.apply_force(dir.x, fixed.sub(dir.y, "5"))
