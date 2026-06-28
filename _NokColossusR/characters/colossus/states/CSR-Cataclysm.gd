extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

func is_usable():
	if host.end_blade:
		if host.obj_from_name(host.end_blade).current_state().state_name in ["Float", "Spin"] and host.obj_from_name(host.end_blade).attack_primed == false:
			return .is_usable()
		
	return false

func _frame_4():
	if host.end_blade:
		host.obj_from_name(host.end_blade).prime()

func _tick():
	._tick()
