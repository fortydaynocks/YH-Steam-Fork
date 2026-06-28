extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

func _enter():
	._enter()
	
	host.afterimage(host.extra_color_1, 0.25)

func _frame_0():
	if data.convert == true or data.compose == true:
		host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoStar1.tscn"), Vector2(0, -18))
		host.play_sound("Transfuse2")
		
func _frame_6():
	host.play_sound("Transfuse")

func _frame_7():
	if data.convert == true or data.compose == true:
		host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoHit1.tscn"), Vector2(-8, -32))
		host.screen_bump(Vector2(0, 0), 8, 0.25)
		
		host.play_sound("Transfuse3")
		host.play_sound("Transfuse4")
		host.play_sound("Transfuse5")
		
		#	--
		
		if data.convert == true:
			var self_h_damage = host.get_self_h_damage(true)
			if host.hp - self_h_damage < 1:
				host.hp = 1
			else:
				host.take_damage(self_h_damage)
				
			host.wounds += host.scars
			host.scars = 0
			
		if data.compose == true:
			host.insanity = false
		

func _tick():
	._tick()
	
	if current_tick < 6:
		host.global_hitlag(2)
	else:
		if not current_tick in [6, 7]:
			host.global_hitlag(1)
