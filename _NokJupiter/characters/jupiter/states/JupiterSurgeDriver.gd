extends "res://_NokJupiter/characters/jupiter/states/JupiterState.gd"

func _frame_10():
	host.apply_force_relative("12", "0")
	
func _tick():
	._tick()
	
	if current_tick in [10, 11, 12, 13, 14]:
		host.move_directly_relative("20", "0")
			
		#	--
		
	if current_tick % 2 == 0:
		host.afterimage(host.stuff.colors.Charge2, 0.1)
