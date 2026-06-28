extends CharacterState

#	--	DRAG SCRIPT
export var _c_drag = 0
export (bool) var drag = false
export (int) var offset_x = 0
export (int) var offset_y = 0
export (int) var start_on = 1
export (int) var end_on = 1
export (float) var drag_strength = 2.5
export (bool) var force_drag = false

#	--
export (int) var _c_deo
export (float) var air_correction_x = 0.0
export (float) var air_correction_y = 0.0
export (int) var air_correction_frame = 0
export (String) var stand_requirement = "Any"
export (bool) var stand_action_state = true

export (Array, Resource) var voicelines
export (Array, AudioStream) var voicelines2
export (int) var voiceline_tick = 1

func _tick():
	._tick()
	
	if current_tick >= 1 and current_tick == air_correction_frame:
		if host.is_grounded() == false:
			var vec = Vector2(host.opponent.get_pos().x - host.get_pos().x, host.opponent.get_pos().y - host.get_pos().y).normalized()
			host.apply_force(str(vec.x * air_correction_x), str(vec.y * air_correction_y))
	
	if (hit_fighter == true and drag == true) or (force_drag == true):
		if (current_tick < end_on) and (current_tick > start_on):
			var pos = host.get_pos()
			var opos = host.opponent.get_pos()
			
			host.opponent.set_vel(0, 0)
			host.opponent.move_directly(str((pos.x + (offset_x * host.get_facing_int()) - opos.x) / drag_strength), str((pos.y - (offset_y + 18) - opos.y) / drag_strength))

	#	--
	for vl in voicelines:
		if vl.tick == current_tick:
			host.play_voiceline(vl)
			
	if current_tick == voiceline_tick:
		if len(voicelines2) > 0:
			host.voiceline(host.randi_choice(voicelines2))
