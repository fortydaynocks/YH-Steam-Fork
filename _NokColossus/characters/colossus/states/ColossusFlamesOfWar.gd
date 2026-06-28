extends "res://_NokColossus/characters/colossus/states/ColossusState.gd"

func _tick():
	._tick()
	
	self.interruptible_on_opponent_turn = (current_tick >= 5)
	host.global_hitlag(1)
