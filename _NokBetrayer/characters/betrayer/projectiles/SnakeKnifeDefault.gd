extends DefaultFireball

var split_knife = preload("res://_NokBetrayer/characters/betrayer/projectiles/SnakeKnifeSplit.tscn")
var split_force = 4

var rift_history = []
var rift_speed = 14

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var vel = host.get_vel()
	
	#	--	BOUNCE
	if host.is_grounded() == true:
		host.move_directly("0", "-1")
		host.set_vel(vel.x, str(-int(vel.y)))
		
		host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2(0, 0))
		host.play_sound("Bounce")
		
	if abs(pos.x) >= host.stage_width:
		host.set_pos(str(host.stage_width * (pos.x / abs(pos.x))), str(pos.y))
		host.move_directly("-1", "0") if pos.x > 0 else host.move_directly("1", "0")
		host.set_vel(str(-int(vel.x)), vel.y)
		
		host.play_sound("Bounce")
	
	#	--	SPLIT
	if current_tick >= 30:
		var k1 = host.get_owner().spawn_object(split_knife, pos.x, pos.y, true, null, false)
		var k2 = host.get_owner().spawn_object(split_knife, pos.x, pos.y, true, null, false)
		
		k1.set_grounded(false)
		k2.set_grounded(false)
		
		k1.apply_force(str(int(vel.x) * 2), str(split_force))
		k2.apply_force(str(int(vel.x) * 2), str(-split_force))
		
		host.play_sound("Split")
		host.play_sound("Split2")
		
		host.disable()
		
	#	--	RIFT BOUNCE
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and obj.get_owner() == host.get_owner() and obj.get("disabled") != true and obj.get("tag") == "OrderRift":
			if host.hurtbox.overlaps(obj.hurtbox) and not obj.obj_name in rift_history:
				rift_history.append(obj.obj_name)
				host.reset_momentum()
				
				self.lifetime = 40
				
				var opos = host.get_owner().opponent.get_pos()
				var vec = Vector2(opos.x - pos.x, (opos.y - 18) - pos.y).normalized()
				host.apply_force(str(vec.x * rift_speed), str(vec.y * rift_speed))
				
				host.play_sound("RiftBounce")
				host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTHit1.tscn"), Vector2(0, 0))
				
				break
