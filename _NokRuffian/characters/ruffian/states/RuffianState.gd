extends CharacterState

#	--	DRAG SCRIPT (USED)
export var _c_Drag_Properties = 0
export var drag_pos = {
	x = 0,
	y = 0,
}
export var end_on_frame = 0
export var drag_weaken_modifier = 2

#	--	DRAG SCRIPT (OUTDATED)


export var _c_drag = 0
export (bool) var drag_on_block = false
export (bool) var drag = false
export (int) var offset_x = 0
export (int) var offset_y = 0
export (int) var start_on = 1
export (int) var end_on = 1
export (float) var drag_strength = 2.5
export (bool) var force_drag = false

export var _c_ruffian_settings = 0
export (bool) var ex = false
export (bool) var super = false
export (bool) var cc = true

export var _c_weave_settings = 0
export var weave_startup_reduction = 0

var hitted = false
var blocked = false
var tpf = 0

func _enter():
	._enter()
	tpf = ticks_per_frame
	blocked = false
	if force_drag == true:
		hitted = true
	else:
		hitted = false



func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)
	if obj is Fighter:
		hitted = true

func _tick():
	._tick()

# adapts the variables from the wack drag system Nok used into the modern one
	drag_weaken_modifier = int(drag_strength)
	drag_pos.x = offset_x
	drag_pos.y = offset_y
	end_on_frame = end_on

	if name == "quickmixgrab":
		host.start_invulnerability()

	var pos = host.get_pos()
	var opos = host.opponent.get_pos()

	if current_tick == 1:
		if _previous_state_name() in ["duck", "exduck", "cover"]:
			current_tick += weave_startup_reduction
	
	if current_tick % 3 == 0:
		if ex == true:
			host.trail("EX")
		elif super == true:
			host.trail("SUPER")

	if hitted == true and (current_tick < end_on_frame):
		var opp_local = host.obj_local_center(host.opponent)
		var self_local = host.opponent.obj_local_center(host)
		var base_offset = {
			x = 0,
#			y = host.hurtbox.height/2 - host.opponent.hurtbox.height/2,
			y = self_local.y + opp_local.y,
		}
		var final_drag = {
			x = ((pos.x - opos.x) + ((drag_pos.x + base_offset.x) * host.get_facing_int()))/drag_weaken_modifier,
			y = ((pos.y - opos.y) + ((drag_pos.y + base_offset.y)))/drag_weaken_modifier,
		}
		host.opponent.move_directly(final_drag.x * 1 if drag_pos.x >= 0 else -1, final_drag.y)
		host.opponent.set_vel(host.get_vel().x, host.get_vel().y)
		if blocked == false:
			host.opponent.hitlag_ticks += 1
#		host.opponent.set_vel(host.get_vel().x, host.get_vel().y)
		

#	if (hitted == true == true and drag == true) or (force_drag == true):
#		if (current_tick < end_on) and (current_tick > start_on):
#
#
#			if name in ["jetupper", "jetupper2"]:
#				host.opponent.set_vel("0", "0")
#			else:
#				host.opponent.set_vel(host.get_vel().x, host.get_vel().y)
#			host.opponent.move_directly(str((pos.x + (offset_x * host.get_facing_int()) - opos.x) / drag_strength), str(((pos.y - opos.y) - host.opponent.hurtbox.height) + offset_y) / drag_strength)


	#	--	SKIN SOUNDS
	
	if host.skin == 1 and host.previous_state():
		
		
		#	//	MAGIC SEQENCE
	
		if host.current_state().state_name in ["jetupper", "jetupper2"]:
			if host.previous_state().state_name in ["uppercut", "uppercutair", "uppercut2"]:
				match current_tick:
					1:	
						if host.magic_series == 2:
							host.magic_series = 3
							host.global_hitlag(3, true)
							host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00014.wav"), -6)
						else:
							host.magic_series = 0
							host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00011.wav"), -6)
			else:
				match current_tick:
					6:	
						host.magic_series = 0
						host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00011.wav"), -6)
		
		if host.current_state().state_name in ["uppercut", "uppercutair", "uppercut2"]:
			if host.previous_state().state_name in ["launcher", "launcher2"]:
				match current_tick:
					1:	
						if host.magic_series == 1:
							host.magic_series = 2
							host.global_hitlag(3, true)
							host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00013.wav"), -6)
						else:
							host.magic_series = 0
							host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00006.wav"), -6)
			else:
				match current_tick:
					1:
						host.magic_series = 0
						host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00006.wav"), -6)
		
		if host.current_state().state_name in ["launcher", "launcher2"]:
			match current_tick:
				8:
					host.magic_series = 1
					host.global_hitlag(3, true)
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00012.wav"), -6)
		
		#	//	OTHER SOUNDS	
		
		if host.current_state().state_name in ["fiercepunch", "fiercepunchair", "brashhand", "brasherhand"]:
			match current_tick:
				1:
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00005.wav"), -6)
		
		if host.current_state().state_name in ["shorthook", "shorthookair", "exduck", "friendlyhandshake"]:
			match current_tick:
				1:
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00010.wav"), -6)
				
		if host.current_state().state_name in ["rusteddust", "rustierdust"]:
			match current_tick:
				1:
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00006.wav"), -6)
				
		if host.current_state().state_name in ["machinegunblow", "machinegunblowair"]:
			match current_tick:
				8, 14:
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00005.wav"), -6)
				24:
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00006.wav"), -6)
		
		if host.current_state().state_name in ["drivethrough", "corkscrewblow"]:
			match current_tick:
				1:	
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00007.wav"), -6)
					
		if host.current_state().state_name in ["drivethrough"]:
			match current_tick:
				1:	
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00007.wav"), -6)

		if host.current_state().state_name in ["exmachinegunblow"]:
			match current_tick:
				8, 14, 20, 26:
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00005.wav"), -6)
				34, 44:
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00006.wav"), -6)
					
		if host.current_state().state_name in ["machinegrab"]:
			match current_tick:
				4, 10, 16, 22:
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00005.wav"), -6)
				30, 40:
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00006.wav"), -6)			
					
		if host.current_state().state_name in ["blastchain"]:
			match current_tick:
				4:
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00012.wav"), -6)
				20:
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00013.wav"), -6)
				36:
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00015.wav"), -3)
					
		if host.current_state().state_name in ["rollingthunder"]:
			match current_tick:
#				1:
#					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00015.wav"), -6)
				9, 17:
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00008_clipped.wav"), -6)
				28:
					host.voiceline(preload("res://_NokRuffian/characters/ruffian/skins/ruffian_true/sounds/PL04_00015.wav"), -6)

func on_got_blocked():
	.on_got_blocked()
	if drag_on_block == true:
		hitted = true
		blocked = true
