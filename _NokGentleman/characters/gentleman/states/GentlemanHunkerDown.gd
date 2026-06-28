extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

var max_dist = 100

func is_usable():
	return .is_usable() and host.get_nearest_chair()[1] <= max_dist and host.stance != "recline"

func _frame_5():
	var target_name = host.get_nearest_chair()[0]
	
	if target_name and is_instance_valid(host.objs_map[target_name]):
		var chair = host.objs_map[target_name]
		var chair_pos = chair.get_pos()
		var chair_vel = chair.get_vel()
		
		host.set_pos(chair_pos.x, chair_pos.y)
		host.set_vel(chair_vel.x, chair_vel.y)
		
		host.play_sound("Chair")
		host.change_stance_to("Recline")
		
		chair.disable()
		
		host.afterimage(host.colors_table.MainColor, 0.2)
		
func _frame_9():
	if host.combo_count > 0:
		self.enable_interrupt()

func _tick():
	._tick()
	
	if current_tick >= 5:
		self.fallback_state = "recline"
	else:
		self.fallback_state = "Wait"
		
	self.interruptible_on_opponent_turn = current_tick >= 5
	
