extends "res://_NokVenerator/venerator/states/VN-State.gd"

var default_lag = 3
var lag = 0

func _frame_0():
	if data["Dash"] == true:
		lag = default_lag
	else:
		lag = 0
	
func _frame_1():
	if data["Dash"] == true:
		host.apply_force_relative("10", "0")

func _tick():
	._tick()
	
	if current_tick >= 1:
		if lag > 0:
			current_tick -= 1
			lag -= 1
