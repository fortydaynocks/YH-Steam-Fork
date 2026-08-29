extends "res://_NokVenerator/venerator/states/VN-State.gd"

func _frame_0():
	host.global_hitlag(4)
	
	if self._previous_state().data.get("Throw"):
		host.set_facing(self._previous_state().data.Throw.x)

func _frame_1():
	host.apply_force_relative("4", "0")

func _frame_19():
	host.apply_force_relative("6", "0")
	
	host.release_opponent()
	
func _tick():
	._tick()
	
	if self._previous_state().data.get("Throw") and self._previous_state().data.Throw.y == 1:
		if current_tick < 20:
			host.apply_force_relative("0", "1")
			
		if current_tick == 20:
			if self._previous_state().air_type == 1:
				host.opponent.apply_force_relative("0", "10")
