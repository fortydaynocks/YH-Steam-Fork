extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

var initial_dist = 4
var speed = 12

func _frame_1():
	print(data)
	
	var fac = host.get_facing_int()
	var dist = ((float(data.x) / 100) * speed) + (initial_dist * fac)
	host.apply_force(str(dist), "0")
		
	if dist * fac >= 0:
		anim_name = "DashForward"
	else:
		anim_name = "DashBackward"
		
	self.backdash_iasa = (dist * fac <= -((speed - initial_dist) / 2))
	
	#	--
	host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2(0, 0))
	
	if (dist + 2) * fac >= 0:
		anim_name = "DashForward"
		host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(fac, 0))
	else:
		anim_name = "DashBackward"
		host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(0, 0), Vector2(-fac, 0))
