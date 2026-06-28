extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

onready var redknife = preload("res://_NokPsychoR/characters/psycho/projectiles/RedKnife.tscn")

func is_usable():
	return .is_usable() and host.insanity != true

func _enter():
	._enter()
	
	if $"%Stuff".skin == "Aimorrago":
		$"%Stuff".do_text(host.randi_choice($"%Stuff".ai_quotes.Insanity))

func _exit():
	._exit()
	
	host.release_camera_focus()

func _frame_1():
	if $"%Stuff".skin == "Aimorrago":
		host.play_sound("AISound2")
		host.play_sound("Insanity-AI")
		host.grab_camera_focus()
		host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoStarH.tscn"), Vector2(0, -18))
	
	elif $"%Stuff".skin == "Guillotine":
		host.grab_camera_focus()
		
	else:
		host.play_sound("Insanity1")
		if not $"%Stuff".skin == "Guillotine": host.play_sound("InsanityLaugh")
		host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoInsanity.tscn"), Vector2(0, -18))
		host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoHit4.tscn"), Vector2(0, -18))
	
	host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoStar1.tscn"), Vector2(0, -18))
	
func _frame_3():
	host.start_invulnerability()
	
func _frame_4():
	if $"%Stuff".skin == "Guillotine":
		host.play_sound("BEHEAD-HIM")
		host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/skins/guillotine/effects/PS-GL-BEHEAD.tscn"), Vector2(0, -18))
	
func _frame_15():
	if $"%Stuff".skin == "Aimorrago":
		host.play_sound("Insanity1")
		
func _frame_10():
	if $"%Stuff".skin == "Guillotine":
		host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/skins/guillotine/effects/PS-GL-HIM.tscn"), Vector2(0, -18))
	
func _frame_24():
	host.play_sound("Hunt3")
	
	host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoStar1.tscn"), Vector2(0, -18))
	
func _frame_35():
	host.insanity = true
	host.scars += 30
	host.release_camera_focus()
	
	if $"%Stuff".skin == "Aimorrago":
		host.play_sound("Insanity-AI2")
		host.play_sound("Insanity4")
		
		if is_instance_valid($"%RedBG") and !host.is_ghost:
			$"%RedBG".visible = true
			$"%RedBG".modulate = Color(1, 0, 0, 0.25)
				
			create_tween().tween_property($"%RedBG", "modulate", Color(1, 0, 0, 0), 0.25)
		
	else:
		host.play_sound("Insanity2")
		host.play_sound("Insanity3")
		host.play_sound("Insanity4")
		host.play_sound("Insanity5")
	
	if data == true:
		var pos = host.get_pos()
		var k1 = host.spawn_object(redknife, pos.x, pos.y, false, null, false)
		var k2 = host.spawn_object(redknife, pos.x, pos.y, false, null, false)
		var k3 = host.spawn_object(redknife, pos.x, pos.y, false, null, false)
		var k4 = host.spawn_object(redknife, pos.x, pos.y, false, null, false)
		var k5 = host.spawn_object(redknife, pos.x, pos.y, false, null, false)
		var k6 = host.spawn_object(redknife, pos.x, pos.y, false, null, false)
		
		k1.set_grounded(false)
		k2.set_grounded(false)
		k3.set_grounded(false)
		k4.set_grounded(false)
		k5.set_grounded(false)
		k6.set_grounded(false)
		
		k1.apply_force("-12", "0")
		k2.apply_force("-8", "-6")
		k3.apply_force("-2", "-12")
		k4.apply_force("2", "-12")
		k5.apply_force("8", "-6")
		k6.apply_force("12", "0")
	
	host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoHit5.tscn"), Vector2(0, -18))
	host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoStarH.tscn"), Vector2(0, -18))
	
	host.screen_bump(Vector2(0, 0), 8, 1)
	
	self.enable_interrupt()
	
	host.end_invulnerability()

func _tick():
	._tick()
	
	if current_tick < 14 or current_tick > 32:
		if $"%Stuff".skin == "Guillotine":
			host.global_hitlag(2)
		else:
			host.global_hitlag(1)
	else:
		if current_tick % 2 == 0:
			host.opponent.hitlag_ticks = 1

	if $"%Stuff".skin == "Aimorrago":
		if current_tick in [3, 7, 11, 15]:
			host.play_sound("SilentTreament-AI1")
