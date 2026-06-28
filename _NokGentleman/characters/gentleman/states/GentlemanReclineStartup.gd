extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func _frame_1():
	host.change_stance_to("Recline")
	
	self.interruptible_on_opponent_turn = host.opponent.current_state() is ParryState

func _frame_7():
	if host.combo_count > 0:
		self.enable_interrupt()

func _frame_12():
	if host.is_grounded() == true:
		host.spawn_particle_effect_relative(host.vfx_table.Landing, Vector2(0, 0))
