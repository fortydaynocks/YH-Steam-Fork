extends ObjectState

var particle = preload("res://_NokPsychoR/characters/psycho/effects/PsychoStain.tscn")

func _tick():
	._tick()
	
	if current_tick % 2 == 0:
		host.spawn_particle_effect_relative(particle, Vector2(0, 0))
