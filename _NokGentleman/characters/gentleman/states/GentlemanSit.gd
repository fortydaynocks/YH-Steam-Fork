extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func is_usable():
	var check = false
	
	for obj in host.objs_map.values():
		if obj.get("is_gentleman_chair") and obj.disabled != true:
			if obj.get_owner() == host:
				if float(host.distance_to(obj)) < 75:
					host.found_chair = obj
					check = true
					
					return .is_usable() and true
				
	return .is_usable() and false

func _frame_5():
	var chair = null
	var check = false
	
	for obj in host.objs_map.values():
		if is_instance_valid(obj):
			if obj.get("is_gentleman_chair") and check == false:
				if obj.get_owner() == host and obj.disabled != true:
					check = true
					
					chair = obj
							
					host.set_pos(chair.get_pos().x, chair.get_pos().y)
					host.set_vel(chair.get_vel().x, chair.get_vel().y)
							
					host.air_movements_left = host.num_air_movements
					host.create_speed_after_image(Color(0.14, 0.14, 0.14, 0.8), 0.05)
							
					var di = Vector2(host.current_di.x, host.current_di.y).normalized()
					host.apply_force(str(di.x * 3), str(di.y * 3))
							
					host.found_chair.disable()

func _frame_6():
	if host.combo_count >= 1:
		enable_interrupt()
		
