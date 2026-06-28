extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _frame_1():
	if $"%Stuff".skin == "Camila":
		host.play_sound("CA_Ghost3")

func _frame_7():
	host.afterimage2(Color(1, 0, 0.27), 0.5)

func _frame_9():
	var dist = (float(data.x) / 100) * 30
	
	host.move_directly_relative("50", "0")
	host.move_directly_relative(str(dist), "0")
	
	host.reset_momentum()
	host.apply_force_relative("12", "0")
	host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18))
	
func _frame_10():
	host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18))

func _tick():
	._tick()
	
	if current_tick >= 16 and host.counterhit_this_turn == true:
		host.change_state("comehere_rejection-free", {"CounterhitDevilKick": true})
