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

export (int) var _c_Venerator
export (bool) var super_afterimage = false
export (int) var blessing_cost = 0
export (int) var blessing_drain = 0
export (bool) var blessing_effect = false

#	========================================================================== >
func is_usable():
	return .is_usable() and host.blessings.value >= blessing_cost

func _enter():
	._enter()
	
	
func _tick():
	._tick()
	
	if current_tick == 0:
		if blessing_cost > 0:
			host.gain_blessing(-blessing_drain)
			
		if blessing_effect:
			host.play_sound("BlessingAttack")
			host.play_sound("BlessingAttack2")
			host.play_sound("BlessingAttack3")
				
			host.global_hitlag(6)
				
			host.spawn_particle_effect_relative(
				preload("res://_NokVenerator/venerator/effects/VN-FlashDark.tscn"),
				Vector2(0, -18))
	
	if (hit_fighter == true and drag == true) or (force_drag == true):
		if (current_tick < end_on) and (current_tick > start_on):
			var pos = host.get_pos()
			var opos = host.opponent.get_pos()
			
			host.opponent.set_vel(0, 0)
			host.opponent.move_directly(str((pos.x + (offset_x * host.get_facing_int()) - opos.x) / drag_strength), str(((pos.y + offset_y) - opos.y) / drag_strength))
	
	if super_afterimage:
		host.afterimage(Color("#f0b541"), 0.05)
		
	elif blessing_effect:
		host.afterimage(Color("#ff8933"), 0.05)
