extends "res://_NokDeoR/characters/deo/states/DeoR-State.gd"

func get_stacked_timezone():
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and (not obj.disabled) and obj.get_owner() == host:
			if obj.get("tag") == "Timezone" and obj.get("stacked") == true:
				return obj.obj_name
	

#	--
func is_usable():
	return .is_usable() and get_stacked_timezone()

func _exit():
	._exit()
	
	if current_tick >= 14:
		host.spawn_particle_effect_relative(preload("res://_NokDeoR/characters/deo/effects/DEOR-StandCallback.tscn"),
		Vector2(8, -20),
		Vector2(host.get_facing_int(), 0))

func _frame_0():
	host.unsummon_stand()
		
func _frame_14():
	host.play_sound("Timestop")
	
func _frame_22():
	host.voiceline(preload("res://_NokDeoR/characters/deo/voicelines/va_timehasstopped.wav"))

func _tick():
	._tick()
	
	var zone = get_stacked_timezone()
	
	if zone:
		var obj = host.obj_from_name(zone)
		
		if current_tick == 1:
			obj.start_invulnerability()
			obj.hitlag_ticks = 13
			obj.spawn_particle_effect_relative(preload("res://_NokDeoR/characters/deo/effects/DEOR-KnifeShine.tscn"))
			
		if current_tick == 13:
			obj.level_up(6)
			obj.change_state("Activate2")
	
	#	--
	if current_tick >= 10 and current_tick < 22:
		host.global_hitlag(2)
	else:
		host.global_hitlag(1)
