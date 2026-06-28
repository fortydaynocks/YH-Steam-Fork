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

export (int) var _c_betrayer
export (String) var grant_eye = ""
			
#func get_last_action_text():
	#return "bruh"
			
func _tick():
	._tick()
	
	if (hit_fighter == true and drag == true) or (force_drag == true):
		if (current_tick < end_on) and (current_tick > start_on):
			var pos = host.get_pos()
			var opos = host.opponent.get_pos()
			
			host.opponent.set_vel(0, 0)
			host.opponent.move_directly(str((pos.x + (offset_x * host.get_facing_int()) - opos.x) / drag_strength), str((pos.y - (offset_y + 18) - opos.y) / drag_strength))

	if current_tick == 4 and host.eyepoints.get(grant_eye):
		host.increment_eye_points(grant_eye, 1)
