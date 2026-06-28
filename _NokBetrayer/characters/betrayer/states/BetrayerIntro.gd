extends CharacterState

var game_time = 3600
var state_variables = {}

var start_pos = Vector2(0, 0)

func _enter():
	game_time = Global.current_game.time
	Global.current_game.max_char_distance = 9999

func _exit():
	._exit()
	
	$"%Mu-IntroLaser1".visible = false
	$"%Mu-IntroLaser2".visible = false
	
	Global.current_game.max_char_distance = 600

func _frame_0():
	for v in host.opponent.state_variables:
		state_variables[v] = host.opponent.get(v)

func _tick():
	host.penalty = 0
	host.opponent.penalty = 0
	var game = Global.current_game
	if (game.time - game.current_tick < game_time):
		game.time += 1
	if host.opponent.stance != "Intro" and current_tick < 119:
		for v in state_variables.keys():
			host.opponent.set(v,state_variables[v])
		host.opponent.hitlag_ticks = 1
		host.opponent.state_interruptable = false
	if current_tick == 119:
		host.opponent.state_interruptable = true
		host.state_interruptable = true
		host.stance = "Normal"
		return "Wait"
		
	#	--
	if host.skin == "Munanyou":
		$"%Mu-IntroLaser1".frame = host.sprite.frame
		$"%Mu-IntroLaser2".frame = host.sprite.frame
		
		if current_tick in [1]:
			$"%Mu-IntroLaser1".visible = true
			$"%Mu-IntroLaser2".visible = true
			
			host.play_sound("Intro-Mu1")
			host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTStar2.tscn"), Vector2(0, -18))
			host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/skins/munanyou/effects/BT-MU-Intro.tscn"), Vector2(0, 0))
				
		if current_tick in [20]:
			host.play_sound("Intro-Mu2")
			host.play_sound("Intro-Mu3")
			host.play_sound("Intro-Mu4")
			
			host.screen_bump(Vector2(0, 0), 8, 0.25)
			host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTMisc2.tscn"), Vector2(0, -18))
			host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTFloorIntro.tscn"), Vector2(0, 0))
				
		if current_tick in [20, 28, 36, 42, 50, 58]:
			host.play_sound("Intro-Mu5")
			
			host.screen_bump(Vector2(0, 0), 1, 0.25)
			host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTStar2.tscn"), Vector2(0, -18))
			
		if current_tick in [60]:
			$"%Mu-Extra1".visible = true
			$"%Mu-Extra1".emitting = true
			
		if current_tick in [68]:
			host.play_sound("Intro-Mu6")
			
		if current_tick in [80]:
			host.play_sound("Intro-Mu7")
			
		if current_tick in [84]:
			host.play_sound("Intro-Mu8")
			host.play_sound("Intro-Mu9")
			
			host.screen_bump(Vector2(0, 0), 4, 0.25)
			host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTMisc1.tscn"), Vector2(0, -18))
		
			$"%Mu-Extra2".visible = true
		
	else:
		match current_tick:
			1:
				host.play_sound("IntroBell")
				host.play_sound("IntroAmbience")
				
			4:
				host.spawn_particle_effect_relative(host.vfx_table.Hit, Vector2(0, -80))
				
			12:
				host.spawn_particle_effect_relative(host.vfx_table.HitWeak, Vector2(0, -60))
				host.play_sound("IntroDrop")
			16:
				host.play_sound("IntroSlam")
				host.play_sound("IntroSlam2")
				host.screen_bump(Vector2(0, 0), 4, 0.25)
				host.spawn_particle_effect_relative(host.vfx_table.Landing, Vector2(0, 0))
				host.spawn_particle_effect_relative(host.vfx_table.Hit2, Vector2(0, 0))
				host.spawn_particle_effect_relative(host.vfx_table.FloorIntro, Vector2(0, 0))
			28:
				host.play_sound("IntroCloth")
			44:
				host.play_sound("IntroSlash")
				host.screen_bump(Vector2(0, 0), 1, 0.1)
			48:
				host.spawn_particle_effect_relative(host.vfx_table.HitWeak, Vector2(0, -18))
			64:
				host.play_sound("IntroSlash2")
				host.screen_bump(Vector2(0, 0), 1, 0.1)
			80:
				host.play_sound("IntroSlash3")
				host.screen_bump(Vector2(0, 0), 1, 0.1)
			84:
				host.spawn_particle_effect_relative(host.vfx_table.HitWeak, Vector2(0, -18))
