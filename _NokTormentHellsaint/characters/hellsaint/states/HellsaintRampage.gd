extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

var array = preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/Array.tscn")

func _frame_1():
	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Ghost3")		

func _frame_4():
	host.start_projectile_invulnerability()
	
func _frame_9():
	var proj = host.spawn_object(array, 70, 0, true, null, true)
	proj.set_grounded(true)
	proj.set_facing(1)
	proj.set_pos(str(proj.get_pos().x), "0")
	
func _frame_20():
	host.end_projectile_invulnerability()

func _tick():
	._tick()
	
	if host.reverse_state == false:
		if current_tick == 2:
			host.apply_force_relative("-8", "0")
		if current_tick == 10:
			host.apply_force_relative("50", "0")
	else:
		if current_tick == 1:
			host.afterimage()
			host.super_effect(1)
			host.spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Super.tscn"), Vector2(0, -18))
		if current_tick == 2:
			host.apply_force_relative("-32", "0")
		if current_tick == 10:
			host.apply_force_relative("50", "0")
	
	if current_tick >= 10 and current_tick < 20:
		host.afterimage2(Color(1, 0, 0.27), 0.1)
