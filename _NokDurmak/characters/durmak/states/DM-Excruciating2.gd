extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

func _frame_0():
	host.start_invulnerability()
	
	host.opponent.change_state("Grabbed")
	host.opponent.rumble(0.5, 20)
	host.apply_force_relative("40", "0")

func _frame_16():
	host.apply_force_relative("-8", "0")

func _frame_18():
	host.release_opponent()
	
	var fac = host.get_facing_int()
	host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(), Vector2(-fac, 0))
	host.spawn_particle_effect_relative(preload("res://_NokDurmak/characters/durmak/effects/DM-BloodShot.tscn"), Vector2(25, -18), Vector2(-fac, 0))

func _tick():
	._tick()
	
	if current_tick < 16:
		host.global_hitlag(2)
		
	if current_tick < 19:
		host.opponent.can_update_sprite = false
		host.opponent.sprite.animation = "HurtGroundedHigh"
