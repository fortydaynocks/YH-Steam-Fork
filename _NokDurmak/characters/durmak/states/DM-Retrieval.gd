extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

var max_dist = 300

func is_usable():
	var usable = false
	
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and not obj.disabled:
			if obj.get("tag") == "LodgedCleaver":
				usable = true
	
	return .is_usable() and usable and int(host.distance_to(host.opponent)) <= max_dist

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	
	if current_tick <= 9:
		host.apply_force_relative("0.5", "0")
		
	if current_tick in [9, 10, 11]:
		var lpos = lerp(Vector2(pos.x, pos.y), Vector2(opos.x, opos.y), 0.5)
		
		host.set_pos(str(lpos.x), str(lpos.y))
		
	if current_tick == 12:
		host.update_facing()
		
		host.set_pos(str(opos.x), str(opos.y))
		host.move_directly_relative("-20", "0")
