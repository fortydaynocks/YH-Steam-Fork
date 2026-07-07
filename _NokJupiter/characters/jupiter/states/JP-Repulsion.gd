extends "res://_NokJupiter/characters/jupiter/states/JupiterState.gd"

var push_dist = 75

var weak_push_force = 0.5
var push_force = 1

func _tick():
	._tick()
	
	for nearby_object in host.objs_map.values():
		if is_instance_valid(nearby_object) and nearby_object.disabled != true and nearby_object != host:
			if int(host.distance_to(nearby_object)) <= push_dist:
				if nearby_object.get_owner() == host and nearby_object.get("tag") == "Neuron":
					
					var dir = xy_to_dir(data.x, data.y, str(push_force))
					nearby_object.apply_force(dir.x, dir.y)
					
				else:
					
					var dir = xy_to_dir(data.x, data.y, str(weak_push_force))
					nearby_object.apply_force(dir.x, dir.y)
					
