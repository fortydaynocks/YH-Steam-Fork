extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

var max_force = 12

func _frame_1():
	var opos = host.opponent.get_pos()
	var pos = host.get_pos()
	var dist = opos.x - pos.x
	dist = (clamp(dist / 10.0, -max_force, max_force))
	
	host.apply_force(str(dist), "0")

func _frame_6():
	#var dir = xy_to_dir(data.x, data.y, "4")
	
	host.reset_momentum()
	host.move_directly_relative("9", "-27")
	host.apply_force_relative("3", "-9")
	#host.apply_force(dir.x, dir.y)
	
	if host.is_grounded() == true:
		host.spawn_particle_effect_relative(preload("res://fx/LandingParticle.tscn"), Vector2(0, 0))

func _tick():
	._tick()
	
	host.afterimage(host.extra_color_1, 0.05)
