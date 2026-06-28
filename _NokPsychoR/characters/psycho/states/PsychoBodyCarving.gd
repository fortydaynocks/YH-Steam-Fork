extends "res://_NokPsychoR/characters/psycho/states/PsychoState.gd"

func _frame_3():
	var dist = (float(data.x) / 100) * 14
	
	host.start_projectile_invulnerability()
	host.apply_force(str(dist), "0")
	host.apply_force_relative("21", "0")
	

func _frame_15():
	host.end_projectile_invulnerability()

func _tick():
	._tick()
	
	host.afterimage(Color(1, 0, 0, 0.5), 0.1)
