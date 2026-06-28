extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

func _enter():
	._enter()
	host.armored = false

#func _frame_0():
#	if host.initiative:
#		host.start_throw_invulnerability()

func _frame_2():
	if host.reverse_state:
		host.apply_force_relative("-12", "0")
	else:
		host.apply_force_relative("-17", "0")


func _frame_3():
	if host.combo_count > 0:
		current_tick = 7
		host.opponent.hitlag_ticks += 3

func _frame_4():
	if "ex" in name:
		if host.initiative:
			host.armored = true
			host.has_hyper_armor = true

func _frame_8():
#	host.end_throw_invulnerability()
	host.armored = false
	host.has_hyper_armor = false

	host.apply_force_relative("24", "0")
	if "ex" in name:
		host.apply_force_relative("6", "0")
	
func _exit():
	._exit()
	if host.opponent.combo_count < 1:
		host.reset_momentum()
		host.apply_force_relative("20", "0")
		host.apply_forces_no_limit()
		
	host.change_stance_to("Normal")
