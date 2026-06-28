extends "res://_NokDeoR/characters/deo/states/DeoR-State.gd"


var falling = false

func _enter():
	._enter()
	
	falling = false

func _tick():
	._tick()

	if "Aerial" in self.editor_description:
		if current_tick == 6:
			if not host.is_grounded():
				current_tick -= 1
				
				if not falling:
					falling = true
					
					host.spawn_particle_effect_relative(preload("res://_NokDeoR/characters/deo/effects/DEOR-Ring1.tscn"),
					Vector2(0, -18))
				
				if not host.reverse_state:
					var dist = host.get_opponent().get_pos().x - host.get_pos().x
					host.move_directly(str(clamp(dist, -5, 5)), "0")
				
				host.apply_force_relative("0", "6")
				
			else:
				current_tick = 7
				
			if current_tick == 9:
				host.reset_momentum()
				host.apply_force_relative("4", "0")
				
	else:
		if current_tick in [5, 6, 7, 8]:
			host.global_hitlag(1)
		
	if current_tick == 9:
		if self.hit_fighter == false:
			host.global_hitlag(4)
