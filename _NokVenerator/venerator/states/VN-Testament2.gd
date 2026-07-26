extends "res://_NokVenerator/venerator/states/VN-State.gd"

onready var hbox = $Hitbox

func _frame_0():
	host.start_invulnerability()
	host.opponent.change_state("Grabbed")
	
	host.apply_force_relative("60", "-5")
	host.apply_forces_no_limit()
	
func _frame_15():
	host.play_sound("Shine")
	host.spawn_particle_effect_relative(
		preload("res://_NokVenerator/venerator/effects/VN-Star3.tscn"),
		Vector2(22, -60)
	)
	
func _frame_30():
	host.gain_blessing()
	host.release_opponent()
	
	host.apply_force_relative("-10", "0")
	host.apply_forces_no_limit()

func _tick():
	._tick()
	
	if current_tick < 30:
		host.global_hitlag(1)
		
	if current_tick >= 30:
		host.apply_grav()
