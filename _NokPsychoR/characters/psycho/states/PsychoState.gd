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

export var _c_psycho = 0
export (bool) var grant_scars = true
export (bool) var grant_scars_on_block = true

func _enter():
	._enter()

func _tick():
	._tick()
	
	if drag == true and (hit_fighter == true or force_drag == true):
		if (current_tick < end_on) and (current_tick > start_on):
			var pos = host.get_pos()
			var opos = host.opponent.get_pos()
			
			host.opponent.set_vel(0, 0)
			host.opponent.move_directly(str((pos.x + (offset_x * host.get_facing_int()) - opos.x) / drag_strength), str((pos.y - (offset_y + 18) - opos.y) / drag_strength))

	#	--	SCAR GAIN
	if current_tick == 1 and self.show_in_menu == true and self.grant_scars == true:
		match self.type:
			1:
				host.scars += 1
			2:
				host.scars += 2
			3:
				host.scars += 3

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
			
	if not "NoWounds" in hitbox.editor_description:
		host.wounds += 1
