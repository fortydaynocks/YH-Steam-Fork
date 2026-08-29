extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

#	--
var game_time = 3600
var state_variables = {}

func _enter():
	
	game_time = Global.current_game.time
	
func _frame_0():
	for v in host.opponent.state_variables:
		state_variables[v] = host.opponent.get(v)

func _exit():
	._exit()
	
	if $"%Stuff".skin == "Akuma":
		$"%Stuff".music_access = true
		$"%AK-Halo".visible = true
		$"%BG".visible = false
		
	if !host.is_ghost:
		Global.current_game.camera_zoom = 1

func _tick():
	._tick()
	
	host.penalty = 0
	host.opponent.penalty = 0
	var game = Global.current_game
	if(game.time-game.current_tick<game_time):
		game.time+=1
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
	if $"%Stuff".skin == "Akuma":
		if current_tick == 0:
			$"%BG".visible = true
			$"%Stuff".music_access = false
			$"%AK-Halo".visible = false
			
		if current_tick == 1:
			host.grab_camera_focus()
			host.global_hitlag(20)
			
			host.play_sound("AK-Intro1")
			host.play_sound("AK-Intro2")
			host.play_sound("AK-Intro3")
			
			host.spawn_particle_effect_relative(
				preload("res://_NokGorenShin/characters/shingoren/effects/SG_Hit1k.tscn"),
				Vector2(0, 0))
		
		if current_tick == 27:
			host.play_sound("AK-Intro4")
			
			host.spawn_particle_effect_relative(
				preload("res://_NokGorenShin/characters/shingoren/effects/SG_MarkActivate.tscn"),
				Vector2(0, -100))
		
		if current_tick == 43:
			host.play_sound("AK-Intro5")
			host.play_sound("AK-Intro6")
			host.play_sound("AK-Intro7")
			
			host.screen_bump(Vector2(0, 10), 1, 0.5)
			host.spawn_particle_effect_relative(
				preload("res://_NokGorenShin/characters/shingoren/effects/SG_AxeStomp.tscn"),
				Vector2(0, 0))
		
		if current_tick == 53:
			if !$"%Stuff".DORM:
				host.play_sound(host.randi_choice(["AK-IntroVoice1", "AK-IntroVoice2", "AK-IntroVoice3", "AK-IntroVoice4"]))
		
		if current_tick == 61:
			host.play_sound("AK-Intro8")
			
		if current_tick == 77:
			$"%Stuff".music_access = true
			$"%AK-Halo".visible = true
			$"%BG".visible = false
			
			host.play_sound("AK-Intro9")
			host.play_sound("AK-Intro10")
			host.play_sound("AK-Intro11")
			host.play_sound("AK-Intro12")
			host.play_sound("AK-Intro13")
			host.play_sound("AK-Intro14")
			
			host.screen_bump(Vector2(0, 10), 2, 0.5)
			host.spawn_particle_effect_relative(
				preload("res://_NokGorenShin/characters/shingoren/effects/SG_AxeStompBig.tscn"),
				Vector2(0, 0))
				
			host.spawn_particle_effect_relative(
				preload("res://_NokGorenShin/characters/shingoren/skins/akuma/effects/SGAK-Intro.tscn"),
				Vector2(0, 0))
				
			host.global_hitlag(6)
		
		if current_tick > 77:
			host.global_hitlag(1)
		
		if current_tick == 100:
			host.release_camera_focus()
		
		#if current_tick == 1:
			#host.play_sound("Intro1")
			
		#if current_tick == 4:
			#host.play_sound("IntroSwing")
			#host.play_sound("AK_IntroWarning")
			
			#host.play_voiceline(akuma_voicelines[0])
			
		#if current_tick == 12:
			#host.play_sound("DemonStep")
			
		#if current_tick == 48:
			#host.play_sound("IntroCloth")
			
		#if current_tick == 66:
			#host.screen_bump(Vector2(0, 1), 16, 0.25)
			#host.play_sound("IntroStomp")
			#host.play_sound("IntroBlast")
			
			#host.spawn_particle_effect_relative(host.vfx_table.Landing, Vector2(0, 0))
			#host.spawn_particle_effect_relative(host.vfx_table.Wind1, Vector2(-host.get_facing_int(), 0), Vector2(1, 0))
			#host.spawn_particle_effect_relative(host.vfx_table.Wind1, Vector2(host.get_facing_int(), 0), Vector2(-1, 0))
		
	else:
		if current_tick == 1:
			host.play_sound("Intro1")
			
			if $"%Stuff".skin == "Akuma":
				host.play_sound("AKM-Spawn1")
				host.play_sound("AKM-Spawn2")
			
			if $"%Stuff".skin == "UberOni":
				host.play_sound("UBER_Intro1")
				host.play_sound("UBER_Intro2")
				
				$"%Stuff".do_voiceline(self.u_voicelines[0])
				
		if current_tick == 4:
			host.play_sound("IntroSwing")
			host.play_sound("IntroAmbience")
			
		if current_tick == 12:
			host.play_sound("DemonStep")
			
		if current_tick == 48:
			host.play_sound("IntroCloth")
			
		if current_tick == 66:
			host.screen_bump(Vector2(0, 1), 16, 0.25)
			host.play_sound("IntroStomp")
			host.play_sound("IntroBlast")
			
			host.spawn_particle_effect_relative(host.vfx_table.Landing, Vector2(0, 0))
			host.spawn_particle_effect_relative(host.vfx_table.Wind1, Vector2(-host.get_facing_int(), 0), Vector2(1, 0))
			host.spawn_particle_effect_relative(host.vfx_table.Wind1, Vector2(host.get_facing_int(), 0), Vector2(-1, 0))
		
func _process(delta):
	if $"%Stuff".skin == "Akuma":
		var game = Global.current_game
		
		if current_tick >= 0 and current_tick < 43:
			game.camera_zoom = lerp(game.camera_zoom, 0.6, 0.05)
			
		if current_tick >= 44 and current_tick < 77:
			game.camera_zoom = lerp(game.camera_zoom, 0.8, 0.05)
				
		if current_tick >= 78 and current_tick < 100:
			game.camera_zoom = lerp(game.camera_zoom, 1, 0.1)
	
