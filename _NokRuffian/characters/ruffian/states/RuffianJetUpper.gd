extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

export (bool) var force_init_effect = false
onready var hbox = $Hitbox
var weave_state = ["duck", "duck2", "cover", "exduck", "excover"]

func _enter():
	._enter()
	hbox.di_modifier = "0.50" if _previous_state_name() in weave_state else "0.0"

func _frame_0():
	hbox.block_punishable = not _previous_state_name() in weave_state
	hbox.block_cancel_allowed = not _previous_state_name() in weave_state
	hbox.knockback = "10.0" if not _previous_state_name() in weave_state else "8.5"
#	hbox.cancellable = _previous_state_name() in ["duck", "cover", "exduck"]
	
	endless = not _previous_state_name() in weave_state
	if _previous_state_name() in weave_state:
		var ranges = {
			x = Utils.int_clamp(abs(host.get_pos().x - host.opponent.get_pos().x), 0, 20),
			y = Utils.int_clamp(host.get_pos().y - host.opponent.get_pos().y, -10, 10)
		}
		host.apply_force_relative(ranges.x/2, ranges.y/2)
		hbox.damage_proration = 0

		apply_forces_no_limit = true
	else:
		apply_forces_no_limit = false
		hbox.damage_proration = 4
		host.apply_force_relative(6, 0)

func _frame_2():
	if not _previous_state_name() in weave_state:
		if host.initiative or force_init_effect == true:
			host.start_invulnerability()
	else:
		if (host.initiative or force_init_effect == true) and not host.opponent.is_grounded():
			host.start_invulnerability()

func _frame_7():
	host.reset_momentum()
	host.apply_force_relative("8", "-12")

func _frame_8():
	host.end_invulnerability()

#func _frame_14():
#	if name == "jetupper2" or not _previous_state_name() in ["duck", "cover", "exduck"] and hitted == true:
#		host.opponent.apply_force_relative(3, -6)

func _tick():
	._tick()
	if name == "jetupper2":
		hitted = true
	if _previous_state_name() in weave_state:
		if host.opponent.is_grounded():
			hbox.plus_frames = 2
		else:
			hbox.plus_frames = 0
	else:
		hbox.plus_frames = -6

func on_got_blocked():
	.on_got_blocked()
	hitted = true
#	if _previous_state_name() in ["duck", "cover", "exduck"]:
#		host.opponent.apply_force(fixed.div(host.get_vel().x, "10"), fixed.div(host.get_vel().y, "1.25"))

func _exit():
	._exit()
	host.end_invulnerability()
