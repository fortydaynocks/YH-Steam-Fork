extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

onready var big_wave = preload("res://_NokBetrayer/characters/betrayer/projectiles/OrderWaveBig.tscn")
var jpos = Vector2(0, 0)

func is_usable():
	var found_judgement = 0
	
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and obj.get_owner() == host and obj.get("disabled") != true and obj.get("tag") == "EyeOfJustice":
			found_judgement += 1
	
	return .is_usable() and host.abs_asc <= 0 and found_judgement > 0

func _frame_0():
	host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTStar.tscn"), Vector2(0, -18))
	
	host.play_sound("AbsAsc1")
	host.play_sound("AbsAsc2")

func _frame_1():
	jpos = Vector2(host.get_pos().x, host.get_pos().y - 60)

func _frame_7():
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and obj.get_owner() == host and obj.get("disabled") != true and obj.get("tag") == "EyeOfJustice":
			jpos = Vector2(obj.get_pos().x, obj.get_pos().y)
			obj.disable()
			
			break
	
	host.reset_momentum()
	host.set_pos(str(jpos.x), str(jpos.y))
	host.apply_force_relative("3", "-3")
	
	host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BT-Teleport.tscn"), Vector2(0, -18))

func _frame_8():
	host.update_facing()
	
	host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BT-Teleport.tscn"), Vector2(0, -18))
	host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTMisc1.tscn"), Vector2(0, -18))
	host.screen_bump(Vector2(0, 0), 2, 0.1)
	
	if host.skin == "Munanyou":
		host.play_sound("Intro-Mu4")
		
	else:
		host.play_sound("AbsAsc3")
	
func _frame_29():
	host.abs_asc = 1
	host.apply_force_relative("-6", "-3")
	
	host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTMisc2.tscn"), Vector2(0, -18))
	host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTHit2.tscn"), Vector2(0, -18))
	host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTStar.tscn"), Vector2(60, -18))
	host.screen_bump(Vector2(0, 0), 8, 0.1)
	
	host.play_sound("AbsAsc6")
	host.play_sound("AbsAsc7")
	
	if host.skin == "Munanyou":
		host.play_sound("Mu-AbsAsc")
	
	#	--
	var proj = host.get_owner().spawn_object(big_wave, 0, -18, true, null, true)
	
	proj.set_grounded(false)
	proj.set_facing(host.get_facing_int())
	
	proj.apply_force_relative("5", "3")
	
	#	--
	host.increment_eye_points("Truth", 2, false)
	host.increment_eye_points("Might", 2, false)
	host.increment_eye_points("Order", 2, false)
	host.increment_eye_points("Shadow", 2, false)
	host.increment_eye_points("Acumen", 2, false)

func _tick():
	._tick()
	
	if current_tick in [1, 2, 3, 4, 5, 6]:
		host.apply_force_relative("1", "0")
		host.apply_grav()
	
	if current_tick >= 7 and current_tick <= 23:
		host.opponent.hitlag_ticks = 1
	
	if current_tick >= 9 and current_tick < 28:
		host.global_hitlag(2)
		
		if current_tick % 2 == 0:
			host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTMisc1.tscn"), Vector2(0, -18))
			host.screen_bump(Vector2(0, 0), 1, 0.05)
			
			if host.skin == "Munanyou":
				host.play_sound("Mu-AbsAsc2")
				host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/skins/munanyou/effects/BT-MU-LightningCharge.tscn"), Vector2(0, -18))
				
			else:
				host.play_sound("AbsAsc5")
		
	if current_tick >= 29:
		host.apply_grav()
		
	host.afterimage(Color("#006aff"), 0.1)
