extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

#	--
var game_time = 3600
var state_variables = {}

func _enter():
	
	game_time = Global.current_game.time
	
func _frame_0():
	for v in host.opponent.state_variables:
		state_variables[v] = host.opponent.get(v)

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
	if host.skin == 1:
		if current_tick == 1:
			host.play_sound("Intro1")
			
		if current_tick == 4:
			host.play_sound("IntroSwing")
			host.play_sound("AK_IntroWarning")
			
			host.play_voiceline(akuma_voicelines[0])
			
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
		
