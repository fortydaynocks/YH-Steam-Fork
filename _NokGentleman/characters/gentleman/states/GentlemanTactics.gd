extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func _enter():
	._enter()

	if data.x == 0 and data.y == 0:
		host.change_state("tacticsN")
		
	elif data.x == host.get_facing_int() and data.y == -1:
		host.change_state("tacticsU")
		
	elif data.x == host.get_facing_int() and data.y == 0:
		host.change_state("tacticsF")
		
	elif data.x == host.get_facing_int() and data.y == 1:
		host.change_state("tacticsD")
		
	else:
		host.change_state("Wait")
