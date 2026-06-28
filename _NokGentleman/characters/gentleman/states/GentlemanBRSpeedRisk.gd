extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

func _tick():
	._tick()
	
	if current_tick % 2 == 0:
		host.apply_force_relative("3", "0")
		
		host.afterimage(Color(0.9, 0.9, 1, 0.25), 0.1)
		
	if current_tick % 4 == 0:
		var fac = host.get_facing_int()
		var vel = Vector2(float(host.get_vel().x), float(host.get_vel().y))
		host.spawn_particle_effect_relative(particle_scene, Vector2(0, 0), vel.normalized())
	
	if current_tick % 6 == 0:
		host.play_sound("spin")
