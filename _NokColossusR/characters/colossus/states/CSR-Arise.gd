extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

func is_usable():
	if host.end_blade:
		if host.obj_from_name(host.end_blade).current_state().state_name in ["Slam"]:
			return .is_usable()
		
	return false

func _frame_5():
	if host.end_blade:
		 host.obj_from_name(host.end_blade).change_state("Float")

func _tick():
	._tick()
	
	if current_tick >= 5:
		host.global_hitlag(1)
