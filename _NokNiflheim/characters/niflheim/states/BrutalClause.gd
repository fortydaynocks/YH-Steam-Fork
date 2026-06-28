extends CharacterState
		
func _frame_2():
	if host.initiative:
		host.start_invulnerability()
		
func _frame_6():
	host.start_invulnerability()
	
func _frame_9():
	host.end_invulnerability()
		
func _frame_5():
	host.reset_momentum()

func _on_got_hit():
	._on_got_hit()
