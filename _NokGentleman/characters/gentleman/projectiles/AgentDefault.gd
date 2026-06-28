extends "res://_NokGentleman/characters/gentleman/projectiles/AgentState.gd"

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.get_owner().opponent.get_pos()
	
	if abs(opos.x - pos.x) > host.chase_radius:
		host.change_state("run")
