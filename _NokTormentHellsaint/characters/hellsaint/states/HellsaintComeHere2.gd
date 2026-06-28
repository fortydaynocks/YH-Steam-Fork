extends ThrowState

func _exit():
	._exit()
	
	host.change_stance_to("Normal")

func _enter():
	._enter()
	
	host.start_invulnerability()
	host.exhausted_moves = []

func _frame_1():
	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Laugh1")
		
		$"%Stuff".do_text($"%Stuff".choose_text("ComeHere", $"%Stuff".quotes_cml))
		
	else:
		$"%Stuff".do_text($"%Stuff".choose_text("ComeHere", $"%Stuff".quotes_tor))

func _frame_30():
	
	if $"%Stuff".skin == "Camila":
		host.play_sound("tastelessfanghit")

func _tick():
	._tick()
	
	if current_tick <= 18 or current_tick > 30:
		host.global_hitlag(1)

	if current_tick in [14, 18, 22, 26]:
		if (not $"%Stuff".skin == "Camila") or current_tick == 14:
			host.play_sound("comehere2_spin")
