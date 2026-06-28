extends "res://_NokSnowdancer/characters/snowdancer/states/SnowdancerState.gd"

var speed = 10

func _frame_7():
	var obj = host.spawn_object(host.objs_table.Icicle, 8, -18, false, null, true)
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
	
	var dir = xy_to_dir(data.x, data.y, str(speed))
	
	obj.set_grounded(false)
	obj.apply_force(dir.x, dir.y)
	
