extends "res://_NokGentleman/characters/gentleman/projectiles/AgentState.gd"

func _enter():
	._enter()
	
	if data and host.state_machine.get_state(data):
		if host.state_machine.get_state(data).get("instant") == true:
			host.change_state(data)

func _tick():
	._tick()
	
	if not data:
		host.change_state("Default")
		
	else:
		if host.get_owner().was_my_turn or host.get_owner().opponent.was_my_turn:
			host.change_state(data)
