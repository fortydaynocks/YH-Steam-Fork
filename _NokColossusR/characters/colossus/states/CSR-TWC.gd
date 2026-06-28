extends "res://_NokColossusR/characters/colossus/states/CSR-State.gd"

func on_got_blocked():
	.on_got_blocked()
	
	host.opponent.apply_force_relative("-2", "-5")

func _tick():
	._tick()
	
	if "Aerial" in self.editor_description:
		if host.is_grounded() == false:
			host.apply_force_relative("0", "2")
			
			if current_tick >= 11:
				current_tick -= 1
	
	if current_tick < 15:
		host.global_hitlag(1)
		
		if int(host.distance_to(host.opponent)) > 100:
			host.apply_force_relative("0.75", "0")
		
