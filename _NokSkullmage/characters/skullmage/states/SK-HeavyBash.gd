extends "res://_NokSkullmage/characters/skullmage/states/SK-State.gd"

var chase_force = 4

func _frame_1():
	host.apply_force_relative("0", "-6")
	host.move_directly_relative("0", "-15")
	
	host.afterimage(Color("#9c85cc"), 0.5)
	host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2())
	
#func _frame_4():
	#host.apply_force_relative("-2", "0")

#func _frame_10():
	#host.apply_force_relative("8", "0")

func _frame_12():
	host.spawn_particle_effect_relative(preload("res://characters/robo/GroundSlamEffect.tscn"), Vector2(40, 0))

func _tick():
	._tick()
	
	var offset = host.opponent.get_pos().x - host.get_pos().x
	
	if current_tick > 2 and current_tick <= 10:
		host.apply_force_relative("0", "1")
		host.apply_forces_no_limit()
		host.move_directly(str(clamp(offset, -chase_force, chase_force)), "0")
		
		if host.current_tick % 2 == 0:
			host.afterimage(Color("#9c85cc"), 0.1)
	
	if current_tick == 10:
		if host.is_grounded() == true:
			current_tick += 1
		else:
			current_tick -= 1
			
	if current_tick in [6, 7]:
		host.global_hitlag(1)
			
	
	#if current_tick in [3, 4]:
		#host.move_directly_relative("-15", "0")
	
	#if current_tick in [5, 6, 7, 8]:
		#host.global_hitlag(1)
		
	#if current_tick in [9, 10]:
		#host.move_directly_relative("25", "0")
	
	
