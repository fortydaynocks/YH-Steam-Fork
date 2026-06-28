extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"


func _tick():
	._tick()
	if hitted == false:
		host.opponent.hitlag_ticks += 1

#func _frame_12():
#	if name == "launcher2":
#		host.change_state("uppercut2")
