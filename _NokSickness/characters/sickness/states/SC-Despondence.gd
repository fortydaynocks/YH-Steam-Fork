extends "res://_NokSickness/characters/sickness/states/SC-State.gd"

var speed = 0.5

func _tick():
	._tick()
	
	if current_tick < 13:
		var pos = host.get_pos()
		var opos = host.opponent.get_pos()
		var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
		if host.is_grounded() == true: vec.y = 0
		
		host.apply_force(str(vec.x * speed), str(vec.y * speed))
		
	#if current_tick % 2 == 0:
		#host.afterimage(Color(0.8, 0.86, 0.99, 0.2), 0.15)
