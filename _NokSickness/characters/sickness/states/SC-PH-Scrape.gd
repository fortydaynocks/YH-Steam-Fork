extends "res://_NokSickness/characters/sickness/states/SC-State.gd"

var speed = 7.5

func _frame_8():
	host.end_invulnerability()
	host.reset_momentum()
	
	host.apply_force_relative("-8", "0")

func _tick():
	._tick()
	
	if current_tick < 8 and !host.reverse_state:
		var pos = host.get_pos()
		var opos = host.opponent.get_pos()
		var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
		if host.is_grounded() == true: vec.y = 0
		
		host.move_directly(str(vec.x * speed), str(vec.y * speed))
