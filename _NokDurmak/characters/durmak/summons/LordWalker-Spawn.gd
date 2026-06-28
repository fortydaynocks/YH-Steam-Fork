extends "res://_NokDurmak/characters/durmak/summons/WalkerState.gd"

func _frame_0():
	host.play_sound("Spawn")
	host.play_sound("Spawn2")
	host.play_sound("Spawn3")
	
	host.spawn_particle_effect_relative(preload("res://_NokDurmak/characters/durmak/effects/DM-EyeFlash.tscn"), Vector2(0, -18))

func _tick():
	._tick()
	
	if current_tick <= 10:
		host.global_hitlag(1)
