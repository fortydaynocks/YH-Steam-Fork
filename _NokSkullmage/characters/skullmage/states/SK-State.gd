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

export (int) var _c_skullmage
export (bool) var summon_state = false
export (PackedScene) var summon_entity
export (String, MULTILINE) var summon_description = ""
export (bool) var ignore_link = false
export (Array, PackedScene) var entity_list
			
func _enter():
	._enter()
	
	if summon_state == true:
		#print(host.previous_state().feinted_last)
		
		host.feinting = host.previous_state() and host.previous_state().feinting
			
func _tick():
	._tick()
	
	if (hit_fighter == true and drag == true) or (force_drag == true):
		if (current_tick < end_on) and (current_tick > start_on):
			var pos = host.get_pos()
			var opos = host.opponent.get_pos()
			
			host.opponent.set_vel(0, 0)
			host.opponent.move_directly(str((pos.x + (offset_x * host.get_facing_int()) - opos.x) / drag_strength), str((pos.y - (offset_y + 18) - opos.y) / drag_strength))
