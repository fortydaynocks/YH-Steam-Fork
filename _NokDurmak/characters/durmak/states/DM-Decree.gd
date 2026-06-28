extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

func is_usable():
	var found = 0
	
	for entity in host.objs_map.values():
		if is_instance_valid(entity) and (not entity.disabled) and entity.get_owner() == host and entity.get("tag"):
			if "Walker" in entity.get("tag"):
				found += 1
	
	return .is_usable() and found > 0

func _frame_3():
	if data.get("Entity") and data.get("Action"):
		var entity = host.objs_map.get(data.Entity)
		
		if entity:
			entity.queue_action(data.Action)

func _frame_7():
	if host.combo_count > 0:
		self.enable_interrupt()
