extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var target_pos = null

func is_usable():
	var found_swirls = 0
	
	for swirl in host.objs_map.values():
		if is_instance_valid(swirl) and swirl.disabled != true and swirl.get_owner() == host and swirl.get("tag") == "Swirl":
			found_swirls += 1
			
	return .is_usable() and found_swirls > 0

#	--
func _frame_6():
	host.start_invulnerability()

func _tick():
	._tick()
	
	if current_tick in [6, 7, 8]:
		pass
		
		
	#if current_tick in [1, 2, 3, 4, 5, 6]:
	#	host.global_hitlag(1)
	
	#if current_tick in [6, 7, 8]:
		#host.move_directly_relative("50", "0")
		#host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18), Vector2(host.get_facing_int(), 0))
		
		#var dist = (float(data["Distance"].x) / 100)
		#host.move_directly_relative("0", str(dist  * 12))
		#host.apply_force_relative("0", str(dist * 3))
		
	#if current_tick in [data["Flame1"], data["Flame2"]]:
	#	host.spawn_object(host.objs_table.GokaFlame, 0, -18, true, null, true)
		
	if current_tick >= 6:
		host._create_speed_after_image(Color("cc2f7b"), 0.1)
	
