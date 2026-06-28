extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

var vain_slash = preload("res://_NokBetrayer/characters/betrayer/projectiles/VainSlash.tscn")
var closest_rift = null
var launch_speed = 10

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
				
func _frame_5():
	if closest_rift and is_instance_valid(host.obj_from_name(closest_rift)):
		var closest_rift_obj = host.obj_from_name(closest_rift)
		var rpos = closest_rift_obj.get_pos()
		var opos = host.opponent.get_pos()

		host.reset_momentum()
		host.set_pos(str(rpos.x), str(rpos.y))
		
		var dir = xy_to_dir(data.x, data.y * 0.75, str(launch_speed * 100))
		host.apply_force_relative("-4", "0")
		host.apply_force(dir.x, dir.y)
		
		host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BT-Teleport.tscn"), Vector2(0, -18))

		closest_rift_obj.disable()
		
func _frame_6():
	host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BT-Teleport.tscn"), Vector2(0, -18))

func _tick():
	._tick()
	
	if current_tick in [7, 8, 9, 10]:
		host.global_hitlag(1)
	
	host.afterimage(Color("#006aff"), 0.1)
