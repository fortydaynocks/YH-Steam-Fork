extends "res://_NokDurmak/characters/durmak/summons/WalkerState.gd"

func _tick():
	._tick()
	
	for cleaver in host.objs_map.values():
		if is_instance_valid(cleaver) and (not cleaver.disabled) and cleaver.get_owner() == host.get_owner() and cleaver.get("tag") == "Cleaver":
			if cleaver.hurtbox.overlaps(host.hurtbox):
				var pos = host.get_pos()
				var vel = host.get_vel()
				var fac = host.get_facing_int()
				
				var obj = host.get_owner().spawn_object(host.get_owner().lord_reference, pos.x, pos.y, false, null, false)
				obj.set_vel(vel.x, vel.y)
				obj.set_facing(fac)
				obj.set_grounded(false)

				#	--
				cleaver.disable()
				host.disable()
