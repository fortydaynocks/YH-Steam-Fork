extends "res://_NokDeoR/characters/deo/states/DeoR-State.gd"

onready var timezone = preload("res://_NokDeoR/characters/deo/projectiles/Timezone.tscn")
var offset = 125
var dist = 75

func is_usable():
	var found = 0
	
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and (not obj.disabled) and obj.get_owner() == host and obj.get("tag") == "Timezone":
			found += 1
			
			if obj.get("stacked") == true:
				return false
			
	return .is_usable() and found < 2

func _frame_5():
	var dir = xy_to_dir(data.x, data.y, str(dist))
	var proj = host.spawn_object(timezone, offset * host.get_facing_int(), -18, false, null, true)
	proj.set_grounded(false)
	proj.move_directly(dir.x, dir.y)
