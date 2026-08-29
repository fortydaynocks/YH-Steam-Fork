extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

func _frame_1():
	if "Aerial" in self.editor_description:
		if data == true:
			host.apply_force_relative("2", "-4")
		else:
			host.apply_force_relative("2", "6")

func _frame_6():
	if !"Aerial" in self.editor_description:
		if data == true:
			host.apply_force_relative("2", "-8")
		else:
			host.apply_force_relative("8", "-4")

func _tick():
	._tick()
	
	if "Aerial" in self.editor_description and current_tick < 18:
		if host.is_grounded() == true:
			var vel = host.get_vel()
			
			host.reset_momentum()
			host.set_vel(vel.x, "-8")
			
			host.spawn_particle_effect_relative(particle_scene, Vector2(0, 0))
			host.play_sound("Block")
			
			host.move_directly_relative("0", "-1")
