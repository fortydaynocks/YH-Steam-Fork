extends "res://_NokBetrayer/characters/betrayer/states/BetrayerState.gd"

func _frame_0():
	host.start_invulnerability()

func _frame_46():
	host.apply_force_relative("6", "-16")
	
func _frame_65():
	host.play_sound("IntroBellQ")
	host.play_sound("IntroAmbience")
	host.spawn_particle_effect_relative(host.vfx_table.Landing, Vector2(0, 0))
	host.spawn_particle_effect_relative(host.vfx_table.FloorIntro, Vector2(0, 0))
	
func _tick():
	._tick()
	
	if current_tick == 62 and host.is_grounded() == false:
		host.apply_force_relative("0.5", "3")
		current_tick -= 1
