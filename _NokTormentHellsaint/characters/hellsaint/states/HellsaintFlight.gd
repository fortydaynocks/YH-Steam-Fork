extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func is_usable():
	return .is_usable() and (host.air_option_bar / host.air_option_bar_max) >= 0.75
func _frame_2():
	var dist = (data["Distance"].x / 100) * 8

	host.spawn_particle_effect_relative(preload("res://_NokTormentHellsaint/characters/hellsaint/effects/THS_Hit2.tscn"), Vector2(0, -18))
	host.apply_force_relative("3", "0")
	host.apply_force(str(dist), "0")
	
func _frame_5():
	var vel = host.get_vel()
	host.set_vel(str(vel.x), "0")
	host.apply_force_relative("0", "-5")
	
func _frame_11():
	host.flight = true
	
func _tick():
	._tick()
	
	interruptible_on_opponent_turn = (current_tick >= 11)
