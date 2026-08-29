extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

export (PackedScene) var decimator

func _enter():
	._enter()

	host.spawn_particle_effect_relative(preload("res://_NokGorenShin/characters/shingoren/effects/SG_Pushblock.tscn"), Vector2(0, -18))	
	host.play_sound("SF3Super")

func _frame_10():
	var dir = xy_to_dir(data.x, data.y, "5")
	var obj = host.spawn_object(decimator, 24, -24, true, null, true)
	obj.set_grounded(false)
	obj.apply_force(dir.x, dir.y)
	
	if host.buffers.Firewalk:
		host.firewalk.Value -= 1
		obj.marked = true

func _tick():
	._tick()
	
	if current_tick and current_tick <= 10:
		host.global_hitlag(1)
