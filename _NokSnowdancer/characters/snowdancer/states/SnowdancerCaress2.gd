extends ThrowState

func _frame_10():
	host.reset_momentum()
	host.apply_force_relative("9", "-9")

func _tick():
	._tick()
	
	if current_tick in [1, 2, 3, 4]:
		host.global_hitlag(1)

	if current_tick % 2 == 0:
		host.afterimage(Color(0.8, 0.86, 0.99, 0.25), 0.25)
