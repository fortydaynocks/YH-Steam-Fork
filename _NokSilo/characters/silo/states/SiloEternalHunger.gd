extends "res://_NokSilo/characters/silo/states/SiloState.gd"

var spread = 30
var spawn_vec = Vector2(0, 0)
var spawn_dist = 50

func _enter():
	._enter()
	
	var dir = xy_to_dir(data.x, data.y, str(spawn_dist))
	spawn_vec = Vector2(float(dir.x), float(dir.y))

func _frame_6():
	host.start_projectile_invulnerability()
	
	if host.is_grounded() == true:
		host.apply_force_relative("0", "-4")

func _tick():
	._tick()
	
	if current_tick in [6, 8, 10, 12, 14, 16]:
		var dir = xy_to_dir(data.x, data.y, str(spawn_dist))
		
		var obj = host.spawn_object(
			host.objs_table.Sustainer, 
			spawn_vec.x + host.randi_range(-spread, spread),
			(spawn_vec.y - 18) + host.randi_range(-spread, spread),
			false, null, true
			)
		host.sustainers.append(obj.obj_name)
		obj.spawn_particle_effect_relative(host.vfx_table.Harvest, Vector2(0, 0))
		
		spawn_vec += Vector2(float(dir.x), float(dir.y))
