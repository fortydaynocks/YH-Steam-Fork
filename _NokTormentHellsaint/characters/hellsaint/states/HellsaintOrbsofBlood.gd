extends "res://_NokTormentHellsaint/characters/hellsaint/states/HellsaintState.gd"

func _frame_7():
	host.play_sound("void05")
	
func _frame_8():
	var dir = xy_to_dir(data.x, data.y, "8")
	
	var obj1 = host.spawn_object(preload("res://_NokTormentHellsaint/characters/hellsaint/projectiles/BloodOrb.tscn"), 16, -32, false, null, true)
	obj1.set_grounded(false)
	obj1.apply_force(dir.x, dir.y)
