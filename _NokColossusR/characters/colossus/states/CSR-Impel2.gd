extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

func _frame_0():
	host.start_invulnerability()
	host.opponent.sprite.z_index -= 1

func _frame_12():
	host.release_opponent()

func _frame_13():
	host.release_opponent()
	host.end_invulnerability()

func _tick():
	._tick()
	
	if current_tick in [9, 10, 11, 12]:
		host.global_hitlag(1)
