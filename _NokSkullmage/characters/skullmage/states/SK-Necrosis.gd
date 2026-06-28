extends "res://_NokSkullmage/characters/skullmage/states/SK-State.gd"

	
func _frame_3():
	if data.get("Entity") and data.get("Action"):
		var entity = host.obj_from_name(data.Entity)
		
		if is_instance_valid(entity):
			entity.queue_action(data.Action)
