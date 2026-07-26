extends DefaultFireball

onready var homingstar = preload("res://_NokVenerator/venerator/projectiles/HomingStar.tscn")
var minimum_frame = 5

func _tick():
	._tick()
	var pos = host.get_pos()
	var vel = host.get_vel()
	
	if host.is_grounded():
		host.move_directly("0", "-1")
		host.set_vel(vel.x, str(-int(vel.y)))
	
	#	--
	for star in host.objs_map.values():
		if is_instance_valid(star) and !star.disabled and star.get_owner() == host.get_owner() and !star == host:
			if star.get("tag") == "Protostar" and host.collision_box.overlaps(star.collision_box) and host.current_tick >= minimum_frame and star.current_tick >= minimum_frame:
				
				#	--
				host.get_owner().spawn_object(homingstar, pos.x, pos.y, false, null, false)
				
				host.play_sound("Transform")
				host.spawn_particle_effect_relative(
					preload("res://_NokVenerator/venerator/effects/VN-Ring1.tscn"),
					Vector2(0, 0)
				)
				
				star.disable()
				host.disable()
