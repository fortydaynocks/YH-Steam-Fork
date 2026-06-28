extends "res://characters/states/Idle.gd"

var game_time = 3600
var state_variables = {}

var start_pos = Vector2(0, 0)
var far_pos = Vector2(0, 0)	#	FURTHEST BACK POINT
var high_pos = Vector2(0, 0)	#	HIGHEST POINT

#	--
func _enter():
	
	if $"%Stuff".skin != "Astaroth":
		game_time = Global.current_game.time
		Global.current_game.max_char_distance = 9999

func _exit():
	._exit()
	
	if $"%Stuff".skin != "Astaroth":
		Global.current_game.max_char_distance = 600
		host.set_pos(str(start_pos.x), str(start_pos.y))

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
		
	#	--
	if $"%Stuff".skin == "Astaroth":
		if current_tick == 1:
			host.screen_bump(Vector2(0, 0), 2, 0.1)
			
			host.play_sound("GainFlamestain")
			host.play_sound("GraceFortitude")
			
			host.play_sound("AS-Laugh2")
			
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Star.tscn"), Vector2(0, -96))
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-FlameParticles3.tscn"), Vector2(0, -96))
			
			$"%Stuff".do_text($"%Stuff".choose_text(host.opponent.get("charname"), "Intro", $"%Stuff".quotes_asta))
			
		if current_tick == 10:
			host.screen_bump(Vector2(0, 0), 2, 0.1)
			
			host.play_sound("GainFlamestain")
			host.play_sound("GraceFortitude")
			
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Star.tscn"), Vector2(-76, -44))
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-FlameParticles3.tscn"), Vector2(-76, -44))
			
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Star.tscn"), Vector2(76, -44))
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-FlameParticles3.tscn"), Vector2(76, -44))
			
		if current_tick == 20:
			host.screen_bump(Vector2(0, 0), 2, 0.1)
			
			host.play_sound("GainFlamestain")
			host.play_sound("GraceFortitude")
			
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Star.tscn"), Vector2(-48, 44))
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-FlameParticles3.tscn"), Vector2(-48, 44))
			
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-Star.tscn"), Vector2(48, 44))
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-FlameParticles3.tscn"), Vector2(48, 44))
			
		if current_tick == 40:
			host.screen_bump(Vector2(0, 0), 4, 0.1)
			
			host.play_sound("ArmorHit")
			
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/skins/astaroth/effects/CSR-AS-Penta.tscn"), Vector2(0, -18))
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-HitFlame.tscn"), Vector2(0, -18))
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-EarthShake.tscn"), Vector2(0, 0))
			
		if current_tick == 60:
			host.screen_bump(Vector2(0, 0), 8, 0.5)
			
			host.play_sound("ArmorBreak")
			host.play_sound("SuperClash")
			host.play_sound("Intro1")
			
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-HitFlameHuge.tscn"), Vector2(0, -18))
	else:
		if current_tick == 0:
			start_pos = Vector2(host.get_pos().x, host.get_pos().y)
			far_pos = Vector2(start_pos.x - (400 * host.get_facing_int()), start_pos.y - 100)
			high_pos = Vector2(start_pos.x - (200 * host.get_facing_int()), start_pos.y - 400)
				
			host.set_pos(str(far_pos.x), str(far_pos.y))
				
		if current_tick <= 50:
			var adjusted_start_pos = Vector2(start_pos.x - (50 * host.get_facing_int()), start_pos.y)
			
			var far2high = lerp(far_pos, high_pos, current_tick / 50.0)
			var high2start = lerp(high_pos, adjusted_start_pos, current_tick / 50.0)
			
			var target_lerp = lerp(far2high, high2start, current_tick / 50.0)
			host.set_pos(str(target_lerp.x), str(target_lerp.y))
			
		if current_tick > 50 and current_tick <= 120:
			var pos = Vector2(host.get_pos().x, host.get_pos().y)
			var target_lerp = lerp(pos, start_pos, 0.2)
			
			host.set_pos(str(target_lerp.x), str(target_lerp.y))
			
		#	--
		if current_tick == 1:
			host.screen_bump(Vector2(0, 0), 4, 0.5)
			
			host.play_sound("Intro1")
			host.play_sound("Intro2")
			host.play_sound("Intro3")
			
		if current_tick == 35:
			host.play_sound("Intro4")
			host.play_sound("Intro5")
			host.play_sound("Intro6")
			
		if current_tick == 49:
			host.screen_bump(Vector2(0, 1), 64, 0.35)
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-MassBreaker.tscn"), Vector2(0, 30))
			host.spawn_particle_effect_relative(preload("res://characters/robo/GroundSlamEffect.tscn"), Vector2(100, 30))
			host.spawn_particle_effect_relative(preload("res://characters/robo/GroundSlamEffect.tscn"), Vector2(-100, 30))
		
			host.global_hitlag(8)	
		
			host.play_sound("Intro7")
			host.play_sound("Intro8")
			host.play_sound("Intro9")
			
			$"%Stuff".do_text($"%Stuff".choose_text(host.opponent.get("charname"), "Intro"))
			
		if current_tick < 50:
			if current_tick % 2 == 0:
				host.spawn_particle_effect_relative(preload("res://fx/KnockbackSmoke.tscn"), Vector2(0, -18))
			
		if current_tick > 50 and current_tick < 80:
			host.global_hitlag(1)
			
		if current_tick == 68:
			host.play_sound("Intro10")
			
		if current_tick == 74:
			host.play_sound("Intro11")
			host.play_sound("Intro13")
			
		if current_tick == 78:
			host.play_sound("Intro12")
			
			host.set_pos(str(start_pos.x), str(start_pos.y))
			Global.current_game.max_char_distance = 600
			
			host.screen_bump(Vector2(0, 0), 8, 0.1)
			host.spawn_particle_effect_relative(preload("res://_NokColossusR/characters/colossus/effects/CSR-FlameParticles2.tscn"), Vector2(12, -30))
		
#	--
#func _process(delta):
	#if current_tick < 50:
		#var camera = host.get_camera(); if camera:
			#camera.position = lerp(camera.position, Vector2(0, 0), 0.25)
