extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

var dist = 100

func _frame_13():
	var dir = (float(data.x) / 100) * dist
	dir += dist
	
	host.spawn_quake_limited(dir)

func on_got_blocked():
	.on_got_blocked()
	
	host.opponent.apply_force_relative("2", "-5")

func _tick():
	._tick()
	
	if "Aerial" in self.editor_description:
		if host.is_grounded() == false:
			host.apply_force_relative("0", "2")
			
			if current_tick >= 11:
				current_tick -= 1
	
	if current_tick in [9, 10, 11, 12] and host.is_grounded() == true:
		host.global_hitlag(2)
