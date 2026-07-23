extends "res://_NokSickness/characters/sickness/states/SC-State.gd"

func _tick():
	._tick()

	if current_tick in [8, 9, 10, 11, 12]:
		if host.opponent.invulnerable or host.opponent.current_state() is ParryState:
			host.change_state("ph-surprise")
