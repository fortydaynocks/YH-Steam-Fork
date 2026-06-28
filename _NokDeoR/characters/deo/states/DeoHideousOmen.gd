extends "res://_NokDeoR/characters/deo/states/DeoR-State.gd"

func _exit():
	._exit()
	
	host.change_stance_to("Normal")

func _frame_9():
	if host.combo_count > 0:
		self.enable_interrupt()

func _tick():
	._tick()
	
	self.interruptible_on_opponent_turn = current_tick >= 6
