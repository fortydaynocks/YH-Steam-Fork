extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"


func _frame_0():
	hitted = true
#	if name == "jetupper2":
#		host.apply_force_relative(6, 0)
#
#func _frame_7():
#	if name != "jetupper2":
#		host.reset_momentum()
#		host.apply_force_relative("8", "-12")
#
func _frame_9():
	if name != "jetupper2":
		host.change_state("jetupper2")
