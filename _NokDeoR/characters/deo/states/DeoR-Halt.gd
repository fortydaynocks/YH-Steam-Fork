extends "res://_NokDeoR/characters/deo/states/DeoR-State.gd"

func get_appropriate_timezone():
	var zone = null
	
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and (not obj.disabled) and obj.get_owner() == host and obj.get("tag") == "Timezone":
			if (not zone) or int(host.opponent.distance_to(obj)) < zone[1]:
				zone = [obj.obj_name, int(host.opponent.distance_to(obj))]
	
	return zone
	
func get_timezones():
	var zones = []
	
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and (not obj.disabled) and obj.get_owner() == host and obj.get("tag") == "Timezone":
			zones.append(obj)
		
	return zones
#	--		
func is_usable():
	return .is_usable() and len(get_timezones()) > 0

func _frame_6():
	#var zone = get_appropriate_timezone()
	
	#if zone:
		#var obj = host.obj_from_name(zone[0])
		#obj.change_state("Activate")
		
	for zone in get_timezones():
		zone.change_state("Activate")
