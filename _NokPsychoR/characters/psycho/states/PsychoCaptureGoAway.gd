extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

func _enter():
	._enter()
	
	host.opponent.change_state("Grabbed")
	host.start_invulnerability()
	
func _frame_8():
	host.end_invulnerability()
	host.release_opponent()
