extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _frame_5():
	var dist = data["Distance"].x + 25
	
	if dist < 0:
		self.backdash_iasa = true
	
	host.reset_momentum()
	host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18))
	
	host.move_directly_relative(str(dist * 0.9), "0")
	
	if data["Adjust"] == true:
		host.move_directly_relative("0", "70")
	
func _frame_6():
	host.spawn_particle_effect_relative(particle_scene, Vector2(0, -18))
	host.apply_force_relative(str((data["Distance"].x + 25) / 35), "0")

func _frame_9():
	if host.combo_count >= 1:
		self.enable_interrupt()
