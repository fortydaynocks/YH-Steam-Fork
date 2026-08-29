extends "res://_NokGorenShin/characters/shingoren/states/ShinGorenState.gd"

var force = 10

func _frame_6():
	var dir = xy_to_dir(data.x, data.y, "1")
	var vec = Vector2(dir.x, dir.y).normalized()
	var obj = host.spawn_object(preload("res://_NokGorenShin/characters/shingoren/projectiles/Shredder.tscn"), 24, -24, true, Vector2(dir.x, dir.y).length(), true)
	obj.set_grounded(false)
	obj.apply_force(str(vec.x * force), str(vec.y * force))
	
	if host.buffers.Firewalk:
		host.firewalk.Value -= 1
		obj.marked = true
