extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

onready var mortar = preload("res://_NokColossusR/characters/colossus/projectiles/VulcanDropper.tscn")

var initial_dist = 200
var dist = 150

func is_usable():
	var found_objs = 0
	
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and obj.disabled != true and obj.get_owner() == host:
			if obj.get("tag") == "VulcanDropper":
				found_objs += 1
	
	return .is_usable() and found_objs < 2

func _frame_4():
	var dir = (float(data["Distance"].x) / 100) * dist
	var obj = host.spawn_object(mortar, initial_dist + dir, 0, true, data["Timing"].x, true)
	
	#var dir = xy_to_dir(data.x, data.y, str(force))
	
	
