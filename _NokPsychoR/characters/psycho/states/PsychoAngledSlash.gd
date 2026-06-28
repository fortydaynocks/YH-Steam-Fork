extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

func _enter():
	._enter()
	
	self.land_cancel = false

func _frame_2():
	var dir = xy_to_dir(data.x, data.y, "5")
	host.apply_force(dir.x, dir.y)

func _frame_7():
	host.afterimage(Color(1, 0, 0, 0.75), 0.1)
	host.spawn_particle_effect_relative(preload("res://_NokPsychoR/characters/psycho/effects/PsychoLethalSlash.tscn"), Vector2(0, -18), Vector2(host.get_facing_int(), 1))
	
	host.reset_momentum()
	host.move_directly_relative("20", "20")
	host.apply_force_relative("5", "5")
	
func _frame_9():
	host.afterimage(Color(1, 0, 0, 0.75), 0.1)
	host.move_directly_relative("20", "20")

	self.land_cancel = true
