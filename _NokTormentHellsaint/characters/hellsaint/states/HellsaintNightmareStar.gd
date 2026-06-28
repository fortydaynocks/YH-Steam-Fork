extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

#	4, -118

export (PackedScene) var star

func _frame_1():
	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Ghost1")

func _frame_2():
	var dir = xy_to_dir(data.x, data.y, "20")
	host.apply_force(dir.x, dir.y)
	
func _frame_24():
	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Ghost4")
	
	var obj = host.spawn_object(star, 6, -162, true, null, true)
	obj.set_grounded(false)
	obj.set_facing(host.get_facing_int())
	obj.apply_force_relative("5", "5")
	
func _tick():
	._tick()
	
	if current_tick <= 25:
		host.global_hitlag(1)
		
		if current_tick % 3 == 0:
			host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18))

	if current_tick <= 15:
		host.opponent.hitlag_ticks = 1
