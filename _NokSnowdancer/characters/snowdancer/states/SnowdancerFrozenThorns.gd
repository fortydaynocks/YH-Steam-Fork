extends "res://_NokSnowdancer/characters/snowdancer/states/SnowdancerState.gd"

func is_usable():
	return .is_usable() and host.snowflakes.value >= 2
	
func _frame_1():
	host.increment_snowflakes(-1)

func _frame_6():
	var area = host.spawn_object(host.objs_table.FrozenArea, 20, -host.get_pos().y, true, null, true)
	area.set_grounded(false)
