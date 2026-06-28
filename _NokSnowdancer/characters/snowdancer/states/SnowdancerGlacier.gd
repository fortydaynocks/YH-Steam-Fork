extends "res://_NokSnowdancer/characters/snowdancer/states/SnowdancerState.gd"

var speed = 6

func is_usable():
	return .is_usable() and host.snowflakes.value >= 1
	
func _frame_1():
	host.increment_snowflakes(-1)

func _frame_7():
	var obj = host.spawn_object(host.objs_table.Glacier, 8, -18, false, null, true)
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
	
	var dir = xy_to_dir(data.x, data.y, str(speed))
	
	obj.set_grounded(false)
	obj.apply_force(dir.x, dir.y)
	
