extends "res://_NokSilo/characters/silo/states/SiloState.gd"

func is_usable():
	var can_use = true
	
	for obj in host.objs_map.values():
		if is_instance_valid(obj):
			if obj.get("mynameisthefuckingdreadwheelohyeah") == true:
				can_use = false
		
	return .is_usable() and can_use == true
	
func _frame_1():
	host.stress -= 0.05
	
func _frame_6():
	var obj = host.spawn_object(host.objs_table.DreadWheel, 18 * host.get_facing_int(), -18, false, null, true)
	obj.apply_force(str(4 * host.get_facing_int()), "0")

	host.afterimage(Color.red, 0.1)
