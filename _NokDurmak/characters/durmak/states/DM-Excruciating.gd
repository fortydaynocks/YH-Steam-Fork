extends "res://_NokDurmak/characters/durmak/states/DM-State.gd"

func is_usable():
	var moves_used = host.combo_moves_used.keys()
	
	return .is_usable() and (not self.state_name in moves_used)

func _on_hit_something(obj, hitbox):
	._on_hit_something(obj, hitbox)

	var fac = host.get_facing_int()
	host.spawn_particle_effect_relative(preload("res://_NokDurmak/characters/durmak/effects/DM-BloodShot.tscn"), Vector2(30, -18), Vector2(fac, 0))

func _frame_1():
	host.reset_momentum()
	host.apply_force_relative("-20", "0")
	
	var fac = host.get_facing_int()
	host.spawn_particle_effect_relative(preload("res://fx/DashFloorParticle.tscn"), Vector2(), Vector2(-fac, 0))

func _tick():
	._tick()
	
	if current_tick in [3, 4, 5, 6]:
		host.global_hitlag(1)
	
	if current_tick in [6, 7, 8]:
		host.move_directly_relative("40", "0")
		host.apply_force_relative("4", "0")
		
	if current_tick >= 10:
		host.global_hitlag(1)
