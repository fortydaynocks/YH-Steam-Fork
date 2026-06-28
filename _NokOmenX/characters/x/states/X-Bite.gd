extends "res://_NokOmenX/characters/x/states/X-State.gd"

var speed = 2

func _tick():
	._tick()
	
	if current_tick < 12:
		var pos = host.get_pos()
		var opos = host.opponent.get_pos()
		var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
		if host.is_grounded() == true: vec.y = 0
		
		host.apply_force(str(vec.x * speed), str(vec.y * speed))
