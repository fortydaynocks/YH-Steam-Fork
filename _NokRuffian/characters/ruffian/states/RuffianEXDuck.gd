extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"


func _enter():
	._enter()
	host.armored = false
	if data:
		if data == true:
			host.change_state("excover")
	if host.combo_count > 0:
		anim_length = 8
	else:
		anim_length = 12


func _frame_1():
	if not host.reverse_state:
		host.apply_force_relative((abs(host.get_pos().x - host.opponent.get_pos().x)/5) + 6, 2)
	else:
		host.apply_force_relative((abs(host.get_pos().x - host.opponent.get_pos().x)/15) + 4, 2)
func _frame_4():
	if host.initiative:
		host.armored = true
		host.has_hyper_armor = true
func _frame_8():
	host.armored = false
	host.has_hyper_armor = false



func _exit():
	._exit()
	
	host.change_stance_to("Normal")

#func is_usable():
#	if name == "exduck":
#		reversible = host.combo_count > 0
#		return .is_usable()
#	return .is_usable()
