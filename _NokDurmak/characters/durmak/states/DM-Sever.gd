extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

var speed = 15

func _tick():
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	
	if current_tick in [4, 5, 6, 7, 8]:
		if not host.reverse_state:
			var mov = clamp(opos.x - pos.x, -speed, speed)
			host.move_directly(str(mov), "0")
