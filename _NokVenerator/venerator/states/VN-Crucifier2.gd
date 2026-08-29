extends "res://_NokVenerator/venerator/states/VN-State.gd"

var wave = preload("res://_NokVenerator/venerator/projectiles/CrucifierWave.tscn")

func _frame_0():
	host.start_invulnerability()
	host.opponent.change_state("Grabbed")
	
	host.apply_force_relative("8", "-4")

func _frame_13():
	host.play_sound("Crucifier1")

func _frame_17():
	host.release_opponent()
	
func _frame_29():
	host.play_sound("Crucifier2")
	
func _frame_33():
	host.apply_force_relative("-4", "0")
	
func _frame_35():
	var proj = host.spawn_object(wave, 24, -26, true, null, true)
	proj.set_grounded(false)
	proj.set_facing(host.get_facing_int())
	proj.apply_force_relative("8", "0")

func _tick():
	._tick()
	
	if current_tick < 10:
		host.apply_force_relative("0", "-0.4")
		
	if current_tick in [30, 31, 32, 33]:
		host.global_hitlag(2)
