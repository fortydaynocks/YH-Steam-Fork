extends "res://_NokVenerator/venerator/states/VN-State.gd"

var raw = false
var force = 1

func is_usable():
	return .is_usable() and host.blessings.value >= 3

func _frame_0():
	host.reset_blessings()
	raw = host.combo_count < 1
	

func _frame_16():
	host.spawn_particle_effect_relative(
		preload("res://_NokVenerator/venerator/effects/VN-Star4.tscn"),
		Vector2(0, -24)
	)
	
	host.play_sound("EraOrder")
	host.play_sound("EraOrder2")

func _frame_17():
	host.afterimage(Color("#f0b541"), 0.1)

func _tick():
	._tick()
	
	var pos = host.get_pos()
	var opos = host.opponent.get_pos()
	var vec = Vector2(opos.x - pos.x, opos.y - pos.y).normalized()
	
	if current_tick < 17:
		host.apply_force(str(vec.x * force), str(vec.y * force))
		
	host.global_hitlag(1)

#func _frame_5():
	#	--	THIS IS JUST A TEST STATE. THE MAIN CHARACTER STATES WILL BE CLEANED UP LATER.
	
	
