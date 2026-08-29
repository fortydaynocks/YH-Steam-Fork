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

export (int) var _c_shin_goren
export (int) var force_warp = -1
export (int) var firewalk_min = -1
export (int) var _c_skins
export (Array, AudioStream) var akuma_voicelines
export (int) var akuma_voiceline_tick = 1
export (int) var akuma_voiceline_volume = 3
export (Array, Resource) var u_voicelines
	
#	--
func _enter():
	._enter()


func _tick():
	._tick()
	
	if (hit_fighter == true and drag == true) or (force_drag == true):
		if (current_tick < end_on) and (current_tick > start_on):
			var pos = host.get_pos()
			var opos = host.opponent.get_pos()
			
			host.opponent.set_vel(0, 0)
			host.opponent.move_directly(str((pos.x + (offset_x * host.get_facing_int()) - opos.x) / drag_strength), str((pos.y - (offset_y + 18) - opos.y) / drag_strength))

	if current_tick == 0:
		var prev = self._previous_state()
		
		if prev and prev.state_name == "demonstep-OLD":
			host.set_facing(-prev.last_facing) if host.reverse_state else host.set_facing(prev.last_facing)
			#current_tick += 2	--	THE FRAME REDUCTION WAS CRACKED. AS FUCK.
			
	if $"%Stuff".skin == "Akuma" and !$"%Stuff".DORM:
		if current_tick == akuma_voiceline_tick:
			$"%Stuff".akuma_voiceline(akuma_voicelines, akuma_voiceline_volume)
	
	if $"%Stuff".skin == "UberOni":
		for vl in u_voicelines:
			if vl.tick == current_tick:
				$"%Stuff".do_voiceline(vl)
