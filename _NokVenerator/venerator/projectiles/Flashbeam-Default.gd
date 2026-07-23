extends DefaultFireball

onready var hbox = $SweptHitbox

var fire_interval = 8

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.get_opponent().get_pos()
	host.set_facing(1)
	
	#	--
	if current_tick % fire_interval == fire_interval - 1:
		hbox.to_x = 0
		hbox.to_y = 0
		hbox.dir_x = "1.0"
		
		$"%Beam".rotation_degrees = 0
		$"%Beam".scale = Vector2(1, 1)
		
		#	--
		var stars = []
		for star in host.objs_map.values():
			if is_instance_valid(star) and !star.disabled and star.get_owner() == host.get_owner() and star.get("tag") == "Protostar":
				stars.append(star)
		
		#	--
		if len(stars) > 0:
			var angle = Vector2(opos.x - pos.x, opos.y - pos.y).angle()
			var chosen_star = [null, INF]
			
			for star in stars:
				var spos = star.get_pos()
				var sangle = Vector2(spos.x - pos.x, spos.y - pos.y).angle()
				
				if abs(sangle - angle) <= abs(chosen_star[1] - angle):
					chosen_star[0] = star
					chosen_star[1] = sangle
			
			if chosen_star[0]:
				var spos = chosen_star[0].get_pos()
				var svec = Vector2(spos.x - pos.x, spos.y - pos.y)
				var sangle = svec.angle() + deg2rad(180)
				host.set_pos(spos.x, spos.y)
				
				if is_instance_valid(hbox):
					var hvec = Vector2(pos.x - spos.x, pos.y - spos.y)
					
					hbox.to_x = hvec.x
					hbox.to_y = hvec.y
					if host.get_pos().x > opos.x: hbox.dir_x = "-1.0"
					
					hbox.reset_hit_objects()
					hbox.activate()
				
				#	--
				$"%Beam".rotation_degrees = rad2deg(sangle)
				$"%Beam".scale.x = svec.length() / 100.0
				$"%Beam".start_emitting()
			
				host.spawn_particle_effect_relative(preload("res://_NokVenerator/venerator/effects/VN-Star1.tscn"), Vector2(0, 0))
				chosen_star[0].spawn_particle_effect_relative(preload("res://_NokVenerator/venerator/effects/VN-Star1.tscn"), Vector2(0, 0))
			
				#	--
				chosen_star[0].disable()
			
		else:
			host.disable()
	else:
		pass
