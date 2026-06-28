extends "res://_NokSnowdancer/characters/snowdancer/states/SnowdancerState.gd"

var max_floor_dist = 70

func is_usable():
	return .is_usable() and int(host.get_pos().y) >= -max_floor_dist

func _tick():
	._tick()
	
	if current_tick in [2, 3, 4, 5, 6, 7]:
		host.move_directly_relative("1", "12")
		
		if current_tick % 2 == 0:
			host.afterimage(Color(0.8, 0.86, 0.99, 0.2), 0.05)
