extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

func _frame_0():
	host.reset_momentum()
	host.apply_force_relative("8", "0")
	
	#	--
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and not obj.disabled:
			if obj.get("tag") == "LodgedCleaver":
				obj.disable()
	
func _tick():
	._tick()
	
	if current_tick < 13:
		host.global_hitlag(1)
