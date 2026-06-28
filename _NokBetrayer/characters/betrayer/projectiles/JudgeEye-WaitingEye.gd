extends "res://_NokBetrayer/characters/betrayer/projectiles/JudgeEyeDefault.gd"

var chase_speed = 0.5

func _tick():
	._tick()
	
	if current_tick >= lifetime:
		host.disable()
		return
	
	if not host.get_owner().knight.NextKnightBuffer:
		host.disable()
		return
	
	if current_tick % 4 == 0:
		host.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTStar2.tscn"), Vector2(0, 0))
		
