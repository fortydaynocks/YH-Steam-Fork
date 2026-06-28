extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

func _frame_2():
	host.apply_force_relative("30", "0")

	if self._previous_state_name() in ["hunt2", "hunt3"]:
		host.apply_force_relative("1", "0")
		
func _tick():
	._tick()
	
	if current_tick >= 4 and current_tick < 16:
		if current_tick % 3 == 0:
			host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(), Vector2(host.get_facing_int(), 0))
			host.play_sound("slide")
