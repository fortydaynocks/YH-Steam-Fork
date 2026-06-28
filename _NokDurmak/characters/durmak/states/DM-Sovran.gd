extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

var spawn_dist = 60
var spawn_offset = 50
var walker = preload("res://_NokDurmak/characters/durmak/summons/Walker.tscn")

func is_usable():
	var found = 0
	
	for entity in host.objs_map.values():
		if is_instance_valid(entity) and (not entity.disabled) and entity.get_owner() == host and entity.get("tag"):
			if "Walker" in entity.get("tag"):
				found += 1
	
	return .is_usable() and found < host.walker_limit

func _frame_0():
	self.interruptible_on_opponent_turn = true
	
	if data.Attack == true:
		self.interruptible_on_opponent_turn = false

func _frame_4():
	var dir = (float(data["Position"].x) / 100) * spawn_dist
	
	var obj = host.spawn_object(walker, dir + spawn_offset, 0, true, null, true)
	obj.set_grounded(false)
	obj.set_facing(host.get_facing_int())
	obj.sprite.material = host.sprite.material
	
	obj.apply_force_relative("4", "0")

	if data.Attack == true:
		obj.action_queue.append("Snuff")

func _frame_11():
	if host.combo_count > 0:
		self.enable_interrupt()
