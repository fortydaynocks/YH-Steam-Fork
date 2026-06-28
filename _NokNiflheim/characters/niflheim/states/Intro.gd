extends CharacterState

var game_time = 3600
var state_variables = {}

export (PackedScene) var plume_scene
export (PackedScene) var smite_scene
export (PackedScene) var excision_scene
export (PackedScene) var brimstone_scene

func _enter():
	
	game_time = Global.current_game.time
	
	if host.special == "extra_special":
		anim_name = "Intro"
	elif host.special == "special":
		anim_name = "IntroSpecial"
	else:
		anim_name = "Intro"

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
		
	if host.special == "extra_special":
		if current_tick == 1:
			host.play_sound("Intro_1")
			host.play_sound("MetalRing")
			host.spawn_object(brimstone_scene, -720, -440, true)
		
		if current_tick == 70:
			host.spawn_object(smite_scene, 0, -16)
		
	elif host.special == "special":
		if current_tick == 1:
			host.play_sound("Intro_1")
			
		if current_tick == 56:
			host.play_sound("Intro_56")
			
		if current_tick == 70:
			host.spawn_particle_effect_relative(excision_scene, Vector2(0, -18))
			host.play_sound("Intro_72a")
			host.play_sound("Intro_72b")
			
			host.spawn_object(plume_scene, 40, 16)
			host.spawn_object(plume_scene, -40, 16)
			host.spawn_object(plume_scene, 100, 16)
			host.spawn_object(plume_scene, -100, 16)
			
		if current_tick == 96:
			host.play_sound("Intro_48")
			
	else:
		if current_tick == 16:
			host.spawn_object(plume_scene, 60, 16)
			host.spawn_object(plume_scene, -60, 16)
			
		if current_tick == 32:
			host.spawn_object(plume_scene, 40, 16)
			host.spawn_object(plume_scene, -40, 16)
			
		if current_tick == 48:
			host.spawn_object(plume_scene, 20, 16)
			host.spawn_object(plume_scene, -20, 16)
			
		if current_tick == 64:
			host.spawn_object(plume_scene, 0, 16)
			
		if current_tick == 70:
			host.spawn_object(smite_scene, 0, -16)
			host.play_sound("MetalRing")

