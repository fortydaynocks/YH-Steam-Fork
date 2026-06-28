extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

var proj = preload("res://_NokBetrayer/characters/betrayer/projectiles/SnakeKnife.tscn")
var push_speed = 6
var push_mod = 4

func is_usable():
	var found_snakes = 0
	
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and obj.get_owner() == host and obj.get("disabled") != true and obj.get("tag") in ["SnakeKnife", "SnakeKnifeSplit"]:
			found_snakes += 1
	
	return .is_usable() and found_snakes < 1

func _frame_7():
	var dir = xy_to_dir(data.x * 0.5, data.y, str(push_mod))
	var obj = host.spawn_object(proj, 20, -18, true, null, true)
	
	obj.set_grounded(false)
	obj.set_facing(host.get_facing_int())
	obj.apply_force_relative(str(push_speed), "0")
	obj.apply_force(dir.x, dir.y)

func _tick():
	._tick()
	
	host.afterimage(Color("#006aff"), 0.1)
