extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

func _enter():
	._enter()
	beats_backdash = true

func _frame_1():
	host.set_vel_relative("-10", host.get_vel().y)

func _tick():
	._tick()
	anim_length = 22 if host.combo_count <= 0 else 15
#	var tpf = ticks_per_frame
	if current_tick == 2 * tpf:
		host.set_vel("0", host.get_vel().y)
	if current_tick == 3 * tpf:
		host.play_sound("Coolsound")
		host.play_sound("Whiff4")
	if current_tick in range(3 * tpf, (8 * tpf) - 1):
		host.set_vel_relative("30", host.get_vel().y)
	if current_tick == 8 * tpf:
		host.mod_vel("0.10")
#	if current_tick == 9 * tpf:
#		host.reset_momentum()
#		host.set_vel("0", host.get_vel().y)
