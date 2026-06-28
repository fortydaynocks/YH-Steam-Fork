extends ThrowState

func _tick():
	if current_tick < 20:
		host.opponent.take_damage(2, 2)
