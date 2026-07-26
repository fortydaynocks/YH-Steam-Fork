extends "res://_NokVenerator/venerator/states/VN-State.gd"

var force = 1.5
var launch = 32

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
	
	if current_tick < 13:
		host.apply_force(str(vec.x * force), str(vec.y * force))
		host.afterimage(Color("#f0b541"), 0.1)
		
	if current_tick == 13:
		host.reset_momentum()
		
		host.apply_force_relative("32", "0")
		host.apply_forces_no_limit()
		
		
