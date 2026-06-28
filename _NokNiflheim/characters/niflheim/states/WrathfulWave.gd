extends CharacterState

func _frame_16():
	host.wavecd = 0
	
	
func is_usable():
	return .is_usable() and (host.wave == true)
