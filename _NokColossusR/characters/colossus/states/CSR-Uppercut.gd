extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

func _tick():
	._tick()
	
	#	--
	if data == true:
		if current_tick in [2, 3, 4]:
			host.move_directly_relative("10", "0")
			host.afterimage(host.extra_color_2, 0.05)
