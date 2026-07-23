extends "res://_NokSickness/characters/sickness/states/SC-State.gd"

func _frame_22():
	host.release_opponent()
	
func _tick():
	._tick()
	
	host.opponent.rumble(0.25, 4)
	
	if current_tick in [15, 16, 17, 18, 19, 20]:
		host.global_hitlag(2)
