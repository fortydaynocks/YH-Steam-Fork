extends CharacterState

func _frame_4():
	host.reset_momentum()

func _tick():
	if current_tick >= 4:
		host.reset_momentum()
		host.apply_force_relative(2, 16)
		host.apply_forces_no_limit()
		
	if host.is_grounded():
		host.change_state("divebombhit")
