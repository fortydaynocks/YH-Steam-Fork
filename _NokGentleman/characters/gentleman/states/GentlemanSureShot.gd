extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

onready var hbox = $"%HitboxSureShot"
onready var hbox2 = $"%HitboxSureShot2"
var chase = 7
var shoot_range = 200

var target = null

func is_usable():
	var found_marks = 0
	
	for obj in host.objs_map.values():
		if is_instance_valid(obj) and obj.disabled != true and obj.get_owner() == host and obj.get("tag") == "Mark":
			found_marks += 1
	
	return .is_usable() and host.has_item("Countermeasures") and found_marks > 0

func _frame_0():
	target = null
	
	var choice_dir = xy_to_dir(data["Aim"].x, data["Aim"].y, str(shoot_range))
	var choice_pos = Vector2(host.get_pos().x + int(choice_dir.x), host.get_pos().y + int(choice_dir.y))
	
	var last_mark = null
	var last_dist2mark = INF
	
	for mark in host.objs_map.values():
		if is_instance_valid(mark) and mark.disabled != true and mark.get_owner() == host and mark.get("tag") == "Mark":
			var dist2mark = Vector2(mark.get_pos().x - choice_pos.x, mark.get_pos().y - choice_pos.y).length()
			
			if dist2mark < last_dist2mark:
				last_mark = mark
				last_dist2mark = dist2mark
				
	if last_mark:
		target = last_mark.obj_name
		
		if (last_mark.get_pos().x - host.get_pos().x) * host.get_facing_int() < 0:
			host.set_facing(-host.get_facing_int())
			
	if data["Offload"] == true and target:
		var furthest_agent = null
		var last_dist2opp = 0
		
		for agent in host.objs_map.values():
			if is_instance_valid(agent) and agent.disabled != true and agent.get_owner() == host and agent.get("tag") == "Agent":
				if agent.current_state().get("interruptible") == true:
					var dist2opp = Vector2(agent.get_pos().x - host.opponent.get_pos().x, agent.get_pos().y - host.opponent.get_pos().x).length()
					
					if dist2opp > last_dist2opp:
						furthest_agent = agent
						last_dist2opp = dist2opp
						
		if furthest_agent:
			furthest_agent.change_state("sureshot", {"target": target})
			
		host.change_state("Wait")
		return
	
	#	--
	if host.stance == "Recline":
		self.reclining_state = true
		self.fallback_state = "recline"
		
		self.apply_custom_x_fric = true
		self.apply_custom_y_fric = true
		
		host.change_stance_to("Recline")
		
	else:
		self.reclining_state = false
		self.fallback_state = "Wait"
		
		self.apply_custom_x_fric = false
		self.apply_custom_y_fric = false

func _frame_1():
	if host.has_item("Money Shot"):
		host.use_item("Money Shot")
	else:
		host.use_item("Countermeasures")
	
	if host.stance == "Recline":
		anim_name = "rc_sureshot"
		
	else:
		anim_name = "sureshot"
		
	if host.previous_state():
		if host.previous_state().state_name in ["sureshot"]:
			current_tick = 3

func _frame_7():
	var mark = host.objs_map.get(target)
	if is_instance_valid(hbox) and is_instance_valid(hbox2) and is_instance_valid(mark) and mark.disabled != true:
		var pos = host.get_pos()
		var mark_pos = mark.get_pos()
		
		hbox.to_x = (mark_pos.x - (pos.x + hbox.x)) * host.get_facing_int()
		hbox.to_y = mark_pos.y - (pos.y + hbox.y)
		
		hbox2.x = (mark_pos.x - (pos.x)) * host.get_facing_int()
		hbox2.y = mark_pos.y - (pos.y)
		
		var point_vector = Vector2(mark_pos.x - (pos.x + 23), mark_pos.y - (pos.y - 27))
		
		host.spawn_particle_effect_relative(preload("res://_NokGentleman/characters/gentleman/effects/GM_Gunshot.tscn"), Vector2(23, -27), point_vector)
		mark.spawn_particle_effect_relative(preload("res://_NokGentleman/characters/gentleman/effects/GM_HitGun1.tscn"), Vector2(0, 0))
		mark.disable()

#	--
func _tick():
	._tick()
