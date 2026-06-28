extends "res://_NokDeoR/characters/deo/projectiles/DeoRStandDefault.gd"

var dash_end = 6
var move_speed = 20

func _frame_0():
	
	if data.get("pilot"):
		host.play_sound("Target")
		
		var dir = xy_to_dir(data.pilot.x, data.pilot.y, str(move_speed * dash_end))
		var spawn_pos = Vector2(dir.x, dir.y)
		spawn_pos.x *= host.get_facing_int()
		spawn_pos.y -= 18
		host.spawn_particle_effect_relative(preload("res://_NokDeoR/characters/deo/effects/DEOR-StandTarget.tscn"), spawn_pos)
		

func _tick():
	._tick()
	
	if data:
		var dir = xy_to_dir(data.pilot.x, data.pilot.y, str(move_speed))
		host.move_directly(dir.x, dir.y)
	
		if current_tick >= dash_end or (data.pilot.x == 0 and data.pilot.y == 0):
			host.change_state(data.state)
