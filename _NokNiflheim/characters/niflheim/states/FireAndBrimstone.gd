extends SuperMove

export (PackedScene) var brimstone_death_scene

#	--

func _frame_8():
	host.reset_momentum()
	var dir = xy_to_dir(data.x, data.y, "8")
	
	var x = int(dir.x)
	var y = 2 * int(dir.y)
	
	host.apply_force(x, y)
	
func _frame_20():
	host.reset_momentum()
	host.apply_force(-2, -2)
	
func _frame_22():
	var dir = xy_to_dir(data.x, data.y, "8")
	
	var x = int(dir.x)
	var y = 4 * int(dir.y)
	
	host.play_sound("MetalRingLoud")
	var bds = host.spawn_object(brimstone_death_scene, 0, -18, true, {"dir": -60 - y})
	
