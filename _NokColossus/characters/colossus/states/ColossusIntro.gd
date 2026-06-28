extends CharacterState

var game_time = 3600
var state_variables = {}

func _enter():
	
	game_time = Global.current_game.time
	
func _frame_0():
	for v in host.opponent.state_variables:
		state_variables[v] = host.opponent.get(v)

func _tick():
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

	#	--	CHARACTER STUFF
	
	if current_tick == 1 and host.skin == 1:
		if host.opponent.stance != "Intro":
			host.opponent.state_interruptable = true
			host.state_interruptable = true
			host.stance = "Normal"
			return "Wait"
	
	if host.skin == 1:
		pass
		
	else:
		if current_tick == 1:
			host.play_sound("IntroWhoosh1")
			host.play_sound("IntroWhoosh2")

		if current_tick == 23:
			host.spawn_particle_effect_relative(preload("res://_NokColossus/characters/colossus/effects/ColossusSlam.tscn"), Vector2(0, 0))
			host.screen_bump(Vector2(0, 0), 16, 0.25)

		if current_tick == 24:
			host.play_sound("IntroRocks1")
			host.play_sound("IntroSlam1")
			host.play_sound("IntroSlam2")
			
		if current_tick == 56:
			host.play_sound("IntroWhoosh3")

		if current_tick == 64:
			host.screen_bump(Vector2(0, 0), 8, 0.25)
			host.play_sound("IntroWhoosh4")
			host.play_sound("IntroMetal1")
		
