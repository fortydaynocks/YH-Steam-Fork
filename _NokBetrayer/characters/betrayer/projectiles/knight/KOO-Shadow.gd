extends "res://_NokBetrayer/characters/betrayer/projectiles/knight/KOO-State.gd"

var shadow_blade = preload("res://_NokBetrayer/characters/betrayer/projectiles/ShadowBlade.tscn")

func _tick():
	._tick()
	
	if current_tick in [6, 11, 16]:
		host.play_sound("Spawn2")
		
		var pos = Vector2(host.get_pos().x, host.get_pos().y)
		var proj = host.get_owner().spawn_object(shadow_blade, pos.x + (18 * host.get_facing_int()), pos.y - 18, true, null, false)
	
		proj.set_grounded(false)
		
		proj.apply_force_relative(str((current_tick - 4) * 2), "-6")
		proj.spawn_particle_effect_relative(preload("res://_NokBetrayer/characters/betrayer/effects/BTHit1Weak.tscn"), Vector2(0, -18))
