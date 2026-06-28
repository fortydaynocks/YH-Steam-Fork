extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

func _frame_15():
	if self.was_blocked:
		self.enable_interrupt()

func _tick():
	._tick()
	
	if current_tick in [17, 18, 19, 20]:
		host.global_hitlag(2)

	self.next_state_on_hold = current_tick >= 20
	self.next_state_on_hold_on_opponent_turn = current_tick >= 20
