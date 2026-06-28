extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _frame_2():
	host.apply_force_relative("8", "0")
	
func _frame_8():
	host.reset_momentum()
	host.apply_force_relative("12", "0")
	
func _frame_9():
	host.move_directly_relative("100", "0")
	
	host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18))
	host.play_sound("heartbeat")

func _tick():
	._tick()
	
	host.afterimage2(Color(1, 0, 0.27), 0.1)
	
	if current_tick >= 11:
		host.global_hitlag(1)
