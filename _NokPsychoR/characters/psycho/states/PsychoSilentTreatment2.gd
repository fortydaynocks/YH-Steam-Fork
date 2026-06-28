extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

func _enter():
	._enter()
	
	host.start_invulnerability()

func _exit():
	._exit()
	
	if $"%Stuff".skin == "Aimorrago":
		$"%AI-Halo".scale.x = 1

func _frame_11():
	var opos = host.opponent.get_pos()
	var ofac = host.opponent.get_facing_int()
	
	host.set_pos(opos.x - (ofac * 25), opos.y)
	host.apply_force_relative("-6", "0")

func _frame_13():
	if $"%Stuff".skin == "Aimorrago":
		$"%AI-Halo".scale.x = -1
		$"%Stuff".do_text(host.randi_choice($"%Stuff".ai_quotes.SilentTreatment))
		host.play_sound("Insanity1")
		
	else:
		if not $"%Stuff".skin == "Guillotine": host.play_sound("InsanityLaugh")
	
	host.play_sound("SilentTreatment2")
	

func _frame_44():
	if $"%Stuff".skin == "Aimorrago":
		host.play_sound("AISound1")

func _tick():
	._tick()

	if current_tick > 13 and current_tick < 25:
		host.global_hitlag(2)
		
	if $"%Stuff".skin == "Aimorrago":
		if current_tick in [23, 25, 27, 29, 31, 33, 35, 37, 39, 41]:
			host.play_sound("SilentTreament-AI1")
