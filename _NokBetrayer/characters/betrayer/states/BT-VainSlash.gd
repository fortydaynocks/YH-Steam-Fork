extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

var vain_slash = preload("res://_NokBetrayer/characters/betrayer/projectiles/VainSlash.tscn")
var closest_rift = null
var rift_speed = 6

func is_usable():
	var found_rifts = 0
	
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and obj.get_owner() == host and obj.get("disabled") != true and obj.get("tag") == "OrderRift":
			found_rifts += 1
	
	return .is_usable() and found_rifts > 0
	
func _frame_0():
	closest_rift = null
	
	#	--	RETRIEVING THE CLOSEST RIFT
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and obj.get_owner() == host and obj.get("disabled") != true and obj.get("tag") == "OrderRift":
			
			if closest_rift:
				var closest_rift_obj = host.obj_from_name(closest_rift)
				if int(host.distance_to(obj)) < int(host.distance_to(closest_rift_obj)):
					closest_rift = obj.obj_name
			else:
				closest_rift = obj.obj_name
				
func _frame_6():
	if closest_rift and is_instance_valid(host.obj_from_name(closest_rift)):
		var closest_rift_obj = host.obj_from_name(closest_rift)
		var rpos = closest_rift_obj.get_pos()
		
		var dir = xy_to_dir(data.x, data.y, str(rift_speed * 100))
		var obj = host.spawn_object(vain_slash, rpos.x, rpos.y, true, null, false)
		
		obj.set_grounded(false)
		obj.apply_force(dir.x, dir.y)
		
		obj.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTHit1Weak.tscn"), Vector2(0, 0))
		obj.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTHit1Weak.tscn"), Vector2(0, 0))
		obj.play_sound("Spawn")
		obj.play_sound("Spawn2")
		
		closest_rift_obj.disable()
