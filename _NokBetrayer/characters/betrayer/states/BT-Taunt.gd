extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

func _frame_1():
	host.play_sound("TauntSpin")

func _frame_8():
	
	host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTStar2.tscn"), Vector2(14, -43))

	if host.skin == "Munanyou":
		host.play_sound("Mu-Taunt")
		host.play_sound("Mu-Unsheath")
		
	else:
		host.play_sound("TauntSwing")

func _frame_23():
	host.apply_force_relative("-2", "0")
	
	host.gain_super_meter(100)
	host.judgepoints.Value += 1
	
	host.play_sound("TauntCatch")
	host.play_sound("TauntCatch2")
	host.play_sound("TauntCatch3")
	
	host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTStar.tscn"), Vector2(14, -43))
	
func _tick():
	._tick()
	
	if current_tick >= 8 and current_tick < 24:
		host.global_hitlag(1)
	
	if current_tick in [8, 12, 16, 20] and host.skin != "Munanyou":
		host.play_sound("TauntSpin")
