extends CharacterState

func _frame_4():
	if host.currentplume != null:
		var pos = host.currentplume.get_pos()
		host.set_pos(pos.x, pos.y + 18)
		host.currentplume.disable()
	
func is_usable():
	return .is_usable() and (host.currentplume != null)
