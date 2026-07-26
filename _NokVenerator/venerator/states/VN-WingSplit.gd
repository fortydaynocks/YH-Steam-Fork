extends "res://_NokVenerator/venerator/states/VN-State.gd"

var speed = 15

func _tick():
	._tick()
	
	if !host.reverse_state:
		if current_tick in [8, 9, 10, 11]:
			var pos = host.get_pos()
			var opos = host.opponent.get_pos()
			var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
			
			host.move_directly(str(vec.x * speed), str(vec.y * speed))
			
			#	--
			host.afterimage(Color("#ff8933"), 0.1)
			host.afterimage(Color("#ffee83"), 0.05)

		if current_tick in [7, 11]:
			host.spawn_particle_effect_relative(
				preload("res://_NokVenerator/venerator/effects/VN-Star2.tscn"),
				Vector2(0, -18)
			)
