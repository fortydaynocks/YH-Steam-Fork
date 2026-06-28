extends "res://_NokSilo/characters/silo/states/SiloState.gd"

func is_usable():
	return .is_usable() and host.stress >= 1

func _enter():
	host.play_sound("Super3")
	host.play_sound("InsanityWarning")

func _frame_3():
	host.start_invulnerability()

func _frame_35():
	host.insanity = true
	
	host.play_sound("Insanity")
	host.play_sound("Insanity2")
	host.play_sound("Insanity3")
	host.play_sound("Insanity4")
	host.play_sound("InsanityLaugh")
	
	host.screen_bump(Vector2(0, 0), 8, 1)
	host.end_invulnerability()

func _tick():
	._tick()
	
	if current_tick < 35:
		host.global_hitlag(1)
	
		if current_tick % 2 == 0:
			host.opponent.hitlag_ticks = 1
