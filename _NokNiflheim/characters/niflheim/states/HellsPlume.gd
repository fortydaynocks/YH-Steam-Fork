extends CharacterState

func _frame_9():
	host.plumecd = 0
	
	
func is_usable():
	return .is_usable() and (host.currentplume == null)
