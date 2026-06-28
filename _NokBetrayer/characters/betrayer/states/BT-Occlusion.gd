extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

func is_usable():
	
	if host.abs_asc > 0:
		self.super_level_ = 0
		
	else:
		self.super_level_ = 1
	
	return .is_usable()

func _frame_2():
	if host.skin == "Munanyou":
		host.play_sound("Intro-MuThunder2")
		
		host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/skins/munanyou/effects/BT-MU-Lightning.tscn"), Vector2(15, -45))
	else:
		host.play_sound("Occlusion")
	
	if data:
		var eye = host.obj_from_name(data)
		
		if eye:
			var epos = eye.get_pos()
			
			if host.knight.Knight:
				if not host.knight.NextKnightBuffer:
					eye.buffer_knight()
			
			else:
				host.summon_knight(epos, eye.eye_type)
				eye.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTHit1Weak.tscn"), Vector2(0, 0))
				eye.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTStar.tscn"), Vector2(0, 0))
				
				eye.disable()

func _tick():
	._tick()
	
	self.interruptible_on_opponent_turn = current_tick >= 5
	#	--	IN PRACTISE, IOOT OCCURS ON FRAMES 6+
	
	host.afterimage(Color("#006aff"), 0.1)
