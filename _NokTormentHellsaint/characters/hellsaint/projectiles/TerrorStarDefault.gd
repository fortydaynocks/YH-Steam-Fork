extends "res://characters/stickman/projectiles/fireball_states/Default.gd"

var deflect_force = 10
var deflected = false

func _frame_0():
	deflected = false

func _tick():
	._tick()
	
	var sickle_and_destroy_this = false
	
	if host.get_owner().was_my_turn or host.get_opponent().was_my_turn:
		deflected = false
	
	for obj in host.objs_map.values():
		
		#	--	TRANSFORMATION DETECTION
		if is_instance_valid(obj) and obj.disabled != true and obj.get_owner() == host.get_owner():
			if obj.get("tag") in ["TerrorStar", "TerrorSpike"]:
				if obj != host and obj.hurtbox.overlaps(host.hurtbox) and obj.get("will_sickle") != true:
					sickle_and_destroy_this = obj
		
			elif obj.get("tag") in ["Sickle"]:
				sickle_and_destroy_this = null
				break
				
		#	--	STAR DEFLECTION
		if deflected != true:
			if is_instance_valid(obj) and obj.disabled != true and obj == host.get_opponent():
				for ohbox in obj.get_active_hitboxes():
					if ohbox.overlaps(host.hurtbox):
						deflected = true
						
						host.global_hitlag(8)
						host.screen_bump(Vector2(0, 0), 4, 0.1)
						host.spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Misc3.tscn"), Vector2())
						host.play_sound("Deflect")
						host.play_sound("Deflect2")
						
						var dir = Vector2(ohbox.dir_x, ohbox.dir_y).normalized()
						host.apply_force(str(dir.x * deflect_force * host.get_opponent().get_facing_int()), str(dir.y * deflect_force))
						
						if obj.has_method("projectile_free_cancel"):
							obj.projectile_free_cancel()
						
						break
			
	if is_instance_valid(sickle_and_destroy_this):
		host.sickle()
		sickle_and_destroy_this.disable()
				
