extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

var force = 6
var cleaver = preload("res://_NokDurmak/characters/durmak/projectiles/Cleaver.tscn")

func is_usable():
	var usable = true
	
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and not obj.disabled:
			if obj.get("tag") in ["Cleaver", "LodgedCleaver"]:
				usable = false
	
	return .is_usable() and usable

func _frame_7():
	var fac = host.get_facing_int()
	var dir = xy_to_dir(data.Aim.x, data.Aim.y, str(force))
	
	var proj = host.spawn_object(cleaver, 20, -18, true, null, true)
	proj.set_grounded(false)
	proj.apply_force_relative("15", "0")
	proj.apply_force(dir.x, dir.y)
	proj.lodge = data.Mode
