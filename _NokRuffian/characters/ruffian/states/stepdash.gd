extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

var f = 0
var dir = 0
var dash_mod = 18

func _enter():
	._enter()
	if name == "rolldodge":
		host.on_roll_started()
	

func _frame_0():
	f = host.get_facing_int()
	if host.combo_count > 0 or host.opponent.current_state().backdash_iasa == true:
		dash_mod = 25 
	else:
		dash_mod = 18
	dir = 1
	if data:
		dir = data
	else:
		dir = dir

# ANIMATION SET STUFF
	if dir.x * f < 0:
		anim_name = "StepB"
	else:
		anim_name = "StepF"

	if name == "stepdash":
		if host.combo_count <= 0:
			if dir.x * f < 0:
				anim_length = 12
			elif dir.x * f == 0:
				anim_length = 11
			elif dir.x * f == 1:
				anim_length = 13
		else:
			anim_length = 8
		if dir.x * f < 0:
			backdash_iasa = true
			beats_backdash = false
		else:
			backdash_iasa = false
			beats_backdash = true

	if name == "rolldodge":
		host.start_projectile_invulnerability()
		host.start_throw_invulnerability()
		if dir.x * f < 0:
			host.apply_force(dir.x * 10, 3)
		else:
			host.apply_force(dir.x * 15, 3)

# Wtf was I on when I made ts daw :sob:
#======================================
#	if name == "stepdash":
#		if host.combo_count <= 0:
#			anim_length = 13
#		else:
#			anim_length = 8
#	if name == "rolldodge":
#		host.start_projectile_invulnerability()
#		host.start_throw_invulnerability()
#	if dir.x * f >= 0:
#		anim_name = "StepF"
#		if name == "stepdash":
#			beats_backdash = true
#			backdash_iasa = false
#		if name == "rolldodge":
#			anim_length = 19
#	else:
#		anim_name = "StepB"
#		if name == "stepdash":
#			beats_backdash = false
#			backdash_iasa = true
#			host.add_penalty(6)
#			host.start_throw_invulnerability()
#		if name == "rolldodge":
#			if dir.x * f == 1:
#				host.apply_force(data.x * 15, 3)
#			else:
#				host.apply_force(data.x * 10, 3)
#		if name == "rolldodge":
#			anim_length = 20
func _frame_1():
	if name == "stepdash":
		match dir.x * f:
			-1:
				host.apply_force(dir.x * 14, 0)
			0:
				host.apply_force_relative(10, 3)
			1:
				host.apply_force(dir.x * dash_mod, 3)


func _frame_2():
	if name == "rolldodge":
		host.start_invulnerability()


func _frame_7():
	host.mod_vel("0.25")
	if name == "stepdash":
		host.end_throw_invulnerability()

func _frame_10():
	if name == "rolldodge":
		host.end_invulnerability()
		host.end_throw_invulnerability()
		host.end_projectile_invulnerability()

func is_usable():
	if not host.is_grounded() and name == "rolldodge":
		return .is_usable() and not host.used_air_dodge
	return .is_usable()
