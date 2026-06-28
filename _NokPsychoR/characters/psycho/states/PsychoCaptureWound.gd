extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

func _enter():
	._enter()
	
	host.opponent.change_state("Grabbed")
	host.start_invulnerability()
	
	if host.previous_state():
		if not host.previous_state().state_name in [self.state_name]:
			host.play_sound("WoundSwing")
	
func _frame_7():
	host.release_opponent()

func _frame_8():
	host.opponent.change_state("Grabbed")
