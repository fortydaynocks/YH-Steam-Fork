extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

var max_dist = 50

func is_usable():
	return .is_usable() and (host.stance == "Recline" or host.get_nearest_chair()[1] <= max_dist)
	
func _frame_1():
	var target_name = host.get_nearest_chair()[0]
	
	if target_name and is_instance_valid(host.objs_map[target_name]):
		var chair = host.objs_map[target_name]
		chair.disable()
