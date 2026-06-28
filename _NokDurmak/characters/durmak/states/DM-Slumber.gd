extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

var slumber = preload("res://_NokDurmak/characters/durmak/projectiles/Slumber.tscn")
var dist = 200

func is_usable():
	for obj in host.objs_map.values():
			if is_instance_valid(obj) and (not obj.disabled) and obj.creator == host and obj.get("tag") == "Slumber":
				return false

	return .is_usable()

func _frame_5():
	var dir = xy_to_dir(data.x, data.y, str(dist))
	
	var proj = host.spawn_object(slumber, int(dir.x), int(dir.y) - 18, false, null, true)
	proj.set_grounded(false)
