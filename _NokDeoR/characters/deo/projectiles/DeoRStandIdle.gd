extends "res://_NokDeoR/characters/deo/projectiles/DeoRStandState.gd"

var follow_damping = 0.1

func _tick():
	._tick()
	
	if host.mode_data:
		if host.mode == "Stand":
			pass
		
		elif host.mode == "Follow":
			
			
			#	--	MOVEMENT
			var pos = Vector2(host.get_pos().x, host.get_pos().y)
			var cpos = Vector2(host.creator.get_pos().x, host.creator.get_pos().y)
			cpos.x += Vector2()
			var tpos = lerp(cpos, pos, follow_damping)
			
			host.set_pos(str(tpos.x), str(tpos.y))
			
			#	--	OTHER
			host.sprite.z_index = host.creator.sprite.z_index - 1
