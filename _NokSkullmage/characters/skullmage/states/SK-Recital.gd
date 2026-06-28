extends "res://_NokSkullmage/characters/skullmage/states/SK-State.gd"

func _frame_0():
	host.play_sound("Recital")
	if self._previous_state_name() != self.state_name:
		host.play_sound("Recital2")
		
	
	host.spawn_particle_effect_relative(preload("res://_NokSkullmage/characters/skullmage/effects/SK-Recital.tscn"), Vector2(4, -44))
	host.afterimage(Color("#9c85cc"), 0.1)
