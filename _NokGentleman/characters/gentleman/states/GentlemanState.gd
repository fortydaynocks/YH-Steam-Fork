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
export (int) var _c_gentleman
export (Array, String) var needs_items
export (Array, String) var consume_items
export (bool) var recline_state = false
export (bool) var reclining_state = false
export (bool) var retain_recline = false
export (String) var recline_animation = ""
export (bool) var carry_over_recline = false

func is_usable():
	if len(needs_items) > 0:
		return .is_usable() and host.has_items(needs_items)
	
	return .is_usable()

func _enter():
	._enter()
	
	if len(consume_items) > 0:
		for item in consume_items:
			host.use_item(item)
	
	if retain_recline == true:
		if host.previous_state() and host.previous_state().get("recline_state") == true:
			host.change_stance_to("Recline")
	
	if host.stance == "Recline" and recline_animation != "":
		self.anim_name = recline_animation
			
func _tick():
	._tick()
	
	if (hit_fighter == true and drag == true) or (force_drag == true):
		if (current_tick < end_on) and (current_tick > start_on):
			var pos = host.get_pos()
			var opos = host.opponent.get_pos()
			
			host.opponent.set_vel(0, 0)
			host.opponent.move_directly(str((pos.x + (offset_x * host.get_facing_int()) - opos.x) / drag_strength), str((pos.y - (offset_y + 18) - opos.y) / drag_strength))
