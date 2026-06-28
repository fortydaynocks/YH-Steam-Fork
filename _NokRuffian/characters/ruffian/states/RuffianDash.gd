extends "res://_NokRuffian/characters/ruffian/states/RuffianState.gd"

func _frame_1():
	var dist = (float(data.x) / 100) * 13
	
	host.apply_force_relative("3", "0")
	host.apply_force(str(dist), "0")
	
	#	--
	
	var fac = host.get_facing_int()
	
	if (dist + 2) * fac >= 0:
		anim_name = "DashForward"
		host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(fac, 0))
	else:
		anim_name = "DashBackward"
		host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(-fac, 0))

func _tick():
	._tick()
	
	if current_tick in [1, 4, 7, 10]:
		var fac = host.get_facing_int()
		var vel = Vector2(float(host.get_vel().x), float(host.get_vel().y))
		host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18), vel.normalized())
