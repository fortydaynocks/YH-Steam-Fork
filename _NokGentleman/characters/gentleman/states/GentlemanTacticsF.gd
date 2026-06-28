extends "res://_NokGentleman/characters/gentleman/states/GentlemanState.gd"

var threshold = 6.5
var multiplier = 7
var cap = 100

func _frame_6():
	
	var chase_speed = float(host.opponent.get_vel().x) * host.get_facing_int()
	if chase_speed >= threshold:
		host.move_directly_relative(str(clamp(chase_speed * multiplier, 0, cap)), "0")
		
		host.afterimage(host.colors_table.MainColor, 0.2)
		host.spawn_particle_effect_relative(host.vfx_table.Landing, Vector2(0, 0))
		host.play_sound("TacticsFWarp")
		
		host.global_hitlag(6)
