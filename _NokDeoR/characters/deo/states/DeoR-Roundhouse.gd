extends "res://_NokDeoR/characters/deo/states/DeoR-State.gd"

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.get_opponent().get_pos()
	
	if current_tick <= 5 and (not host.reverse_state):
		var force = 2 if pos.x <= opos.x else -2
		host.apply_force(str(force), "0")
