extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

func _enter():
	._enter()
	if host.opponent.current_state().get("IS_NEW_PARRY"):
		if host.opponent.current_state().push == true:
			host.add_pushback("-6.5")
			host.opponent.add_pushback("-6.5")
#	if host.combo_count <= 0:
#		pass
	host.weaving = false
	if host.combo_count > 0:
		anim_length = 5
	else:
		anim_length = 9

func _frame_0():
	if "brash" in _previous_state_name():
		current_tick += 4

func _exit():
	._exit()
	host.change_stance_to("Normal")
