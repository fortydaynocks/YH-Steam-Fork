extends "res://characters/states/Idle.gd"

var game_time = 3600
var state_variables = {}

func _enter():
	game_time = Global.current_game.time

func _frame_0():
	if host.opponent.state_machine.get_node("RVL-Rivalry"):
		host.change_state("RVL-Rivalry")
		host.opponent.change_state("RVL-Rivalry")
		return
	
	for v in host.opponent.state_variables:
		state_variables[v] = host.opponent.get(v)

func _tick():
	host.penalty = 0
	host.opponent.penalty = 0
	var game = Global.current_game
	if (game.time - game.current_tick < game_time):
		game.time += 1
	if host.opponent.stance != "Intro" and current_tick < anim_length - 1:
		for v in state_variables.keys():
			host.opponent.set(v,state_variables[v])
		host.opponent.hitlag_ticks = 1
		host.opponent.state_interruptable = false
	if current_tick == anim_length - 1:
		host.opponent.state_interruptable = true
		host.state_interruptable = true
		host.stance = "Normal"
		return "Wait"
		
	if $"%Stuff".skin == "Aimorrago":
		if current_tick in [1]:
			$"%AI-Halo".modulate.a = 0
			host.play_sound("Intro-AI1")
			host.play_sound("Intro-AI2")
		
		if current_tick in [11, 17, 23, 29]:
			host.play_sound("Intro-AI3")
			host.play_sound("Intro-AI4")
			host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoSlam.tscn"), Vector2(0, -18))
		
		if current_tick in [20]:
			host.play_sound("Intro-AI5")
			
		if current_tick > 36 and current_tick <= 48:
			host.global_hitlag(1)
	
		if current_tick in [49]:
			host.play_sound("Intro-AI6")
			host.play_sound("Intro-AI7")
			host.screen_bump(Vector2(0, 0), 16, 0.4)
			host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoHit2.tscn"), Vector2(0, -18))
			host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoStarH.tscn"), Vector2(0, -18))
			
			if is_instance_valid($"%RedBG") and !host.is_ghost:
				$"%RedBG".visible = true
				$"%RedBG".modulate = Color(1, 0, 0, 0.25)
				
				create_tween().tween_property($"%RedBG", "modulate", Color(1, 0, 0, 0), 0.25)
				
			host.global_hitlag(4)
		
			#	--
			match host.opponent.get("charname"):
				
				#	--	SKINS
				"Aimorrago":
					$"%Stuff".do_text("Imposter...")
					
				"Sinestrosa":
					$"%Stuff".do_text("Bringer of Destruction...")
				
				"Camila":
					$"%Stuff".do_text("Spawn of Asymollyon...")
					
				"Munanyou":
					$"%Stuff".do_text("Lightning of Truth...")
				
				#	--	CHARACTERS
				"Torment":
					$"%Stuff".do_text("Traitor of Ichor...")
				
				"Psycho":
					$"%Stuff".do_text("Madman of Vorskirk...")
					
				"Silo":
					$"%Stuff".do_text("Eyes of Noimoiya...")
					
				"Niflheim":
					$"%Stuff".do_text("Tooth of Amaterasu...")
		
		if current_tick > 58 and current_tick <= 70:
			host.play_sound("Intro-AI8")
			host.global_hitlag(1)
			
		if current_tick in [88]:
			host.play_sound("Intro-AI9")
			host.play_sound("Intro-AI10")
			host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoHit1.tscn"), Vector2(18, 0))
			
		if current_tick in [118]:
			$"%RedBG".visible = false
			$"%AI-Halo".modulate.a = 1
			
	else:
		if current_tick <= 20:
			host.global_hitlag(1)
			
		if current_tick in [1]:
			host.play_sound("Intro1")
			if not $"%Stuff".skin == "Guillotine": host.play_sound("Intro2")
			
		if current_tick in [12]:
			host.play_sound("Intro3")
			
		if current_tick in [14]:
			host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoStar1.tscn"), Vector2(0, -18))
			
		if current_tick in [20]:
			host.play_sound("Intro4")
			
		if current_tick in [22]:
			host.play_sound("Intro5")
			host.play_sound("Intro6")
			
			host.screen_bump(Vector2(0, 0), 16, 0.2)
			host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoHit2.tscn"), Vector2(0, -17))
			
		if current_tick in [28, 34, 40, 46]:
			host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoStar2.tscn"), Vector2(0, -17))
			host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoSlam.tscn"), Vector2(0, -18))
			
			host.screen_bump(Vector2(0, 0), 4, 0.1)
			
		if current_tick in [60]:
			host.play_sound("Intro8")
			
			host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoStar2.tscn"), Vector2(0, -37))
			
		if current_tick in [62]:
			host.play_sound("Intro11")
			
		if current_tick >= 64 and current_tick <= 90:
			host.global_hitlag(1)
		
		if current_tick in [78]:
			host.play_sound("Intro9")
			
		if current_tick in [88]:
			host.play_sound("Intro10")
			
		if current_tick in [90]:
			host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoStar2.tscn"), Vector2(27, -29))
