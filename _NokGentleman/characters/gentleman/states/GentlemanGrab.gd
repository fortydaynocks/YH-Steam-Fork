extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

var default_lag = 3
var lag = 0

func _enter():
	._enter()
	
	if data == true:
		lag = default_lag
	else:
		lag = 0
	
func _frame_1():
	if data == true and lag == default_lag:
		host.apply_force_relative("10", "0")

func _tick():
	._tick()
	
	if current_tick >= 1:
		if lag > 0 and data == true:
			current_tick -= 1
			lag -= 1
