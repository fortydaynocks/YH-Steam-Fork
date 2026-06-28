extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _frame_1():
	host.play_sound("awaken")
	host.play_sound("super3")
	
func _frame_3():
	if host.opponent.got_parried == true:
		self.enable_interrupt()

func _frame_7():
	if host.combo_count >= 1:
		self.enable_interrupt()
