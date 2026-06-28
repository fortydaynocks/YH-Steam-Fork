extends DefaultFireball

onready var detector = $"%Detector"

func _enter():
	._enter()
	
	host.sprite.rotation = host.randi_range(0, 360)

func _frame_12():
	var closest_flower = host.creator.get_closest_flower(host, host.creator.eye_distance)
	
	if closest_flower:
		host.target = closest_flower
	else:
		host.target = host.creator.opponent

func _tick():
	._tick()
	
	var pos = host.get_pos()
	
	$"%Eyeball".visible = (current_tick >= 13)
	$"%Tracker".visible = (current_tick >= 13)
	
	if current_tick >= 120 or host.creator.opponent.combo_count > 0:
		host.change_state("Close")
	
	#	--	EYE FOLLOWING
	if host.follow_target:
		if is_instance_valid(host.creator.objs_map[host.follow_target]):
			var follow_obj = host.creator.objs_map[host.follow_target]
			var target_pos = Vector2(follow_obj.get_pos().x + host.follow_offset.x, follow_obj.get_pos().y + host.follow_offset.y)
			
			var l_x = lerp(float(pos.x), float(target_pos.x), 0.2)
			var l_y = lerp(float(pos.y), float(target_pos.y), 0.2)
	
			host.set_pos(str(l_x), str(l_y))
	
	#	--	EYE BEHAVIOUR
	if current_tick >= 13:
		if is_instance_valid(host.target):
			
			if float(host.distance_to(host.target)) > host.creator.eye_distance:
				return "Close"
				
			#	--
			var tpos = host.target.get_pos()
			var elevation = (host.target.hurtbox.y - host.target.hurtbox.height) / 2
			var vec = Vector2(float(tpos.x) - float(pos.x), (float(tpos.y) - float(pos.y)) + elevation)
			var vec_n = vec.normalized()
			
			$"%Eyeball".rotation_degrees = rad2deg(vec_n.angle())	
			$"%Tracker".points[1] = vec
			
			if is_instance_valid(detector):
				detector.to_x = (vec_n.x * host.creator.eye_distance) * host.get_facing_int()
				detector.to_y = (vec_n.y * host.creator.eye_distance)
			
			#	--
			var exclusions = [host, host.creator]
			for obj in host.creator.objs_map.values():
				if is_instance_valid(obj) and is_instance_valid(detector):
					if obj != host.creator and (obj.creator != host.creator or obj.get("fuckingtraitor") == true) and obj.disabled != true:
						if obj.obj_name != host.target.obj_name:
							if detector.overlaps(obj.hurtbox):
								if obj is Fighter:
									if obj.get("projectile_invulnerable") != true:
										host.change_state("Activate")
								elif obj is BaseProjectile:
									host.change_state("Activate")
		else:
			host.change_state("Close")
				
		
func detect(obj):
	pass
