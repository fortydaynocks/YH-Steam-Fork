extends "res://_NokSkullmage/characters/skullmage/states/SK-State.gd"

var chase = 20

func _frame_6():
	if data == true:
		host.move_directly_relative("25", "0")
		
	else:
		host.move_directly_relative("125", "0")

	if host.is_grounded() == false:
		var y_diff = host.opponent.get_pos().y - host.get_pos().y
		host.move_directly_relative(str(clamp(y_diff, -chase, chase)), "0")
	
	#	--
	host.spawn_particle_effect_relative(preload("res://_NokSkullmage/characters/skullmage/effects/SK-Blink.tscn"), Vector2(0, -18))
	host.afterimage(Color("#9c85cc"), 0.5)

func _frame_7():
	host.update_facing()
