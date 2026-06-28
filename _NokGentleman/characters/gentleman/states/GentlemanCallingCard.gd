extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func is_usable():
	var count = 0
	
	for agent in host.objs_map.values():
		if is_instance_valid(agent) and agent.disabled != true and agent.get_owner() == host and agent.get("tag") in ["Agent"]:
			count += 1
			
	return .is_usable() and count < 2

func _frame_3():
	var dist = (float(data.x) / 100) * 120
	var agent = host.spawn_object(host.objs_table.Agent, dist, 0, true, null, true)
	agent.set_grounded(false)
	agent.set_facing(1 if host.opponent.get_pos().x > agent.get_pos().x else -1)
	
	agent.sprite.material = host.sprite.material
