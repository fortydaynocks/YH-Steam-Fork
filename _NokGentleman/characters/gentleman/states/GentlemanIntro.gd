extends CharacterState

var game_time = 3600
var state_variables = {}

func _enter():
	game_time = Global.current_game.time

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
	
	if host.opponent.get("charname") == "Gentleman":
		self.anim_name = "introAngry"
		
		var gunspread = 6
		
		if current_tick == 8:
			if host.id == 1: host.play_sound("IntroA1")
			
		if current_tick == 12:
			if host.id == 1: host.play_sound("IntroA2")
		
		if current_tick == 16:
			if host.id == 1: host.play_sound("IntroA3")
			
		if current_tick == 20:
			if host.id == 1: host.play_sound("IntroA3")
			
		if current_tick == 28:
			if host.id == 1: host.play_sound("IntroA4")
			
		if current_tick == 32:
			if host.id == 1:
				host.play_sound("IntroA5")
			
				host.global_hitlag(2)
				host.screen_bump(Vector2(0, 0), 2, 0.1)
			
			host.spawn_particle_effect(host.vfx_table.HitGun1, Vector2(host.randi_range(-gunspread, gunspread), host.randi_range((-gunspread) - 18, gunspread - 18)))
			
		if current_tick == 44:
			if host.id == 1:
				host.play_sound("IntroA5")
			
				host.global_hitlag(2)
				host.screen_bump(Vector2(0, 0), 2, 0.1)
			
			host.spawn_particle_effect(host.vfx_table.HitGun1, Vector2(host.randi_range(-gunspread, gunspread), host.randi_range((-gunspread) - 18, gunspread - 18)))
			
		if current_tick == 56:
			if host.id == 1: 
				host.play_sound("IntroA5")
			
				host.global_hitlag(2)
				host.screen_bump(Vector2(0, 0), 2, 0.1)
			
			host.spawn_particle_effect(host.vfx_table.HitGun1, Vector2(host.randi_range(-gunspread, gunspread), host.randi_range((-gunspread) - 18, gunspread - 18)))
			
		if current_tick == 64:
			if host.id == 1: host.play_sound("IntroA6")
			
		if current_tick == 72:
			if host.id == 1: host.play_sound("IntroA7")
			
		if current_tick == 92:
			if host.id == 1: 
				host.play_sound("IntroA8")
			
				host.global_hitlag(8)
				host.screen_bump(Vector2(0, 0), 8, 0.1)
			
			host.spawn_particle_effect(host.vfx_table.HitGun2, Vector2(host.randi_range(-gunspread, gunspread), host.randi_range((-gunspread) - 18, gunspread - 18)))
			
		if current_tick == 100:
			if host.id == 1: host.play_sound("IntroA9")
			
		if current_tick == 112:
			if host.id == 1:
				host.play_sound("Intro8")
				host.play_sound("Intro9")
				host.play_sound("Intro10")
				
				host.screen_bump(Vector2(0, 0), 4, 0.1)
			
			host.spawn_particle_effect_relative(host.vfx_table.Landing, Vector2(0, 0))
			

	else:
		self.anim_name = "intro"
	
		if current_tick == 20:
			host.play_sound("Intro2")
			
		if current_tick == 32:
			host.play_sound("Intro3")
			
		if current_tick == 33:
			host.play_sound("Intro3")
			
		if current_tick == 36:
			host.play_sound("Intro2")
			
		if current_tick == 56:
			host.play_sound("Intro11")
			
		if current_tick == 60:
			host.play_sound("Intro5")
			
		if current_tick == 64:
			host.play_sound("Intro4")
			
		if current_tick == 72:
			host.play_sound("Intro4")
			
		if current_tick == 76:
			host.play_sound("Intro6")
			
			host.spawn_particle_effect_relative(host.vfx_table.DashFloor, Vector2(0, 18), Vector2(-host.get_facing_int(), 0))
			host.screen_bump(Vector2(0, 0), 2, 0.1)
			
		if current_tick == 92:
			host.play_sound("Intro7")
			
		if current_tick == 100:
			host.play_sound("Intro8")
			host.play_sound("Intro9")
			host.play_sound("Intro10")
			
			host.spawn_particle_effect_relative(host.vfx_table.Landing, Vector2(0, 0))
			host.screen_bump(Vector2(0, 0), 4, 0.1)
