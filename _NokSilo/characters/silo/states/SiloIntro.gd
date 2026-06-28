extends CharacterState

var game_time = 3600
var state_variables = {}

var spawn_pos = Vector2(0, 0)

func _enter():
	game_time = Global.current_game.time
	
func _frame_0():
	for v in host.opponent.state_variables:
		state_variables[v] = host.opponent.get(v)

func _tick():
	var game = Global.current_game
	if(game.time - game.current_tick < game_time):
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
	
	if host.vip.skin == "Sinestrosa":
		if current_tick == 1:
			host.play_sound("Sin-Intro1")
			host.play_sound("Sin-Spawn")
			
			host.sin_voiceline(host.vip.quotes.Intro)
			
			spawn_pos = Vector2(host.get_pos().x, host.get_pos().y)
			host.move_directly_relative("0", "-100")
			
		if current_tick > 1:
			var current_pos = Vector2(host.get_pos().x, host.get_pos().y)
			var lerp_x = lerp(current_pos.x, spawn_pos.x, 0.05)
			var lerp_y = lerp(current_pos.y, spawn_pos.y, 0.05)
			host.set_pos(str(lerp_x), str(lerp_y))
			
		if current_tick == 48:
			host.play_sound("Sin-Intro2")
			
			host.screen_bump(Vector2(0, 0), 4, 0.25)
			host.spawn_particle_effect_relative(host.vfx_table.Hit2, Vector2(0, -18))
			
			host.set_pos(str(spawn_pos.x), str(spawn_pos.y))
		
		if current_tick == 64:
			host.play_sound("Sin-Intro3")
		
		if current_tick == 88:
			host.play_sound("Sin-Intro4")
			
		if current_tick == 92:
			host.play_sound("Sin-Intro5")
			
			host.vip.show_wings = true
			
			host.screen_bump(Vector2(0, 0), 4, 0.25)
			host.spawn_particle_effect_relative(host.vfx_table.Hit1, Vector2(-20, -32))
			host.spawn_particle_effect_relative(host.vfx_table.Hit1, Vector2(12, -32))
			
	else:	
		if current_tick == 1:
			host.play_sound("Super3")
			host.play_sound("StressHigh")
			
			if host.vip.skin == "SinWings":
				host.sin_voiceline(host.vip.quotes.SinWings)
			
			host.spawn_particle_effect_relative(host.vfx_table.Hit1, Vector2(0, -18))
			host.spawn_particle_effect_relative(host.vfx_table.Misc1, Vector2(0, -18))
			host.screen_bump(Vector2(0, 0), 4, 0.25)
		
			for i in range(1, 4):
				host.spawn_particle_effect_relative(host.vfx_table.Flower, Vector2(host.randi_range(-60, 60), 0))
		
		if current_tick == 68:
			host.play_sound("Run1")
			host.play_sound("Harvest2")
			
			if host.vip.skin == "SinWings":
				host.vip.show_wings = true
			
			host.spawn_particle_effect_relative(host.vfx_table.Harvest, Vector2(4, -18))
			host.screen_bump(Vector2(0, 0), 1, 0.25)
			
		if current_tick == 92:
			host.play_sound("Intro1")
			
		if current_tick == 100:
			host.play_sound("Intro2")
