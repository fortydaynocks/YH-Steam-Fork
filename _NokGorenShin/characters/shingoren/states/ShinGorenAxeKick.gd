extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var max_dist = 20

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	
	if not host.is_grounded():
		if current_tick == 7:
			current_tick = 6
		
		if current_tick < 9:
			host.apply_force("0", "3")
	
	if current_tick in [6, 7]:
		if host.is_grounded() and (not host.reverse_state):
			var dist = clamp(abs(opos.x - pos.x), 0, max_dist)
			
			host.move_directly_relative(str(dist), "0")
