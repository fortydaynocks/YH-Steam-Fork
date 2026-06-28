extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var spawn_range = 175

func _frame_4():
	if host.objs_map.get(host.active_mark):
		host.objs_map[host.active_mark].disable()
	
	var dir = xy_to_dir(data.x, data.y, str(spawn_range))
	
	var obj = host.spawn_object(preload("res://_NokGorenShin/characters/shingoren/projectiles/OnisMark.tscn"), int(dir.x), int(dir.y) - 18, false, null, true)
	obj.set_grounded(false)
	
	obj.play_sound("Spawn")
	obj.play_sound("Spawn2")
	obj.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Hit3.tscn"), Vector2(0, 0))
	obj.sprite.material = host.sprite.material
	
	host.active_mark = obj.obj_name

func _tick():
	._tick()
	
	if current_tick % 6 == 1:
		host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Smoke2.tscn"), Vector2(0, 0), Vector2(1, 0))
		host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Smoke2.tscn"), Vector2(0, 0), Vector2(-1, 0))
