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


#	--	CHARACTER SPECIFIC
export var _c_character_specific = 0
export (int) var marks_required = 0
export (bool) var consume_mark = false

func is_usable():
	return .is_usable() and (len(host.torturemarks) >= marks_required or host.infinite_resources)

func _enter():
	._enter()
	
func _tick():
	._tick()
	
	if current_tick == 1:
		if consume_mark == true:
			host.cease_torture()
	
	if (hit_fighter == true and drag == true) or (force_drag == true):
		if (current_tick < end_on) and (current_tick > start_on):
			var pos = host.get_pos()
			var opos = host.opponent.get_pos()
			
			host.opponent.set_vel(0, 0)
			host.opponent.move_directly(str((pos.x + (offset_x * host.get_facing_int()) - opos.x) / drag_strength), str((pos.y - (offset_y + 18) - opos.y) / drag_strength))
