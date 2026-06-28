extends "res://_NokGentleman/characters/gentleman/projectiles/AgentState.gd"

var end_block_next_turn = false

func _enter():
	._enter()
	
	host.start_invulnerability()
	self.end_action = -1
	end_block_next_turn = false

func _tick():
	._tick()
	
	if end_block_next_turn and (host.get_owner().was_my_turn or host.get_owner().opponent.was_my_turn):
		host.change_state("Default")
	
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and obj.disabled != true and obj != host.get_owner() and obj.get_owner() != host.get_owner():
			for ohbox in obj.get_active_hitboxes():
				
				#	--	DEFLECT ENEMY HITBOXES
				if ohbox.overlaps(host.hurtbox) and ohbox.get("hits_projectiles") == true:
					self.end_action = 0	#	--	CAN ACT AFTERWARDS
					end_block_next_turn = true	#	--	STOPS BLOCKING AFTERWARDS
					
					ohbox.deactivate()
					
					host.apply_force_relative("-1", "0")
					
					host.play_sound("Block")
					host.play_sound("Block2")
					
					host.spawn_particle_effect_relative(preload("res://_NokGentleman/characters/gentleman/effects/GM_Misc1.tscn"), Vector2(12, -32))
				
					host.rumble(2, 4)
					obj.rumble(2, 4)
					host.global_hitlag(4, true)
					
					#	--	INSTANT ACTIONABILITY
					host.get_owner().opponent.blocked_hitbox_plus_frames = 2
					
					if obj == host.get_owner().opponent:
						host.get_owner().apply_force_relative("-5", "0")
						host.get_owner().opponent.apply_force_relative("-5", "0")
						host.get_owner().opponent.projectile_free_cancel()
