extends "res://_NokSnowdancer/characters/snowdancer/states/SnowdancerState.gd"

var dist = 100

func is_usable():
	var found_vortices = 0
	
	for vortex in host.objs_map.values():
		if is_instance_valid(vortex):
			if vortex.creator == host and vortex.disabled != true and vortex.get("is_snowdancer_proj") == true:
				if vortex.get("identity") == "ColdVortex":
					found_vortices += 1
	
	return .is_usable() and host.snowflakes.value >= 2 and found_vortices < 1
	
func _frame_1():
	host.increment_snowflakes(-1)

func _frame_5():
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	var midpoint = Vector2((opos.x + pos.x) / 2, (opos.y + pos.y) / 2)
	
	var dir = xy_to_dir(data.x, data.y, str(dist))
	
	var obj = host.spawn_object(host.objs_table.ColdVortex, midpoint.x, midpoint.y, false, null, false)
	obj.set_grounded(false)
	obj.move_directly(dir.x, dir.y)
